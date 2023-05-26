package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerScoreChangedMessage;
   import tuxwars.utils.TuxUiUtils;
   
   public class ReachFirstFromPositionInTime extends CounterLessThan
   {
       
      
      public function ReachFirstFromPositionInTime(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
         value = targetValue + 1;
      }
      
      override protected function updateValue(amount:int, sendInBattleUpdate:Boolean = true) : void
      {
         var _loc3_:Boolean = completed;
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
         if(_loc3_ != completed)
         {
            challenge.notifyCounterStateChanged();
         }
      }
      
      override public function handleScoreChanged(msg:ChallengePlayerScoreChangedMessage) : void
      {
         var sortedPlayers:* = null;
         var playerScore:int = 0;
         var indexOfPlayer:int = 0;
         var positionIndex:int = 0;
         var _loc6_:* = msg.player;
         if(_loc6_._id == playerId)
         {
            if(msg.remaingingMatchTime * 0.001 <= targetValue)
            {
               sortedPlayers = TuxUiUtils.getPlayersSortedByScore(msg.players);
               playerScore = msg.player.getScore();
               indexOfPlayer = sortedPlayers.indexOf(msg.player);
               if(indexOfPlayer != -1)
               {
                  if(indexOfPlayer == 0)
                  {
                     positionIndex = Math.max(Math.min(params.fromPosition - 1,sortedPlayers.length - 1),1);
                     if(playerScore == (sortedPlayers[positionIndex] as PlayerGameObject).getScore() || playerScore - msg.amount <= (sortedPlayers[positionIndex] as PlayerGameObject).getScore())
                     {
                        updateValue(targetValue - 1);
                     }
                  }
               }
               else
               {
                  var _loc7_:* = msg.player;
                  LogUtils.log("Player:" + _loc7_._id + " not found in Players: " + sortedPlayers.toString(),this,2,"Challenges");
               }
            }
         }
      }
   }
}
