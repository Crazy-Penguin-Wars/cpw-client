package tuxwars.challenges
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import org.as3commons.lang.StringUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.events.PlayerTurnEndedMessage;
   import tuxwars.battle.net.messages.history.HistoryMessageFactory;
   import tuxwars.battle.world.PhysicsUpdater;
   import tuxwars.challenges.counters.CounterUpdate;
   
   public class ChallengeManager
   {
      
      private static var _instance:ChallengeManager;
      
      private static var tuxGame:TuxWarsGame;
      
      private static var matchInProgress:Boolean;
       
      
      private const playerChallenges:Object = {};
      
      private const counterUpdates:Vector.<CounterUpdate> = new Vector.<CounterUpdate>();
      
      public function ChallengeManager()
      {
         super();
      }
      
      public static function get instance() : ChallengeManager
      {
         if(!_instance)
         {
            _instance = new ChallengeManager();
         }
         return _instance;
      }
      
      public function init(game:TuxWarsGame) : void
      {
         tuxGame = game;
      }
      
      public function reinit() : void
      {
         addListeners();
         PhysicsUpdater.register(this,"ChallengeManager");
         var _loc1_:ChallengeRewardsManager = ChallengeRewardsManager;
         if(!tuxwars.challenges.ChallengeRewardsManager._instance)
         {
            tuxwars.challenges.ChallengeRewardsManager._instance = new tuxwars.challenges.ChallengeRewardsManager();
         }
         tuxwars.challenges.ChallengeRewardsManager._instance.init(tuxGame);
      }
      
      public function dispose() : void
      {
         removeListeners();
         PhysicsUpdater.unregister(this,"ChallengeManager");
         var _loc1_:ChallengeRewardsManager = ChallengeRewardsManager;
         if(!tuxwars.challenges.ChallengeRewardsManager._instance)
         {
            tuxwars.challenges.ChallengeRewardsManager._instance = new tuxwars.challenges.ChallengeRewardsManager();
         }
         tuxwars.challenges.ChallengeRewardsManager._instance.dispose();
         counterUpdates.splice(0,counterUpdates.length);
      }
      
      public function pause() : void
      {
         removeListeners();
         PhysicsUpdater.unregister(this,"ChallengeManager");
         for each(var challenges in playerChallenges)
         {
            challenges.pause();
         }
      }
      
      public function resume() : void
      {
         addListeners();
         PhysicsUpdater.register(this,"ChallengeManager");
         for each(var challenges in playerChallenges)
         {
            challenges.resume();
         }
      }
      
      public function physicsUpdate(deltaTime:int) : void
      {
         if(counterUpdates.length > 0)
         {
            sendCounterUpdates();
         }
      }
      
      public function sendCounterUpdate(counterUpdate:CounterUpdate, sendInBattleUpdate:Boolean) : void
      {
         if(counterUpdate.counter.challenge.global)
         {
            if(tuxGame.isInBattle() && matchInProgress && sendInBattleUpdate)
            {
               LogUtils.log("Received counter update during battle. " + counterUpdate.counterId,this,1,"Challenges",false);
               counterUpdates.push(counterUpdate);
            }
            else if(!tuxGame.isInBattle() && !matchInProgress)
            {
               LogUtils.log("Received counter update outside of battle. " + counterUpdate.counterId,this,1,"Challenges",false);
               counterUpdate.counter.challenge.outOfBattleCheck();
            }
         }
      }
      
      public function addPlayerChallenges(playerId:String, data:Object, localPlayer:Boolean) : void
      {
         if(playerChallenges[playerId] != null)
         {
            playerChallenges[playerId].dispose();
         }
         playerChallenges[playerId] = new Challenges(data,playerId,localPlayer);
         LogUtils.log("Added challenges to player: " + playerId,"ChallengeManager",1,"Challenges",false,false,true);
      }
      
      public function getPlayerChallenges(playerId:String) : Challenges
      {
         if(playerChallenges.hasOwnProperty(playerId))
         {
            return playerChallenges[playerId];
         }
         LogUtils.log("Player " + playerId + " doesn\'t have challenges defined.","ChallengeManager",3,"Challenges",true,false,true);
         return null;
      }
      
      public function getLocalPlayersChallenges() : Challenges
      {
         return getPlayerChallenges(tuxGame.player.id);
      }
      
      public function setPlayerChallenges(playerId:String, challenges:Challenges) : void
      {
         LogUtils.log("Setting challenges to player: " + playerId,"ChallengeManager",1,"Challenges",false,false,true);
         if(playerChallenges[playerId] != null)
         {
            playerChallenges[playerId].dispose();
         }
         playerChallenges[playerId] = challenges;
      }
      
      public function removePlayerChallenges(playerId:String) : void
      {
         if(playerChallenges.hasOwnProperty(playerId))
         {
            LogUtils.log("Removing challenges of player: " + playerId,"ChallengeManager",1,"Challenges",false,false,true);
            playerChallenges[playerId].dispose();
            delete playerChallenges[playerId];
         }
      }
      
      private function sendCounterUpdates() : void
      {
         counterUpdates.sort(counterSorter);
         for each(var counterUpdate in counterUpdates)
         {
            HistoryMessageFactory.sendChallengeCounterMessage(counterUpdate.playerId,counterUpdate.counterId,counterUpdate.value);
         }
         counterUpdates.splice(0,counterUpdates.length);
      }
      
      private function counterSorter(counterUpdate1:CounterUpdate, counterUpdate2:CounterUpdate) : int
      {
         var _loc3_:int = StringUtils.compareTo(counterUpdate1.playerId,counterUpdate2.playerId);
         if(_loc3_ != 0)
         {
            return _loc3_;
         }
         var _loc4_:int = StringUtils.compareTo(counterUpdate1.counterId,counterUpdate2.counterId);
         if(_loc4_ != 0)
         {
            return _loc4_;
         }
         return counterUpdate1.value - counterUpdate2.value;
      }
      
      private function playerTurnStarted(msg:Message) : void
      {
         var _loc2_:Object = msg.data;
         if(playerChallenges.hasOwnProperty(_loc2_.id))
         {
            playerChallenges[_loc2_.id].turnStarted();
         }
      }
      
      private function playerTurnEnded(msg:PlayerTurnEndedMessage) : void
      {
         var _loc2_:Object = msg.data;
         if(playerChallenges.hasOwnProperty(_loc2_.id))
         {
            playerChallenges[_loc2_.id].turnEnded(msg);
         }
      }
      
      private function matchStarted(msg:Message) : void
      {
         for each(var challenges in playerChallenges)
         {
            challenges.matchStarted();
         }
         matchInProgress = true;
      }
      
      private function matchEnded(msg:MatchEndedMessage) : void
      {
         for each(var challenges in playerChallenges)
         {
            challenges.matchEnded(msg);
         }
         matchInProgress = false;
      }
      
      private function addListeners() : void
      {
         MessageCenter.addListener("PlayerTurnStarted",playerTurnStarted);
         MessageCenter.addListener("PlayerTurnEnded",playerTurnEnded);
         MessageCenter.addListener("MatchStarted",matchStarted);
         MessageCenter.addListener("MatchEnded",matchEnded);
      }
      
      private function removeListeners() : void
      {
         MessageCenter.removeListener("PlayerTurnStarted",playerTurnStarted);
         MessageCenter.removeListener("PlayerTurnEnded",playerTurnEnded);
         MessageCenter.removeListener("MatchStarted",matchStarted);
         MessageCenter.removeListener("MatchEnded",matchEnded);
      }
   }
}
