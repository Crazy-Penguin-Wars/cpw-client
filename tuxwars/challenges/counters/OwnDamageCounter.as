package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   import tuxwars.challenges.events.ChallengeTakeCollisionDamageMessage;
   
   public class OwnDamageCounter extends Counter
   {
       
      
      private var waitingForMatchToEnd:Boolean;
      
      public function OwnDamageCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
         waitingForMatchToEnd = challenge.scope == "Match";
      }
      
      override public function handleMatchEnded(msg:MatchEndedMessage) : void
      {
         waitingForMatchToEnd = false;
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = msg.firingPlayer;
         if(playerId == _loc3_._id)
         {
            _loc2_ = msg.affectedPlayers.indexOf(msg.firingPlayer);
            if(_loc2_ >= 0)
            {
               updateValue(msg.damageToGameObjects[_loc2_]);
            }
            else
            {
               LogUtils.log(toString() + " did not hurt self",this,0,"Challenges",false,false,false);
            }
         }
      }
      
      override public function handleTakeCollisionDamage(msg:ChallengeTakeCollisionDamageMessage) : void
      {
         if(msg.damagedObject is PlayerGameObject && msg.damageAmount > 0)
         {
            var _loc2_:* = msg.damagedObject as PlayerGameObject;
            if(playerId == _loc2_._id)
            {
               if(msg.playerTaggerOfObjectDoingDamage)
               {
                  var _loc3_:* = msg.playerTaggerOfObjectDoingDamage;
                  if(playerId == _loc3_._id)
                  {
                     updateValue(msg.damageAmount);
                  }
               }
               else
               {
                  updateValue(msg.damageAmount);
               }
            }
         }
      }
      
      override public function get completed() : Boolean
      {
         if(targetValue == 0)
         {
            if(waitingForMatchToEnd)
            {
               return false;
            }
            return value == 0;
         }
         return super.completed();
      }
      
      override public function get forceCounterUpdate() : Boolean
      {
         return true;
      }
   }
}
