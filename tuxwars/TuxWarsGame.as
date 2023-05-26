package tuxwars
{
   import com.adobe.images.PNGEncoder;
   import com.citrusengine.physics.PhysicsCollisionCategories;
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.game.DCGame;
   import com.dchoc.game.WorldContainer;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.Server;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.states.State;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.Bitmap;
   import flash.display.LoaderInfo;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.net.FileReference;
   import flash.utils.ByteArray;
   import no.olog.Olog;
   import org.as3commons.zip.Zip;
   import starling.core.Starling;
   import starling.events.Event;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.net.BattleServer;
   import tuxwars.battle.net.BattleServerDisconnectMessage;
   import tuxwars.battle.states.TuxBattleState;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.data.SoundManager;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.home.ui.logic.dailynews.DailyNewsData;
   import tuxwars.home.ui.logic.inbox.InboxManager;
   import tuxwars.home.ui.screen.friendselector.GiftingInfo;
   import tuxwars.net.CRMService;
   import tuxwars.net.JavaScriptServices;
   import tuxwars.net.ServerServices;
   import tuxwars.player.Player;
   import tuxwars.player.reports.PlayerBattleReportCollector;
   import tuxwars.states.TuxLoadingState;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.error.ErrorPopupSubState;
   import tuxwars.ui.popups.states.wrongversion.WrongVersionPopupSubState;
   
   public class TuxWarsGame extends DCGame
   {
      
      private static const ONE_HUNDRED_MEGS:uint = 104857600;
      
      {
         ClassReferences;
      }
      
      private const _player:Player = new Player(true);
      
      private const _battleServer:BattleServer = new BattleServer();
      
      private var _starling:Starling;
      
      private var _matchScreenShot:Bitmap;
      
      private var _dailyNewsData:DailyNewsData;
      
      private var _giftingInfo:GiftingInfo;
      
      private var _contextInfoSent:Boolean;
      
      public var _giftShown:Boolean;
      
      public var _slotMachineShown:Boolean;
      
      public var spinPressed:Boolean;
      
      public var _VIPMembershipShown:Boolean;
      
      public function TuxWarsGame(stage:Stage)
      {
         MessageCenter.addListener("ErrorMessage",errorMessageHandler);
         MessageCenter.addListener("Wrong Version",wrongVersion);
         MessageCenter.addListener("ConfigLoaded",configLoaded);
         MessageCenter.addListener("GetGame",handleGetGame);
         InboxManager.init();
         ServerServices.init(this);
         JavaScriptServices.init(this);
         super(stage);
         Config.init(LoaderInfo(com.dchoc.game.DCGame._stage.root.loaderInfo).parameters);
         if(Config.debugMode)
         {
            var _loc3_:Olog = Olog;
            no.olog.Ocore.setCMI(false);
            var _loc4_:Olog = Olog;
            stage.addChild(no.olog.Owindow.instance);
            var _loc5_:Olog = Olog;
            no.olog.Oplist.stackRepeatedMessages = true;
            Olog.close();
         }
         Server.init();
         ResourceLoaderURL.getInstance();
         var _loc6_:ChallengeManager = ChallengeManager;
         if(!tuxwars.challenges.ChallengeManager._instance)
         {
            tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
         }
         tuxwars.challenges.ChallengeManager._instance.init(this);
         SoundManager.addListeners();
         for each(var group in PhysicsGameObject.GROUP_ALL)
         {
            PhysicsCollisionCategories.Add(group);
         }
      }
      
      public function createStarling() : void
      {
         if(_starling)
         {
            disposeStarling();
         }
         Starling.handleLostContext = true;
         _starling = new Starling(WorldContainer,com.dchoc.game.DCGame._stage);
         _starling.shareContext = false;
         _starling.enableErrorChecking = Config.isDev();
         _starling.start();
         if(!_contextInfoSent)
         {
            if(_starling.context)
            {
               contextCreated(null);
            }
            else
            {
               _starling.addEventListener("context3DCreate",contextCreated);
            }
         }
      }
      
      public function disposeStarling() : void
      {
         if(_starling)
         {
            _starling.dispose();
            _starling = null;
         }
      }
      
      public function get battleServer() : BattleServer
      {
         return _battleServer;
      }
      
      public function get player() : Player
      {
         return _player;
      }
      
      public function get tuxWorld() : TuxWorld
      {
         return world as TuxWorld;
      }
      
      public function loadingCompleted() : void
      {
         gameLoaded = true;
         Stat.init();
         player.inventory.initInventory();
         var _loc1_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.addEventListener("keyUp",keyUp,false,0,true);
         SoundManager.preLoadSounds();
         PlayerBattleReportCollector.init(_player);
      }
      
      public function setUpDailyNews(data:Array) : void
      {
         if(data)
         {
            _dailyNewsData = new DailyNewsData(data);
         }
      }
      
      public function get dailyNewsData() : DailyNewsData
      {
         return _dailyNewsData;
      }
      
      public function setUpGiftingInfo(data:Object) : void
      {
         if(data)
         {
            _giftingInfo = new GiftingInfo(data as Object);
         }
         else
         {
            _giftingInfo = new GiftingInfo(null);
         }
      }
      
      public function get giftingInfo() : GiftingInfo
      {
         return _giftingInfo;
      }
      
      public function isInBattle() : Boolean
      {
         return battleState != null;
      }
      
      public function get battleState() : TuxBattleState
      {
         return state as TuxBattleState;
      }
      
      public function get homeState() : HomeState
      {
         return state as HomeState;
      }
      
      public function get currentState() : *
      {
         var testState:* = null;
         if(state != null)
         {
            testState = state;
            while(testState.state != null)
            {
               testState = testState.state;
            }
            return testState;
         }
         return state;
      }
      
      public function get currentStateParent() : *
      {
         var testState:* = null;
         var previousState:* = null;
         if(state != null)
         {
            testState = state;
            previousState = state;
            while(testState.state != null)
            {
               previousState = testState;
               testState = testState.state;
            }
            return previousState;
         }
         return state;
      }
      
      public function get matchScreenShot() : Bitmap
      {
         return _matchScreenShot;
      }
      
      public function set matchScreenShot(screenShot:Bitmap) : void
      {
         _matchScreenShot = screenShot;
      }
      
      private function contextCreated(event:Event) : void
      {
         _starling.removeEventListener("context3DCreate",contextCreated);
         CRMService.sendEvent("GameData","Client",null,"Stage3D Driver Info",_starling.context.driverInfo);
         LogUtils.log("Display Driver Info: " + _starling.context.driverInfo,this,1,"ConfigInit");
         _contextInfoSent = true;
      }
      
      private function handleGetGame(msg:Message) : void
      {
         MessageCenter.sendMessage("SendGame",this);
      }
      
      private function configLoaded(msg:Message) : void
      {
         _player.id = Config.getUserId();
         changeState(new TuxLoadingState(this));
      }
      
      private function wrongVersion(msg:Message) : void
      {
         var _loc2_:PopUpManager = PopUpManager;
         if(!tuxwars.ui.popups.PopUpManager._instance)
         {
            tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
         }
         tuxwars.ui.popups.PopUpManager._instance.addPopup(new WrongVersionPopupSubState(this));
         var _loc3_:PopUpManager = PopUpManager;
         if(!tuxwars.ui.popups.PopUpManager._instance)
         {
            tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
         }
         tuxwars.ui.popups.PopUpManager._instance.showPopUps(homeState);
      }
      
      private function errorMessageHandler(msg:ErrorMessage) : void
      {
         var _loc2_:* = null;
         LogUtils.log("ERROR: Code: " + msg.code + " Desc: " + msg.description,"TuxWarsGame",3,"ErrorLogging",true,true);
         if(msg.error)
         {
            LogUtils.log(msg.error.message,"TuxWarsGame",3,"ErrorLogging",false,false,true);
            LogUtils.log(!!msg.error.getStackTrace() ? msg.error.getStackTrace() : "No stacktrace available.","TuxWarsGame",3,"ErrorLogging",false,false,true);
         }
         MessageCenter.sendEvent(new BattleServerDisconnectMessage());
         if(currentState is TuxLoadingState)
         {
            TuxLoadingState(currentState).error(msg.code,msg.description);
         }
         else
         {
            _loc2_ = {
               "code":msg.code,
               "description":msg.description,
               "product":msg.product,
               "productDetail":msg.productDetail,
               "popupDataID":msg.popupDataID
            };
            if(homeState)
            {
               var _loc3_:PopUpManager = PopUpManager;
               if(!tuxwars.ui.popups.PopUpManager._instance)
               {
                  tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
               }
               tuxwars.ui.popups.PopUpManager._instance.addPopup(new ErrorPopupSubState(this,_loc2_));
               var _loc4_:PopUpManager = PopUpManager;
               if(!tuxwars.ui.popups.PopUpManager._instance)
               {
                  tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
               }
               tuxwars.ui.popups.PopUpManager._instance.showPopUps(homeState);
            }
            else
            {
               returnToHomeState(_loc2_);
            }
         }
      }
      
      private function returnToHomeState(data:Object) : void
      {
         if(homeState)
         {
            homeState.exitCurrentState();
         }
         else
         {
            changeState(new HomeState(this,false),true);
         }
         if(data)
         {
            var _loc2_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.addPopup(new ErrorPopupSubState(this,data));
            var _loc3_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.showPopUps(homeState);
         }
      }
      
      private function keyUp(event:KeyboardEvent) : void
      {
         if(Config.debugMode)
         {
            switch(event.keyCode)
            {
               case 113:
                  saveAll();
                  break;
               case 50:
                  if(event.ctrlKey)
                  {
                     saveAll();
                     break;
                  }
            }
         }
         else if(event.keyCode == 114 && event.ctrlKey && event.altKey)
         {
            saveAll("cpw");
         }
      }
      
      private function saveAll(ext:String = "zip") : void
      {
         var str:* = null;
         var _loc7_:LogUtils = LogUtils;
         var _loc17_:String = "";
         if(com.dchoc.utils.LogUtils.DEBUG_LOG.hasOwnProperty("All"))
         {
            var _loc16_:Vector.<String> = com.dchoc.utils.LogUtils.DEBUG_LOG["All"];
            for each(var _loc15_ in _loc16_)
            {
               _loc17_ += _loc15_ + "\n";
            }
         }
         var _loc5_:String = _loc17_;
         var _loc2_:Zip = new Zip();
         _loc2_.addFileFromString(playerNameAndId() + "DebugLog.txt",_loc5_);
         if(matchScreenShot)
         {
            _loc2_.addFile(playerNameAndId() + "MatchScreenshot.png",PNGEncoder.encode(matchScreenShot.bitmapData));
         }
         _loc2_.addFile(playerNameAndId() + "Screenshot.png",PNGEncoder.encode(DCUtils.takeScreenShot().bitmapData));
         var _loc10_:BattleServer = battleServer;
         if(_loc10_._messages.length > 0)
         {
            str = "";
            var _loc11_:BattleServer = battleServer;
            for each(var msg in _loc11_._messages)
            {
               str += msg + "\n";
            }
            _loc2_.addFileFromString(playerNameAndId() + "Messages.txt",str);
         }
         var _loc3_:ByteArray = new ByteArray();
         if(_loc3_.length < 104857600)
         {
            _loc2_.serialize(_loc3_);
            saveFile(_loc3_,playerNameAndId() + "DebugAll." + ext);
         }
         else
         {
            LogUtils.log("Log too big: " + _loc3_.length,this,3,"Game",true,true);
         }
      }
      
      private function saveFile(data:*, fileName:String) : void
      {
         var _loc3_:FileReference = new FileReference();
         try
         {
            _loc3_.save(data,fileName);
         }
         catch(e:Error)
         {
            LogUtils.log("Save operation requires FlashPlayer 10","HomeState",2,"Game",false,false,true);
         }
      }
      
      private function playerNameAndId() : String
      {
         return _player.name + " (" + _player.id + ") ";
      }
   }
}
