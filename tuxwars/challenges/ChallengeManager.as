package tuxwars.challenges
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import org.as3commons.lang.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.events.PlayerTurnEndedMessage;
   import tuxwars.battle.net.messages.history.*;
   import tuxwars.battle.world.*;
   import tuxwars.challenges.counters.*;
   
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
      
      public function init(param1:TuxWarsGame) : void
      {
         tuxGame = param1;
      }
      
      public function reinit() : void
      {
         this.addListeners();
         PhysicsUpdater.register(this,"ChallengeManager");
         var _loc1_:ChallengeRewardsManager = ChallengeRewardsManager;
         if(!ChallengeRewardsManager._instance)
         {
            ChallengeRewardsManager._instance = new ChallengeRewardsManager();
         }
         ChallengeRewardsManager._instance.init(tuxGame);
      }
      
      public function dispose() : void
      {
         this.removeListeners();
         PhysicsUpdater.unregister(this,"ChallengeManager");
         var _loc1_:ChallengeRewardsManager = ChallengeRewardsManager;
         if(!ChallengeRewardsManager._instance)
         {
            ChallengeRewardsManager._instance = new ChallengeRewardsManager();
         }
         ChallengeRewardsManager._instance.dispose();
         this.counterUpdates.splice(0,this.counterUpdates.length);
      }
      
      public function pause() : void
      {
         var _loc1_:* = undefined;
         this.removeListeners();
         PhysicsUpdater.unregister(this,"ChallengeManager");
         for each(_loc1_ in this.playerChallenges)
         {
            _loc1_.pause();
         }
      }
      
      public function resume() : void
      {
         var _loc1_:* = undefined;
         this.addListeners();
         PhysicsUpdater.register(this,"ChallengeManager");
         for each(_loc1_ in this.playerChallenges)
         {
            _loc1_.resume();
         }
      }
      
      public function physicsUpdate(param1:int) : void
      {
         if(this.counterUpdates.length > 0)
         {
            this.sendCounterUpdates();
         }
      }
      
      public function sendCounterUpdate(param1:CounterUpdate, param2:Boolean) : void
      {
         if(param1.counter.challenge.global)
         {
            if(Boolean(tuxGame.isInBattle()) && Boolean(matchInProgress) && param2)
            {
               LogUtils.log("Received counter update during battle. " + param1.counterId,this,1,"Challenges",false);
               this.counterUpdates.push(param1);
            }
            else if(!tuxGame.isInBattle() && !matchInProgress)
            {
               LogUtils.log("Received counter update outside of battle. " + param1.counterId,this,1,"Challenges",false);
               param1.counter.challenge.outOfBattleCheck();
            }
         }
      }
      
      public function addPlayerChallenges(param1:String, param2:Object, param3:Boolean) : void
      {
         if(this.playerChallenges[param1] != null)
         {
            this.playerChallenges[param1].dispose();
         }
         this.playerChallenges[param1] = new Challenges(param2,param1,param3);
         LogUtils.log("Added challenges to player: " + param1,"ChallengeManager",1,"Challenges",false,false,true);
      }
      
      public function getPlayerChallenges(param1:String) : Challenges
      {
         if(this.playerChallenges.hasOwnProperty(param1))
         {
            return this.playerChallenges[param1];
         }
         LogUtils.log("Player " + param1 + " doesn\'t have challenges defined.","ChallengeManager",3,"Challenges",true,false,true);
         return null;
      }
      
      public function getLocalPlayersChallenges() : Challenges
      {
         return this.getPlayerChallenges(tuxGame.player.id);
      }
      
      public function setPlayerChallenges(param1:String, param2:Challenges) : void
      {
         LogUtils.log("Setting challenges to player: " + param1,"ChallengeManager",1,"Challenges",false,false,true);
         if(this.playerChallenges[param1] != null)
         {
            this.playerChallenges[param1].dispose();
         }
         this.playerChallenges[param1] = param2;
      }
      
      public function removePlayerChallenges(param1:String) : void
      {
         if(this.playerChallenges.hasOwnProperty(param1))
         {
            LogUtils.log("Removing challenges of player: " + param1,"ChallengeManager",1,"Challenges",false,false,true);
            this.playerChallenges[param1].dispose();
            delete this.playerChallenges[param1];
         }
      }
      
      private function sendCounterUpdates() : void
      {
         var _loc1_:* = undefined;
         this.counterUpdates.sort(this.counterSorter);
         for each(_loc1_ in this.counterUpdates)
         {
            HistoryMessageFactory.sendChallengeCounterMessage(_loc1_.playerId,_loc1_.counterId,_loc1_.value);
         }
         this.counterUpdates.splice(0,this.counterUpdates.length);
      }
      
      private function counterSorter(param1:CounterUpdate, param2:CounterUpdate) : int
      {
         var _loc3_:int = int(StringUtils.compareTo(param1.playerId,param2.playerId));
         if(_loc3_ != 0)
         {
            return _loc3_;
         }
         var _loc4_:int = int(StringUtils.compareTo(param1.counterId,param2.counterId));
         if(_loc4_ != 0)
         {
            return _loc4_;
         }
         return param1.value - param2.value;
      }
      
      private function playerTurnStarted(param1:Message) : void
      {
         var _loc2_:Object = param1.data;
         if(this.playerChallenges.hasOwnProperty(_loc2_.id))
         {
            this.playerChallenges[_loc2_.id].turnStarted();
         }
      }
      
      private function playerTurnEnded(param1:PlayerTurnEndedMessage) : void
      {
         var _loc2_:Object = param1.data;
         if(this.playerChallenges.hasOwnProperty(_loc2_.id))
         {
            this.playerChallenges[_loc2_.id].turnEnded(param1);
         }
      }
      
      private function matchStarted(param1:Message) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.playerChallenges)
         {
            _loc2_.matchStarted();
         }
         matchInProgress = true;
      }
      
      private function matchEnded(param1:MatchEndedMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.playerChallenges)
         {
            _loc2_.matchEnded(param1);
         }
         matchInProgress = false;
      }
      
      private function addListeners() : void
      {
         MessageCenter.addListener("PlayerTurnStarted",this.playerTurnStarted);
         MessageCenter.addListener("PlayerTurnEnded",this.playerTurnEnded);
         MessageCenter.addListener("MatchStarted",this.matchStarted);
         MessageCenter.addListener("MatchEnded",this.matchEnded);
      }
      
      private function removeListeners() : void
      {
         MessageCenter.removeListener("PlayerTurnStarted",this.playerTurnStarted);
         MessageCenter.removeListener("PlayerTurnEnded",this.playerTurnEnded);
         MessageCenter.removeListener("MatchStarted",this.matchStarted);
         MessageCenter.removeListener("MatchEnded",this.matchEnded);
      }
   }
}

