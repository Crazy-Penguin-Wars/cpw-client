package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   import tuxwars.challenges.events.ChallengeTakeCollisionDamageMessage;
   
   public class OwnDamageCounter extends Counter
   {
      private var waitingForMatchToEnd:Boolean;
      
      public function OwnDamageCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
         this.waitingForMatchToEnd = param1.scope == "Match";
      }
      
      override public function handleMatchEnded(param1:MatchEndedMessage) : void
      {
         this.waitingForMatchToEnd = false;
      }
      
      override public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = param1.firingPlayer;
         if(playerId == _loc3_._id)
         {
            _loc2_ = int(param1.affectedPlayers.indexOf(param1.firingPlayer));
            if(_loc2_ >= 0)
            {
               updateValue(param1.damageToGameObjects[_loc2_]);
            }
            else
            {
               LogUtils.log(toString() + " did not hurt self",this,0,"Challenges",false,false,false);
            }
         }
      }
      
      override public function handleTakeCollisionDamage(param1:ChallengeTakeCollisionDamageMessage) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(param1.damagedObject is PlayerGameObject && param1.damageAmount > 0)
         {
            _loc2_ = param1.damagedObject as PlayerGameObject;
            if(playerId == _loc2_._id)
            {
               if(param1.playerTaggerOfObjectDoingDamage)
               {
                  _loc3_ = param1.playerTaggerOfObjectDoingDamage;
                  if(playerId == _loc3_._id)
                  {
                     updateValue(param1.damageAmount);
                  }
               }
               else
               {
                  updateValue(param1.damageAmount);
               }
            }
         }
      }
      
      override public function get completed() : Boolean
      {
         if(targetValue == 0)
         {
            if(this.waitingForMatchToEnd)
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

