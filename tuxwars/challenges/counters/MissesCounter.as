package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class MissesCounter extends CounterLessThan
   {
      private var _invalidated:Boolean;
      
      public function MissesCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function reset() : void
      {
         super.reset();
         this._invalidated = false;
      }
      
      override public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         var _loc2_:* = undefined;
         if(this._invalidated)
         {
            return;
         }
         var _loc3_:* = param1.firingPlayer;
         if(playerId == _loc3_._id)
         {
            _loc2_ = param1.affectedPlayers;
            if(_loc2_.length > 0)
            {
               updateValue(-1);
            }
            else
            {
               this.invalidate();
               LogUtils.log(toString() + " player didnt hit opponent",this,0,"Challenges",false,false,false);
            }
         }
      }
      
      override public function get value() : int
      {
         return !!this._invalidated ? targetValue + 1 : super.value;
      }
      
      public function get invalidated() : Boolean
      {
         return this._invalidated;
      }
      
      public function invalidate() : void
      {
         this._invalidated = true;
      }
      
      override public function get forceCounterUpdate() : Boolean
      {
         return true;
      }
   }
}

