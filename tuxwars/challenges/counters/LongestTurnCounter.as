package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.*;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class LongestTurnCounter extends CounterLessThan
   {
      private var turnArray:Array = [];
      
      public function LongestTurnCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function get completed() : Boolean
      {
         return value <= targetValue;
      }
      
      override public function handleMatchEnded(param1:MatchEndedMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 1;
         _loc2_ = 0;
         while(_loc2_ < this.turnArray.length)
         {
            if(_loc3_ <= targetValue)
            {
               _loc3_ = int(this.turnArray[_loc2_]);
            }
            _loc2_++;
         }
         this.turnArray.splice(0,this.turnArray.length);
         if(_loc3_ <= targetValue)
         {
            this.updateValue(5,false);
         }
      }
      
      override protected function updateValue(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:Boolean = false;
         if(param1 != 0)
         {
            _loc3_ = this.completed;
            value = param1;
            LogUtils.log(toString() + " Updated.",this,0,"Challenges",false,false,false);
            if(!ChallengeManager.instance)
            {
               ChallengeManager.instance = new ChallengeManager();
            }
            ChallengeManager.instance.sendCounterUpdate(new CounterUpdate(playerId,this,param1),param2);
            if(Config.debugMode && this.completed)
            {
               LogUtils.log(toString() + " Completed!",this,1,"Challenges",false,false,false);
            }
            challenge.notifyCounterStateChanged();
         }
      }
      
      override public function handleWeaponUsed(param1:ChallengeWeaponUsedMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = param1.weapon.player;
         if(playerId == _loc3_._id)
         {
            _loc2_ = BattleManager.getTurnDuration() - BattleManager.getTurnTimeLeft();
            this.turnArray.push(_loc2_ * 0.001);
         }
      }
   }
}

