package tuxwars.battle
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.states.State;
   import com.dchoc.utils.*;
   import flash.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.events.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.net.*;
   import tuxwars.battle.net.messages.battle.*;
   import tuxwars.battle.net.messages.chat.*;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.battle.net.messages.history.*;
   import tuxwars.battle.simplescript.*;
   import tuxwars.battle.states.player.*;
   import tuxwars.battle.states.player.ai.*;
   import tuxwars.battle.ui.logic.bets.*;
   import tuxwars.battle.ui.states.results.*;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.*;
   import tuxwars.data.*;
   import tuxwars.home.states.homestate.*;
   import tuxwars.net.*;
   import tuxwars.player.Player;
   import tuxwars.tutorial.*;
   import tuxwars.ui.components.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.confirmbattleend.syncerror.*;
   import tuxwars.ui.popups.states.confirmbattleend.timeout.*;
   import tuxwars.ui.popups.states.error.*;
   import tuxwars.utils.*;
   
   public class BattleManager
   {
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
      
      private static const PLAYER_TURN_TEXT:String = "PLAYER_TURN_CHANGE_";
      
      private static const TURN_CHANGE_TEXTS:int = 10;
      
      private static const MATCH_START:int = -1;
      
      private static const TURN_START:int = -2;
      
      private static const REMOVED_SYNC_ERROR:String = "sync_error";
      
      private static const REMOVED_TIME_OUT:String = "time_out";
      
      private static const REMOVED_UNEXPECTED_MESSAGES:String = "unexpected_message";
      
      private static const REMOVED_DISCONNECTED:String = "disconnected";
      
      private static const PLAYER_CACHE:Object = {};
      
      public function BattleManager()
      {
         super();
      }
      
      public static function init(param1:TuxWarsGame) : void
      {
         tuxGame = param1;
         UniqueCounters.reset();
         if(!SimpleScriptManager.instance)
         {
            new SimpleScriptManager();
         }
         SimpleScriptManager.instance.reset();
         MessageCenter.addListener("BattleResponse",battleResponseHandler);
         MessageCenter.addListener("ScoreChanged",playerScoreChanged);
         MessageCenter.addListener("PlayerDisconnected",playerDisconnected);
         MessageCenter.addListener("BattleServerConnected",battleServerConnected);
         MessageCenter.addListener("BattleServerDisconnect",battleServerDisconnect);
         MessageCenter.addListener("BoosterActivated",boosterActivated);
      }
      
      public static function setupMatch(param1:int, param2:int, param3:Boolean, param4:Boolean, param5:Array, param6:Boolean) : void
      {
         LogUtils.log("Initializing BattleManager; match time: " + param1 + " turn time: " + param2 + " practice mode: " + param3 + " tournament mode: " + param4 + " vip: " + param6,"BattleManager",1,"Match",true,false);
         practiceMode = param3;
         tournamentMode = param4;
         zeroPointGame = false;
         vip = param6;
         _boostersEnabled = true;
         players = param5;
         _aiPlayerHasShot = false;
         currentPlayerIndex = -1;
         prevPlayerIndex = players.length - 1;
         matchStarted = false;
         matchEnded = false;
         tuxGame.updateWorld = true;
         battleSimulation = new BattleSimulation(param1,param2,players,param3,param4);
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
      
      public static function setRandomSeed(param1:int) : void
      {
         _seed = Math.abs(param1);
         LogUtils.addDebugLine("Match","Initializing seed for BattleManager: " + param1);
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
      
      public static function setPracticeMode(param1:Boolean) : void
      {
         practiceMode = param1;
      }
      
      public static function isPracticeMode() : Boolean
      {
         return practiceMode;
      }
      
      public static function setTournamentMode(param1:Boolean) : void
      {
         tournamentMode = param1;
      }
      
      public static function isTournamentMode() : Boolean
      {
         return tournamentMode;
      }
      
      public static function setZeroPointGame(param1:Boolean) : void
      {
         zeroPointGame = param1;
      }
      
      public static function isZeroPointGame() : Boolean
      {
         return zeroPointGame;
      }
      
      public static function isPracticeModeButNotTutorial() : Boolean
      {
         if(practiceMode)
         {
            if(Tutorial._tutorial)
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
      
      public static function isActivePlayer(param1:String) : Boolean
      {
         var _loc3_:* = undefined;
         var _loc2_:PlayerGameObject = getCurrentActivePlayer();
         if(_loc2_)
         {
            _loc3_ = _loc2_;
            return _loc3_._id == param1;
         }
         return false;
      }
      
      public static function isLocalPlayer(param1:String) : Boolean
      {
         return param1 == tuxGame.player.id;
      }
      
      public static function isLocalPlayersTurn() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc1_:PlayerGameObject = null;
         if(currentPlayerIndex >= 0)
         {
            _loc1_ = getCurrentActivePlayer();
            if(_loc1_)
            {
               _loc2_ = _loc1_;
               return isLocalPlayer(_loc2_._id);
            }
         }
         return false;
      }
      
      public static function isBattleInProgress() : Boolean
      {
         return !matchEnded && Boolean(battleSimulation) && Boolean(battleSimulation.isBattleInProgress());
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
      
      public static function findPlayer(param1:String) : Player
      {
         if(!PLAYER_CACHE.hasOwnProperty(param1) || PLAYER_CACHE[param1] == null)
         {
            PLAYER_CACHE[param1] = DCUtils.find(players,"id",param1);
         }
         return PLAYER_CACHE[param1];
      }
      
      public static function findPlayerGameObject(param1:String) : PlayerGameObject
      {
         if(tuxGame.battleState)
         {
            return getTuxWorld().findPlayer(param1);
         }
         return null;
      }
      
      public static function getCurrentActivePlayer() : PlayerGameObject
      {
         return tuxGame && tuxGame.battleState && currentPlayerIndex >= 0 ? tuxGame.tuxWorld.players[currentPlayerIndex] : null;
      }
      
      public static function getOpponents() : Vector.<PlayerGameObject>
      {
         var _loc2_:* = undefined;
         var _loc1_:Vector.<PlayerGameObject> = new Vector.<PlayerGameObject>();
         for each(_loc2_ in tuxGame.tuxWorld.players)
         {
            if(_loc2_ != getCurrentActivePlayer())
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public static function getLocalPlayer() : PlayerGameObject
      {
         return tuxGame != null ? findPlayerGameObject(tuxGame.player.id) : null;
      }
      
      public static function turnEnd() : void
      {
         var _loc3_:* = undefined;
         var _loc4_:BattleSimulation = null;
         var _loc1_:Number = Number(NaN);
         if(!practiceMode && !_loc3_.turnChange)
         {
            battleSimulation.endTurn();
         }
         var _loc2_:PlayerGameObject = getCurrentActivePlayer();
         if(_loc2_)
         {
            _loc3_ = _loc2_;
            LogUtils.addDebugLine("Game","Ending player\'s turn " + _loc3_._id,"BattleManager");
            if(battleSimulation)
            {
               _loc4_ = battleSimulation;
               MessageCenter.sendEvent(new PlayerTurnEndedMessage(_loc2_,_loc4_._turnStartTime - battleSimulation.getTurnTimeLeft()));
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
         var _loc1_:Boolean = Boolean(practiceMode);
         var _loc2_:Boolean = Boolean(tournamentMode);
         var _loc3_:PlayerGameObject = getLocalPlayer();
         var _loc4_:BattleResults = new BattleResults(getPlayerResults(),_loc3_.rewardsHandler,_loc1_,tournamentMode);
         tuxGame.battleState.changeState(new ResultsState(tuxGame,_loc4_));
      }
      
      public static function showText(param1:String, param2:int, param3:Boolean, param4:* = null, param5:int = 0) : TextEffect
      {
         var _loc6_:TextEffect = null;
         if(getTuxWorld())
         {
            _loc6_ = getTuxWorld().addTextEffect(param2,param1,DCGame.getStage().stageWidth >> 1,param5,true,param4);
            if(param3)
            {
               getTuxWorld().ignoreLevelSizeScale(_loc6_.movieClip,true,false);
            }
            return _loc6_;
         }
         return null;
      }
      
      public static function playerScoreChanged(param1:PlayerScoreChanged) : void
      {
         if(players != null && param1.player != null)
         {
            MessageCenter.sendEvent(new ChallengePlayerScoreChangedMessage(param1.player,param1.amount,tuxGame.tuxWorld.players,getMatchTimeLeft()));
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
      
      public static function set customGameName(param1:String) : void
      {
         _customGameName = param1;
      }
      
      public static function set aiPlayerHasShot(param1:Boolean) : void
      {
         _aiPlayerHasShot = param1;
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
      
      public static function removeClient(param1:Object) : void
      {
         var _loc2_:Player = findPlayer(param1.removed_client);
         if(_loc2_)
         {
            LogUtils.log("Player " + _loc2_ + " disconnected, reason: " + param1.reason + " stepTime: " + tuxGame.tuxWorld.physicsWorld.stepCount,"BattleManager",1,"Player",false);
            MessageCenter.sendEvent(new LocalChatMessage(_loc2_.id,getChatMessageForRemovedPlayer(param1.reason)));
            MessageCenter.sendMessage("PlayerDisconnected",param1.removed_client);
         }
         else
         {
            LogUtils.log("Trying to remove non-existing player, id: " + param1.removed_client,"BattleManager",2,"Player",true,true);
         }
      }
      
      public static function get connectedToBattleManager() : Boolean
      {
         return _connectedToBattleManager;
      }
      
      private static function battleResponseHandler(param1:BattleResponse) : void
      {
         var _loc2_:PlayerGameObject = null;
         var _loc3_:Player = null;
         var _loc4_:PlayerGameObject = null;
         if(!SocketMessageTypes.isControlMessage(param1.responseType))
         {
            return;
         }
         LogUtils.addDebugLine("HandleMessage","Handling response: " + param1.responseType,"BattleManager");
         var _loc5_:Object = param1.data;
         switch(param1.responseType)
         {
            case 17:
               LogUtils.log("Start turn, match started: " + matchStarted,"BattleManager",1);
               if(!matchStarted)
               {
                  MessageCenter.sendMessage("MatchStarted",_timeInitBattle);
                  CRMService.sendEvent("Game","Menu","Confirmed",!!tournamentMode ? "TournamentPlay" : "Play");
                  matchStarted = true;
                  matchEnded = false;
                  removeLoadingIndicator();
                  tuxGame.battleState.textEffect = BattleManager.showText(ProjectManager.getText("MATCH_START_INFO"),5,false);
                  HistoryMessageFactory.sendOSMessage(tuxGame.player.id,Config.getOSStr());
               }
               startPlayerTurn(getTuxWorld().getIndexOfPlayerWithId(param1.playerId));
               break;
            case 16:
               LogUtils.addDebugLine("HandleMessage","Got end turn message from: " + (param1.playerId != null ? param1.playerId : "Server(no playerId)"),"BattleManager");
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
               _loc2_ = findPlayerGameObject(param1.playerId);
               if(_loc2_)
               {
                  _loc2_.useEmoticon(_loc5_.emoticon_id);
               }
               else
               {
                  LogUtils.log("Couldn\'t find player: " + param1.playerId + " for emoticon: " + _loc5_.emoticon_id,"BattleManager",3);
               }
               break;
            case 25:
               errorHandler(param1);
               break;
            case 23:
               _loc3_ = findPlayer(_loc5_.id);
               if(_loc3_)
               {
                  _loc3_.betData = BetManager.getBet(_loc5_.betId);
               }
               else
               {
                  LogUtils.log("Couldn\'t find player: " + _loc5_.id + " for betting: " + _loc5_.betId,"BattleManager",3);
               }
               break;
            case 50:
               MessageCenter.sendMessage("ingameBetPlaced",_loc5_);
               break;
            case 51:
               MessageCenter.sendMessage("ingameBetMultiplierChanged",_loc5_);
               break;
            case 60:
               _loc4_ = findPlayerGameObject(param1.playerId);
               if(_loc4_)
               {
                  _loc4_.chickeningOut(param1.data.status);
               }
               else
               {
                  LogUtils.log("Couldn\'t find player: " + param1.playerId + " for chickening out icon","BattleManager",3);
               }
               break;
            case 37:
               _boostersEnabled = true;
         }
      }
      
      private static function getChatMessageForRemovedPlayer(param1:String) : String
      {
         switch(param1)
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
      
      private static function indexOfPlayer(param1:String) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < players.length)
         {
            if(players[_loc2_].id == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private static function getPlayerResults() : Vector.<PlayerResult>
      {
         var _loc3_:* = undefined;
         var _loc1_:PlayerGameObject = null;
         var _loc2_:Vector.<PlayerResult> = new Vector.<PlayerResult>();
         for each(_loc3_ in players)
         {
            _loc1_ = findPlayerGameObject(_loc3_.id);
            _loc2_.push(new PlayerResult(_loc3_,_loc1_.getScore(),_loc1_.rewardsHandler.getInGameMoneyGained(),_loc1_.rewardsHandler.getExperienceGained()));
         }
         return _loc2_;
      }
      
      private static function getTuxWorld() : TuxWorld
      {
         return tuxGame.tuxWorld;
      }
      
      private static function startPlayerTurn(param1:int) : void
      {
         var _loc6_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _aiPlayerHasShot = false;
         currentPlayerIndex = param1;
         var _loc4_:PlayerGameObject = getCurrentActivePlayer();
         _loc4_.infoContainer.resetCountDownFlags();
         if(BattleManager.isLocalPlayersTurn())
         {
            MessageCenter.sendMessage("HelpHudStartMoveTimer");
            if(!_loc4_.checkForShoot)
            {
               MessageCenter.sendMessage("HelpHudStartShoot");
            }
            _loc4_.checkForShoot = false;
         }
         _loc4_.fired = false;
         _loc4_.changeState(_loc4_.isAI() ? new AIPlayerActiveState(_loc4_) : new PlayerActiveState(_loc4_),true);
         MessageCenter.sendMessage("PlayerTurnStarted",_loc4_);
         var _loc5_:* = _loc4_;
         LogUtils.addDebugLine("Match","Turn Start, player: " + _loc5_._id + " index: " + currentPlayerIndex);
         if(isLocalPlayersTurn())
         {
            _loc2_ = int(MathUtils.randomNumber(1,10));
            _loc6_ = _loc4_;
            showText(ProjectManager.getText("PLAYER_TURN_CHANGE_" + _loc2_,[_loc6_._name]),4,false,currentPlayerIndex);
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
      
      private static function playerDisconnected(param1:Message) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:PlayerGameObject = getCurrentActivePlayer();
         var _loc3_:String = param1.data;
         LogUtils.log("Removing player " + _loc3_,"BattleManager",1,"Player",false);
         tuxGame.tuxWorld.removePlayer(_loc3_);
         removePlayer(_loc3_);
         if(_loc2_)
         {
            _loc4_ = _loc2_;
            currentPlayerIndex = getTuxWorld().getIndexOfPlayerWithId(_loc4_._id);
         }
         else
         {
            LogUtils.log("Do not have any active player at the moment!","BattleManager",2,"All",false);
         }
         MessageCenter.sendMessage("PlayerRemoved",_loc3_);
      }
      
      private static function removePlayer(param1:String) : void
      {
         var _loc2_:Player = findPlayer(param1);
         if(_loc2_)
         {
            if(!isLocalPlayer(_loc2_.id))
            {
               if(!ChallengeManager.instance)
               {
                  ChallengeManager.instance = new ChallengeManager();
               }
               ChallengeManager.instance.removePlayerChallenges(_loc2_.id);
               _loc2_.dispose();
            }
            players.splice(players.indexOf(_loc2_),1);
         }
      }
      
      private static function errorHandler(param1:BattleResponse) : void
      {
         var _loc2_:BattleResults = null;
         LogUtils.log("Received an error from the server: code = " + param1.data.code + " desc: " + param1.data.description,"BattleManager",3,"ErrorLogging",true);
         if(tuxGame.tuxWorld)
         {
            MessageCenter.sendEvent(new MatchEndedMessage(tuxGame.tuxWorld.players,param1.data.code));
         }
         CRMService.sendEvent("Game Error","Client",param1.data.code,"Unspecified");
         var _loc3_:PlayerGameObject = getLocalPlayer();
         if(_loc3_)
         {
            getLocalPlayer().rewardsHandler.syncRewardHandler();
            _loc2_ = new BattleResults(getPlayerResults(),_loc3_.rewardsHandler,practiceMode,tournamentMode);
         }
         tuxGame.matchScreenShot = DCUtils.takeScreenShot();
         tuxGame.changeState(new HomeState(tuxGame),true);
         switch(param1.data.code)
         {
            case "sync_error":
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.addPopup(new SyncErrorMessagePopUpSubState(tuxGame,_loc2_));
               break;
            case "time_out":
               if(tuxGame && tuxGame.player && Boolean(tuxGame.player.betData))
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
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.addPopup(new TimeOutMessagePopUpSubState(tuxGame));
               break;
            case "unexpected_message":
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.addPopup(new ErrorPopupSubState(tuxGame,param1.data));
         }
         if(!PopUpManager.instance)
         {
            PopUpManager.instance = new PopUpManager();
         }
         PopUpManager.instance.showPopUps(tuxGame.homeState);
      }
      
      private static function disposePlayers() : void
      {
         var _loc1_:* = undefined;
         if(players)
         {
            for each(_loc1_ in players)
            {
               if(!isLocalPlayer(_loc1_.id))
               {
                  if(!ChallengeManager.instance)
                  {
                     ChallengeManager.instance = new ChallengeManager();
                  }
                  ChallengeManager.instance.removePlayerChallenges(_loc1_.id);
                  _loc1_.dispose();
               }
            }
            players.splice(0,players.length);
         }
      }
      
      private static function battleServerConnected(param1:Message) : void
      {
         _connectedToBattleManager = true;
      }
      
      private static function battleServerDisconnect(param1:BattleServerDisconnectMessage) : void
      {
         _connectedToBattleManager = false;
      }
      
      private static function boosterActivated(param1:BoosterActivatedMessage) : void
      {
         if(isLocalPlayer(param1.playerId))
         {
            _boostersEnabled = false;
         }
      }
   }
}

