package tuxwars.battle
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.MathUtils;
   import com.dchoc.utils.Random;
   import flash.utils.getTimer;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.events.BoosterActivatedMessage;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.events.PlayerScoreChanged;
   import tuxwars.battle.events.PlayerTurnEndedMessage;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.BattleResponse;
   import tuxwars.battle.net.BattleServerDisconnectMessage;
   import tuxwars.battle.net.SocketMessageTypes;
   import tuxwars.battle.net.messages.battle.AddPowerUpMessage;
   import tuxwars.battle.net.messages.chat.LocalChatMessage;
   import tuxwars.battle.net.messages.control.ClientReadyMessage;
   import tuxwars.battle.net.messages.history.HistoryMessageFactory;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.battle.states.player.PlayerActiveState;
   import tuxwars.battle.states.player.PlayerInactiveState;
   import tuxwars.battle.states.player.ai.AIPlayerActiveState;
   import tuxwars.battle.ui.logic.bets.BetManager;
   import tuxwars.battle.ui.states.results.ResultsState;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.events.ChallengePlayerScoreChangedMessage;
   import tuxwars.data.IngameBetData;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.net.CRMService;
   import tuxwars.player.Player;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.components.LoadingIndicatorScreen;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.confirmbattleend.syncerror.SyncErrorMessagePopUpSubState;
   import tuxwars.ui.popups.states.confirmbattleend.timeout.TimeOutMessagePopUpSubState;
   import tuxwars.ui.popups.states.error.ErrorPopupSubState;
   import tuxwars.utils.UniqueCounters;
   
   public class BattleManager
   {
      
      private static const PLAYER_TURN_TEXT:String = "PLAYER_TURN_CHANGE_";
      
      private static const TURN_CHANGE_TEXTS:int = 10;
      
      private static const MATCH_START:int = -1;
      
      private static const TURN_START:int = -2;
      
      private static const REMOVED_SYNC_ERROR:String = "sync_error";
      
      private static const REMOVED_TIME_OUT:String = "time_out";
      
      private static const REMOVED_UNEXPECTED_MESSAGES:String = "unexpected_message";
      
      private static const REMOVED_DISCONNECTED:String = "disconnected";
      
      private static const PLAYER_CACHE:Object = {};
      
      private static var tuxGame:TuxWarsGame;
      
      private static var currentPlayerIndex:int;
      
      private static var prevPlayerIndex:int;
      
      private static var _seed:int;
      
      private static var random:Random;
      
      private static var practiceMode:Boolean;
      
      private static var tournamentMode:Boolean;
      
      private static var zeroPointGame:Boolean;
      
      private static var battleSimulation:BattleSimulation;
      
      private static var matchEnded:Boolean;
      
      private static var players:Array;
      
      private static var vip:Boolean;
      
      private static var _customGameName:String;
      
      private static var matchStarted:Boolean;
      
      private static var _aiPlayerHasShot:Boolean;
      
      private static var _loadingIndicatorScreen:LoadingIndicatorScreen;
      
      private static var _timeInitBattle:int;
      
      private static var _turnStartedTime:int;
      
      private static var _playerTurnsTime:String;
      
      private static var _playerTurnsTimeDiffRealActual:String;
      
      private static var _forcedGameEnd:Boolean;
      
      private static var _connectedToBattleManager:Boolean;
      
      private static var _boostersEnabled:Boolean;
       
      
      public function BattleManager()
      {
         super();
      }
      
      public static function init(_game:TuxWarsGame) : void
      {
         tuxGame = _game;
         UniqueCounters.reset();
         var _loc2_:SimpleScriptManager = SimpleScriptManager;
         if(!tuxwars.battle.simplescript.SimpleScriptManager._instance)
         {
            new tuxwars.battle.simplescript.SimpleScriptManager();
         }
         tuxwars.battle.simplescript.SimpleScriptManager._instance.reset();
         MessageCenter.addListener("BattleResponse",battleResponseHandler);
         MessageCenter.addListener("ScoreChanged",playerScoreChanged);
         MessageCenter.addListener("PlayerDisconnected",playerDisconnected);
         MessageCenter.addListener("BattleServerConnected",battleServerConnected);
         MessageCenter.addListener("BattleServerDisconnect",battleServerDisconnect);
         MessageCenter.addListener("BoosterActivated",boosterActivated);
      }
      
      public static function setupMatch(_matchTime:int, _turnDuration:int, _practiceMode:Boolean, _tournamentMode:Boolean, _players:Array, _vip:Boolean) : void
      {
         LogUtils.log("Initializing BattleManager; match time: " + _matchTime + " turn time: " + _turnDuration + " practice mode: " + _practiceMode + " tournament mode: " + _tournamentMode + " vip: " + _vip,"BattleManager",1,"Match",true,false);
         practiceMode = _practiceMode;
         tournamentMode = _tournamentMode;
         zeroPointGame = false;
         vip = _vip;
         _boostersEnabled = true;
         players = _players;
         _aiPlayerHasShot = false;
         currentPlayerIndex = -1;
         prevPlayerIndex = players.length - 1;
         matchStarted = false;
         matchEnded = false;
         tuxGame.updateWorld = true;
         battleSimulation = new BattleSimulation(_matchTime,_turnDuration,players,_practiceMode,_tournamentMode);
         _playerTurnsTime = new String();
         _playerTurnsTimeDiffRealActual = new String();
         _timeInitBattle = getTimer();
         tuxGame.tuxWorld.physicsWorld.initContactListeners();
      }
      
      public static function dispose() : void
      {
         MessageCenter.sendEvent(new BattleServerDisconnectMessage());
         if(battleSimulation)
         {
            battleSimulation.dispose();
         }
         battleSimulation = null;
         tuxGame.updateWorld = false;
         practiceMode = false;
         tournamentMode = false;
         MessageCenter.removeListener("BattleResponse",battleResponseHandler);
         MessageCenter.removeListener("PlayerDisconnected",playerDisconnected);
         MessageCenter.removeListener("ScoreChanged",playerScoreChanged);
         MessageCenter.removeListener("BattleServerConnected",battleServerConnected);
         MessageCenter.removeListener("BattleServerDisconnect",battleServerDisconnect);
         MessageCenter.removeListener("BoosterActivated",boosterActivated);
         disposePlayers();
         DCUtils.deleteProperties(PLAYER_CACHE);
         removeLoadingIndicator();
      }
      
      public static function get boostersEnabled() : Boolean
      {
         return _boostersEnabled;
      }
      
      public static function setRandomSeed(seed:int) : void
      {
         _seed = Math.abs(seed);
         LogUtils.addDebugLine("Match","Initializing seed for BattleManager: " + seed);
         random = new Random(_seed,"BattleManager Random",Config.debugMode);
      }
      
      public static function getRandom() : Random
      {
         return random;
      }
      
      public static function getTuxGame() : TuxWarsGame
      {
         return tuxGame;
      }
      
      public static function getSimulation() : BattleSimulation
      {
         return battleSimulation;
      }
      
      public static function setPracticeMode(value:Boolean) : void
      {
         practiceMode = value;
      }
      
      public static function isPracticeMode() : Boolean
      {
         return practiceMode;
      }
      
      public static function setTournamentMode(value:Boolean) : void
      {
         tournamentMode = value;
      }
      
      public static function isTournamentMode() : Boolean
      {
         return tournamentMode;
      }
      
      public static function setZeroPointGame(value:Boolean) : void
      {
         zeroPointGame = value;
      }
      
      public static function isZeroPointGame() : Boolean
      {
         return zeroPointGame;
      }
      
      public static function isPracticeModeButNotTutorial() : Boolean
      {
         if(practiceMode)
         {
            var _loc1_:Tutorial = Tutorial;
            if(tuxwars.tutorial.Tutorial._tutorial)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public static function isVIP() : Boolean
      {
         return vip;
      }
      
      public static function get seed() : int
      {
         return _seed;
      }
      
      public static function isActivePlayer(id:String) : Boolean
      {
         var _loc2_:PlayerGameObject = getCurrentActivePlayer();
         if(_loc2_)
         {
            var _loc3_:* = _loc2_;
            return _loc3_._id == id;
         }
         return false;
      }
      
      public static function isLocalPlayer(id:String) : Boolean
      {
         return id == tuxGame.player.id;
      }
      
      public static function isLocalPlayersTurn() : Boolean
      {
         var _loc1_:* = null;
         if(currentPlayerIndex >= 0)
         {
            _loc1_ = getCurrentActivePlayer();
            if(_loc1_)
            {
               var _loc2_:* = _loc1_;
               return isLocalPlayer(_loc2_._id);
            }
         }
         return false;
      }
      
      public static function isBattleInProgress() : Boolean
      {
         return !matchEnded && battleSimulation && battleSimulation.isBattleInProgress();
      }
      
      public static function getMatchTimeLeft() : int
      {
         return battleSimulation.getMatchTimeLeft();
      }
      
      public static function getMatchDuration() : int
      {
         return battleSimulation.getMatchDuration();
      }
      
      public static function getMatchTimeUsed() : int
      {
         return getMatchDuration() - getMatchTimeLeft();
      }
      
      public static function getTurnTimeLeft() : int
      {
         return battleSimulation.getTurnTimeLeft();
      }
      
      public static function getTurnTimeUsed() : int
      {
         return battleSimulation.getTurnTimeUsed();
      }
      
      public static function getTurnDuration() : int
      {
         return battleSimulation.getTurnDuration();
      }
      
      public static function getCurrentActivePlayerIndex() : int
      {
         return currentPlayerIndex;
      }
      
      public static function findPlayer(id:String) : Player
      {
         if(!PLAYER_CACHE.hasOwnProperty(id) || PLAYER_CACHE[id] == null)
         {
            PLAYER_CACHE[id] = DCUtils.find(players,"id",id);
         }
         return PLAYER_CACHE[id];
      }
      
      public static function findPlayerGameObject(id:String) : PlayerGameObject
      {
         if(tuxGame.battleState)
         {
            return getTuxWorld().findPlayer(id);
         }
         return null;
      }
      
      public static function getCurrentActivePlayer() : PlayerGameObject
      {
         return tuxGame && tuxGame.battleState && currentPlayerIndex >= 0 ? tuxGame.tuxWorld.players[currentPlayerIndex] : null;
      }
      
      public static function getOpponents() : Vector.<PlayerGameObject>
      {
         var _loc2_:Vector.<PlayerGameObject> = new Vector.<PlayerGameObject>();
         for each(var player in tuxGame.tuxWorld.players)
         {
            if(player != getCurrentActivePlayer())
            {
               _loc2_.push(player);
            }
         }
         return _loc2_;
      }
      
      public static function getLocalPlayer() : PlayerGameObject
      {
         return tuxGame != null ? findPlayerGameObject(tuxGame.player.id) : null;
      }
      
      public static function turnEnd() : void
      {
         var _loc1_:Number = NaN;
         if(!practiceMode && !_loc3_.turnChange)
         {
            battleSimulation.endTurn();
         }
         var _loc2_:PlayerGameObject = getCurrentActivePlayer();
         if(_loc2_)
         {
            var _loc4_:* = _loc2_;
            LogUtils.addDebugLine("Game","Ending player\'s turn " + _loc4_._id,"BattleManager");
            if(battleSimulation)
            {
               var _loc5_:BattleSimulation = battleSimulation;
               MessageCenter.sendEvent(new PlayerTurnEndedMessage(_loc2_,_loc5_._turnStartTime - battleSimulation.getTurnTimeLeft()));
               _loc2_.changeState(new PlayerInactiveState(_loc2_),true);
               _loc2_.reduceBoosterDurations("Turn",1);
            }
         }
         if(isLocalPlayersTurn())
         {
            _loc1_ = (getTimer() - _turnStartedTime) * 0.001;
            _playerTurnsTime += _loc1_ + ",";
            _playerTurnsTimeDiffRealActual += _loc1_ - battleSimulation.getClientTrackingTurnTimeElapsed() * 0.001 + ",";
         }
         prevPlayerIndex = currentPlayerIndex;
         currentPlayerIndex = -2;
         if(tuxGame.battleState)
         {
            tuxGame.battleState.fps.clientReady();
         }
         MessageCenter.sendEvent(new ClientReadyMessage(tuxGame.player.id));
      }
      
      public static function endGame() : void
      {
         LogUtils.log("Game Over.","BattleManager",1,"Match",true,false,true);
         matchEnded = true;
         if(!practiceMode && !tuxGame.player.dummy)
         {
            MessageCenter.sendEvent(new ServerRequest("ConfirmBattleEnded",null,true));
         }
         tuxGame.matchScreenShot = DCUtils.takeScreenShot();
         var _loc1_:Boolean = practiceMode;
         var _loc4_:Boolean = tournamentMode;
         var _loc3_:PlayerGameObject = getLocalPlayer();
         var _loc2_:BattleResults = new BattleResults(getPlayerResults(),_loc3_.rewardsHandler,_loc1_,tournamentMode);
         tuxGame.battleState.changeState(new ResultsState(tuxGame,_loc2_));
      }
      
      public static function showText(text:String, type:int, ignoreLevelScale:Boolean, params:* = null, y:int = 0) : TextEffect
      {
         var _loc6_:* = null;
         if(getTuxWorld())
         {
            var _loc7_:DCGame = DCGame;
            _loc6_ = getTuxWorld().addTextEffect(type,text,Number(com.dchoc.game.DCGame._stage.stageWidth) >> 1,y,true,params);
            if(ignoreLevelScale)
            {
               getTuxWorld().ignoreLevelSizeScale(_loc6_.movieClip,true,false);
            }
            return _loc6_;
         }
         return null;
      }
      
      public static function playerScoreChanged(msg:PlayerScoreChanged) : void
      {
         if(players != null && msg.player != null)
         {
            MessageCenter.sendEvent(new ChallengePlayerScoreChangedMessage(msg.player,msg.amount,tuxGame.tuxWorld.players,getMatchTimeLeft()));
         }
      }
      
      public static function get isCustomGame() : Boolean
      {
         return _customGameName != null;
      }
      
      public static function get customGameName() : String
      {
         return _customGameName;
      }
      
      public static function set customGameName(value:String) : void
      {
         _customGameName = value;
      }
      
      public static function set aiPlayerHasShot(value:Boolean) : void
      {
         _aiPlayerHasShot = value;
      }
      
      public static function get aiPlayerHasShot() : Boolean
      {
         return _aiPlayerHasShot;
      }
      
      public static function get playerTurnsTime() : String
      {
         return _playerTurnsTime;
      }
      
      public static function get playerTurnsTimeDiffRealActual() : String
      {
         return _playerTurnsTimeDiffRealActual;
      }
      
      public static function addLoadingIndicator() : void
      {
         if(!_loadingIndicatorScreen)
         {
            _loadingIndicatorScreen = new LoadingIndicatorScreen(tuxGame,"BATTLE_START_WAITING_ON_PLAYERS");
         }
      }
      
      public static function removeLoadingIndicator() : void
      {
         if(_loadingIndicatorScreen)
         {
            _loadingIndicatorScreen.dispose();
            _loadingIndicatorScreen = null;
         }
      }
      
      public static function removeClient(removedClient:Object) : void
      {
         var _loc2_:Player = findPlayer(removedClient.removed_client);
         if(_loc2_)
         {
            LogUtils.log("Player " + _loc2_ + " disconnected, reason: " + removedClient.reason + " stepTime: " + tuxGame.tuxWorld.physicsWorld.stepCount,"BattleManager",1,"Player",false);
            MessageCenter.sendEvent(new LocalChatMessage(_loc2_.id,getChatMessageForRemovedPlayer(removedClient.reason)));
            MessageCenter.sendMessage("PlayerDisconnected",removedClient.removed_client);
         }
         else
         {
            LogUtils.log("Trying to remove non-existing player, id: " + removedClient.removed_client,"BattleManager",2,"Player",true,true);
         }
      }
      
      public static function get connectedToBattleManager() : Boolean
      {
         return _connectedToBattleManager;
      }
      
      private static function battleResponseHandler(response:BattleResponse) : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(!SocketMessageTypes.isControlMessage(response.responseType))
         {
            return;
         }
         LogUtils.addDebugLine("HandleMessage","Handling response: " + response.responseType,"BattleManager");
         var _loc2_:Object = response.data;
         switch(response.responseType)
         {
            case 17:
               LogUtils.log("Start turn, match started: " + matchStarted,"BattleManager",1);
               if(!matchStarted)
               {
                  MessageCenter.sendMessage("MatchStarted",_timeInitBattle);
                  CRMService.sendEvent("Game","Menu","Confirmed",tournamentMode ? "TournamentPlay" : "Play");
                  matchStarted = true;
                  matchEnded = false;
                  removeLoadingIndicator();
                  tuxGame.battleState.textEffect = BattleManager.showText(ProjectManager.getText("MATCH_START_INFO"),5,false);
                  HistoryMessageFactory.sendOSMessage(tuxGame.player.id,Config.getOSStr());
               }
               startPlayerTurn(getTuxWorld().getIndexOfPlayerWithId(response.playerId));
               break;
            case 16:
               LogUtils.addDebugLine("HandleMessage","Got end turn message from: " + (response.playerId != null ? response.playerId : "Server(no playerId)"),"BattleManager");
               getTuxWorld().turnEnd = true;
               break;
            case 19:
               if(!matchStarted)
               {
                  removeLoadingIndicator();
               }
               getTuxWorld().gameEnded = true;
               break;
            case 24:
               LogUtils.log("24 :Server does not forward any messages any more proceed to end_game_confirm","BattleManager",0,"ReceivedMessage",true,false,false);
               _forcedGameEnd = true;
               tuxGame.tuxWorld.forceEndGameConfirm();
               break;
            case 13:
               _loc5_ = findPlayerGameObject(response.playerId);
               if(_loc5_)
               {
                  _loc5_.useEmoticon(_loc2_.emoticon_id);
                  break;
               }
               LogUtils.log("Couldn\'t find player: " + response.playerId + " for emoticon: " + _loc2_.emoticon_id,"BattleManager",3);
               break;
            case 25:
               errorHandler(response);
               break;
            case 23:
               _loc3_ = findPlayer(_loc2_.id);
               if(_loc3_)
               {
                  _loc3_.betData = BetManager.getBet(_loc2_.betId);
                  break;
               }
               LogUtils.log("Couldn\'t find player: " + _loc2_.id + " for betting: " + _loc2_.betId,"BattleManager",3);
               break;
            case 50:
               MessageCenter.sendMessage("ingameBetPlaced",_loc2_);
               break;
            case 51:
               MessageCenter.sendMessage("ingameBetMultiplierChanged",_loc2_);
               break;
            case 60:
               _loc4_ = findPlayerGameObject(response.playerId);
               if(_loc4_)
               {
                  _loc4_.chickeningOut(response.data.status);
                  break;
               }
               LogUtils.log("Couldn\'t find player: " + response.playerId + " for chickening out icon","BattleManager",3);
               break;
            case 37:
               _boostersEnabled = true;
         }
      }
      
      private static function getChatMessageForRemovedPlayer(reason:String) : String
      {
         switch(reason)
         {
            case "unexpected_message":
               return "CHAT_PLAYER_UNEXPECTED_MESSAGE";
            case "disconnected":
               return "EXIT_CONFIRMED_INGAME";
            case "sync_error":
               return "CHAT_PLAYER_SYNC_ERROR";
            case "time_out":
               return "CHAT_PLAYER_TIME_OUT";
            default:
               return null;
         }
      }
      
      private static function indexOfPlayer(id:String) : int
      {
         var i:int = 0;
         for(i = 0; i < players.length; )
         {
            if(players[i].id == id)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private static function getPlayerResults() : Vector.<PlayerResult>
      {
         var _loc3_:* = null;
         var _loc2_:Vector.<PlayerResult> = new Vector.<PlayerResult>();
         for each(var player in players)
         {
            _loc3_ = findPlayerGameObject(player.id);
            _loc2_.push(new PlayerResult(player,_loc3_.getScore(),_loc3_.rewardsHandler.getInGameMoneyGained(),_loc3_.rewardsHandler.getExperienceGained()));
         }
         return _loc2_;
      }
      
      private static function getTuxWorld() : TuxWorld
      {
         return tuxGame.tuxWorld;
      }
      
      private static function startPlayerTurn(nextPlayerIndex:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _aiPlayerHasShot = false;
         currentPlayerIndex = nextPlayerIndex;
         var _loc2_:PlayerGameObject = getCurrentActivePlayer();
         _loc2_.infoContainer.resetCountDownFlags();
         if(BattleManager.isLocalPlayersTurn())
         {
            MessageCenter.sendMessage("HelpHudStartMoveTimer");
            if(!_loc2_.checkForShoot)
            {
               MessageCenter.sendMessage("HelpHudStartShoot");
            }
            _loc2_.checkForShoot = false;
         }
         _loc2_.fired = false;
         _loc2_.changeState(_loc2_.isAI() ? new AIPlayerActiveState(_loc2_) : new PlayerActiveState(_loc2_),true);
         MessageCenter.sendMessage("PlayerTurnStarted",_loc2_);
         var _loc5_:* = _loc2_;
         LogUtils.addDebugLine("Match","Turn Start, player: " + _loc5_._id + " index: " + currentPlayerIndex);
         if(isLocalPlayersTurn())
         {
            _loc4_ = MathUtils.randomNumber(1,10);
            var _loc6_:* = _loc2_;
            showText(ProjectManager.getText("PLAYER_TURN_CHANGE_" + _loc4_,[_loc6_._name]),4,false,currentPlayerIndex);
            _turnStartedTime = getTimer();
         }
         if(isLocalPlayersTurn() || isPracticeMode())
         {
            _loc3_ = getTuxWorld().physicsWorld.getRandomPowerUp();
            if(_loc3_ != null)
            {
               MessageCenter.sendEvent(new AddPowerUpMessage(_loc3_));
            }
         }
         if(tuxGame.battleState)
         {
            tuxGame.battleState.fps.startTurn();
         }
      }
      
      private static function playerDisconnected(msg:Message) : void
      {
         var _loc3_:PlayerGameObject = getCurrentActivePlayer();
         var _loc2_:String = msg.data;
         LogUtils.log("Removing player " + _loc2_,"BattleManager",1,"Player",false);
         tuxGame.tuxWorld.removePlayer(_loc2_);
         removePlayer(_loc2_);
         if(_loc3_)
         {
            var _loc4_:* = _loc3_;
            currentPlayerIndex = getTuxWorld().getIndexOfPlayerWithId(_loc4_._id);
         }
         else
         {
            LogUtils.log("Do not have any active player at the moment!","BattleManager",2,"All",false);
         }
         MessageCenter.sendMessage("PlayerRemoved",_loc2_);
      }
      
      private static function removePlayer(id:String) : void
      {
         var _loc2_:Player = findPlayer(id);
         if(_loc2_)
         {
            if(!isLocalPlayer(_loc2_.id))
            {
               var _loc3_:ChallengeManager = ChallengeManager;
               if(!tuxwars.challenges.ChallengeManager._instance)
               {
                  tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
               }
               tuxwars.challenges.ChallengeManager._instance.removePlayerChallenges(_loc2_.id);
               _loc2_.dispose();
            }
            players.splice(players.indexOf(_loc2_),1);
         }
      }
      
      private static function errorHandler(response:BattleResponse) : void
      {
         var battleResults:* = null;
         LogUtils.log("Received an error from the server: code = " + response.data.code + " desc: " + response.data.description,"BattleManager",3,"ErrorLogging",true);
         if(tuxGame.tuxWorld)
         {
            MessageCenter.sendEvent(new MatchEndedMessage(tuxGame.tuxWorld.players,response.data.code));
         }
         CRMService.sendEvent("Game Error","Client",response.data.code,"Unspecified");
         var _loc3_:PlayerGameObject = getLocalPlayer();
         if(_loc3_)
         {
            getLocalPlayer().rewardsHandler.syncRewardHandler();
            battleResults = new BattleResults(getPlayerResults(),_loc3_.rewardsHandler,practiceMode,tournamentMode);
         }
         tuxGame.matchScreenShot = DCUtils.takeScreenShot();
         tuxGame.changeState(new HomeState(tuxGame),true);
         switch(response.data.code)
         {
            case "sync_error":
               var _loc4_:PopUpManager = PopUpManager;
               if(!tuxwars.ui.popups.PopUpManager._instance)
               {
                  tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
               }
               tuxwars.ui.popups.PopUpManager._instance.addPopup(new SyncErrorMessagePopUpSubState(tuxGame,battleResults));
               break;
            case "time_out":
               if(tuxGame && tuxGame.player && tuxGame.player.betData)
               {
                  LogUtils.log("Restore player: " + tuxGame.player.id + " betData: " + tuxGame.player.betData.id + " now that he has been thrown out!",BattleManager,2,"ErrorLogging",true,false,true);
                  if(tuxGame.player.betData.valuePremium > 0)
                  {
                     tuxGame.player.addPremiumMoney(tuxGame.player.betData.valuePremium);
                  }
                  else if(tuxGame.player.betData.valueIngame > 0)
                  {
                     tuxGame.player.addIngameMoney(IngameBetData.getBetAmount(),false);
                  }
                  tuxGame.player.betData = null;
               }
               var _loc5_:PopUpManager = PopUpManager;
               if(!tuxwars.ui.popups.PopUpManager._instance)
               {
                  tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
               }
               tuxwars.ui.popups.PopUpManager._instance.addPopup(new TimeOutMessagePopUpSubState(tuxGame));
               break;
            case "unexpected_message":
               var _loc6_:PopUpManager = PopUpManager;
               if(!tuxwars.ui.popups.PopUpManager._instance)
               {
                  tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
               }
               tuxwars.ui.popups.PopUpManager._instance.addPopup(new ErrorPopupSubState(tuxGame,response.data));
         }
         var _loc7_:PopUpManager = PopUpManager;
         if(!tuxwars.ui.popups.PopUpManager._instance)
         {
            tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
         }
         tuxwars.ui.popups.PopUpManager._instance.showPopUps(tuxGame.homeState);
      }
      
      private static function disposePlayers() : void
      {
         if(players)
         {
            for each(var player in players)
            {
               if(!isLocalPlayer(player.id))
               {
                  var _loc2_:ChallengeManager = ChallengeManager;
                  if(!tuxwars.challenges.ChallengeManager._instance)
                  {
                     tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
                  }
                  tuxwars.challenges.ChallengeManager._instance.removePlayerChallenges(player.id);
                  player.dispose();
               }
            }
            players.splice(0,players.length);
         }
      }
      
      private static function battleServerConnected(msg:Message) : void
      {
         _connectedToBattleManager = true;
      }
      
      private static function battleServerDisconnect(event:BattleServerDisconnectMessage) : void
      {
         _connectedToBattleManager = false;
      }
      
      private static function boosterActivated(msg:BoosterActivatedMessage) : void
      {
         if(isLocalPlayer(msg.playerId))
         {
            _boostersEnabled = false;
         }
      }
   }
}
