package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class LongestTurnCounter extends CounterLessThan
   {
       
      
      private var turnArray:Array;
      
      public function LongestTurnCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         turnArray = [];
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function get completed() : Boolean
      {
         return value <= targetValue;
      }
      
      override public function handleMatchEnded(msg:MatchEndedMessage) : void
      {
         var i:int = 0;
         var passingValue:int = 1;
         for(i = 0; i < turnArray.length; )
         {
            if(passingValue <= targetValue)
            {
               passingValue = int(turnArray[i]);
            }
            i++;
         }
         turnArray.splice(0,turnArray.length);
         if(passingValue <= targetValue)
         {
            updateValue(5,false);
         }
      }
      
      override protected function updateValue(amount:int, sendInBattleUpdate:Boolean = true) : void
      {
         var _loc3_:Boolean = false;
         if(amount != 0)
         {
            _loc3_ = completed;
            value = amount;
            LogUtils.log(toString() + " Updated.",this,0,"Challenges",false,false,false);
            var _loc4_:ChallengeManager = ChallengeManager;
            if(!tuxwars.challenges.ChallengeManager._instance)
            {
               tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
            }
            tuxwars.challenges.ChallengeManager._instance.sendCounterUpdate(new CounterUpdate(playerId,this,amount),sendInBattleUpdate);
            if(Config.debugMode && completed)
            {
               LogUtils.log(toString() + " Completed!",this,1,"Challenges",false,false,false);
            }
            challenge.notifyCounterStateChanged();
         }
      }
      
      override public function handleWeaponUsed(msg:ChallengeWeaponUsedMessage) : void
      {
         var timeUsed:int = 0;
         var _loc3_:* = msg.weapon.player;
         if(playerId == _loc3_._id)
         {
            timeUsed = BattleManager.getTurnDuration() - BattleManager.getTurnTimeLeft();
            turnArray.push(timeUsed * 0.001);
         }
      }
   }
}
