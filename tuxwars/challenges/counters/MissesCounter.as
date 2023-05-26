package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class MissesCounter extends CounterLessThan
   {
       
      
      private var _invalidated:Boolean;
      
      public function MissesCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function reset() : void
      {
         super.reset();
         _invalidated = false;
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         var _loc2_:* = undefined;
         if(_invalidated)
         {
            return;
         }
         var _loc3_:* = msg.firingPlayer;
         if(playerId == _loc3_._id)
         {
            _loc2_ = msg.affectedPlayers;
            if(_loc2_.length > 0)
            {
               updateValue(-1);
            }
            else
            {
               invalidate();
               LogUtils.log(toString() + " player didnt hit opponent",this,0,"Challenges",false,false,false);
            }
         }
      }
      
      override public function get value() : int
      {
         return _invalidated ? targetValue + 1 : super.value;
      }
      
      public function get invalidated() : Boolean
      {
         return _invalidated;
      }
      
      public function invalidate() : void
      {
         _invalidated = true;
      }
      
      override public function get forceCounterUpdate() : Boolean
      {
         return true;
      }
   }
}
