package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.ChallengePlayerScoreChangedMessage;
   import tuxwars.utils.*;
   
   public class ReachFirstFromPositionInTime extends CounterLessThan
   {
      public function ReachFirstFromPositionInTime(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
         value = param3 + 1;
      }
      
      override protected function updateValue(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:Boolean = completed;
         value = param1;
         LogUtils.log(toString() + " Updated.",this,0,"Challenges",false,false,false);
         if(!ChallengeManager.instance)
         {
            ChallengeManager.instance = new ChallengeManager();
         }
         ChallengeManager.instance.sendCounterUpdate(new CounterUpdate(playerId,this,param1),param2);
         if(Config.debugMode && completed)
         {
            LogUtils.log(toString() + " Completed!",this,1,"Challenges",false,false,false);
         }
         if(_loc3_ != completed)
         {
            challenge.notifyCounterStateChanged();
         }
      }
      
      override public function handleScoreChanged(param1:ChallengePlayerScoreChangedMessage) : void
      {
         var _loc7_:* = undefined;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = param1.player;
         if(_loc6_._id == playerId)
         {
            if(param1.remaingingMatchTime * 0.001 <= targetValue)
            {
               _loc2_ = TuxUiUtils.getPlayersSortedByScore(param1.players);
               _loc3_ = param1.player.getScore();
               _loc4_ = int(_loc2_.indexOf(param1.player));
               if(_loc4_ != -1)
               {
                  if(_loc4_ == 0)
                  {
                     _loc5_ = Math.max(Math.min(params.fromPosition - 1,_loc2_.length - 1),1);
                     if(_loc3_ == (_loc2_[_loc5_] as PlayerGameObject).getScore() || _loc3_ - param1.amount <= (_loc2_[_loc5_] as PlayerGameObject).getScore())
                     {
                        this.updateValue(targetValue - 1);
                     }
                  }
               }
               else
               {
                  _loc7_ = param1.player;
                  LogUtils.log("Player:" + _loc7_._id + " not found in Players: " + _loc2_.toString(),this,2,"Challenges");
               }
            }
         }
      }
   }
}

