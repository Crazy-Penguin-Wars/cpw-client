package tuxwars
{
   import com.adobe.images.*;
   import com.citrusengine.physics.*;
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.game.*;
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.resources.*;
   import com.dchoc.states.State;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.KeyboardEvent;
   import flash.net.*;
   import flash.utils.*;
   import org.as3commons.zip.*;
   import starling.core.*;
   import starling.events.Event;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.net.*;
   import tuxwars.battle.states.*;
   import tuxwars.battle.world.*;
   import tuxwars.challenges.*;
   import tuxwars.data.*;
   import tuxwars.home.states.homestate.*;
   import tuxwars.home.ui.logic.dailynews.*;
   import tuxwars.home.ui.logic.inbox.*;
   import tuxwars.home.ui.screen.friendselector.*;
   import tuxwars.net.*;
   import tuxwars.player.*;
   import tuxwars.player.reports.*;
   import tuxwars.states.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.error.*;
   import tuxwars.ui.popups.states.wrongversion.*;
   
   public class TuxWarsGame extends DCGame
   {
      private static const ONE_HUNDRED_MEGS:uint = 104857600;
      
      private const _player:Player;
      
      private const _battleServer:BattleServer;
      
      private var _starling:Starling;
      
      private var _matchScreenShot:Bitmap;
      
      private var _dailyNewsData:DailyNewsData;
      
      private var _giftingInfo:GiftingInfo;
      
      private var _contextInfoSent:Boolean;
      
      public var _giftShown:Boolean;
      
      public var _slotMachineShown:Boolean;
      
      public var spinPressed:Boolean;
      
      public var _VIPMembershipShown:Boolean;
      
      public function TuxWarsGame(param1:Stage)
      {
         var _loc2_:* = undefined;
         this._player = new Player(true);
         this._battleServer = new BattleServer();
         MessageCenter.addListener("ErrorMessage",this.errorMessageHandler);
         MessageCenter.addListener("Wrong Version",this.wrongVersion);
         MessageCenter.addListener("ConfigLoaded",this.configLoaded);
         MessageCenter.addListener("GetGame",this.handleGetGame);
         InboxManager.init();
         ServerServices.init(this);
         JavaScriptServices.init(this);
         super(param1);
         trace(JSON.stringify(LoaderInfo(param1.root.loaderInfo).parameters));
         Config.init(LoaderInfo(param1.root.loaderInfo).parameters);
         Server.init();
         ResourceLoaderURL.getInstance();
         if(!ChallengeManager.instance)
         {
            ChallengeManager.instance = new ChallengeManager();
         }
         ChallengeManager.instance.init(this);
         SoundManager.addListeners();
         for each(_loc2_ in PhysicsGameObject.GROUP_ALL)
         {
            PhysicsCollisionCategories.Add(_loc2_);
         }
         trace("done");
      }
      
      public function createStarling() : void
      {
         if(this._starling)
         {
            this.disposeStarling();
         }
         Starling.handleLostContext = true;
         this._starling = new Starling(WorldContainer,DCGame.getStage());
         this._starling.shareContext = false;
         this._starling.enableErrorChecking = Config.isDev();
         this._starling.start();
         if(!this._contextInfoSent)
         {
            if(this._starling.context)
            {
               this.contextCreated(null);
            }
            else
            {
               this._starling.addEventListener("context3DCreate",this.contextCreated);
            }
         }
      }
      
      public function disposeStarling() : void
      {
         if(this._starling)
         {
            this._starling.dispose();
            this._starling = null;
         }
      }
      
      public function get battleServer() : BattleServer
      {
         return this._battleServer;
      }
      
      public function get player() : Player
      {
         return this._player;
      }
      
      public function get tuxWorld() : TuxWorld
      {
         return world as TuxWorld;
      }
      
      public function loadingCompleted() : void
      {
         gameLoaded = true;
         Stat.init();
         this.player.inventory.initInventory();
         DCGame.getStage().addEventListener("keyUp",this.keyUp,false,0,true);
         SoundManager.preLoadSounds();
         PlayerBattleReportCollector.init(this._player);
      }
      
      public function setUpDailyNews(param1:Array) : void
      {
         if(param1)
         {
            this._dailyNewsData = new DailyNewsData(param1);
         }
      }
      
      public function get dailyNewsData() : DailyNewsData
      {
         return this._dailyNewsData;
      }
      
      public function setUpGiftingInfo(param1:Object) : void
      {
         if(param1)
         {
            this._giftingInfo = new GiftingInfo(param1 as Object);
         }
         else
         {
            this._giftingInfo = new GiftingInfo(null);
         }
      }
      
      public function get giftingInfo() : GiftingInfo
      {
         return this._giftingInfo;
      }
      
      public function isInBattle() : Boolean
      {
         return this.battleState != null;
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
         var _loc1_:State = null;
         if(state != null)
         {
            _loc1_ = state;
            while(_loc1_.state != null)
            {
               _loc1_ = _loc1_.state;
            }
            return _loc1_;
         }
         return state;
      }
      
      public function get currentStateParent() : *
      {
         var _loc1_:State = null;
         var _loc2_:* = null;
         if(state != null)
         {
            _loc1_ = state;
            _loc2_ = state;
            while(_loc1_.state != null)
            {
               _loc2_ = _loc1_;
               _loc1_ = _loc1_.state;
            }
            return _loc2_;
         }
         return state;
      }
      
      public function get matchScreenShot() : Bitmap
      {
         return this._matchScreenShot;
      }
      
      public function set matchScreenShot(param1:Bitmap) : void
      {
         this._matchScreenShot = param1;
      }
      
      private function contextCreated(param1:Event) : void
      {
         this._starling.removeEventListener("context3DCreate",this.contextCreated);
         CRMService.sendEvent("GameData","Client",null,"Stage3D Driver Info",this._starling.context.driverInfo);
         LogUtils.log("Display Driver Info: " + this._starling.context.driverInfo,this,1,"ConfigInit");
         this._contextInfoSent = true;
      }
      
      private function handleGetGame(param1:Message) : void
      {
         MessageCenter.sendMessage("SendGame",this);
      }
      
      private function configLoaded(param1:Message) : void
      {
         this._player.id = Config.getUserId();
         changeState(new TuxLoadingState(this));
      }
      
      private function wrongVersion(param1:Message) : void
      {
         if(!PopUpManager.instance)
         {
            PopUpManager.instance = new PopUpManager();
         }
         PopUpManager.instance.addPopup(new WrongVersionPopupSubState(this));
         if(!PopUpManager.instance)
         {
            PopUpManager.instance = new PopUpManager();
         }
         PopUpManager.instance.showPopUps(this.homeState);
      }
      
      private function errorMessageHandler(param1:ErrorMessage) : void
      {
         var _loc2_:Object = null;
         LogUtils.log("ERROR: Code: " + param1.code + " Desc: " + param1.description,"TuxWarsGame",3,"ErrorLogging",true,true);
         if(param1.error)
         {
            LogUtils.log(param1.error.message,"TuxWarsGame",3,"ErrorLogging",false,false,true);
            LogUtils.log(!!param1.error.getStackTrace() ? param1.error.getStackTrace() : "No stacktrace available.","TuxWarsGame",3,"ErrorLogging",false,false,true);
         }
         MessageCenter.sendEvent(new BattleServerDisconnectMessage());
         if(this.currentState is TuxLoadingState)
         {
            TuxLoadingState(this.currentState).error(param1.code,param1.description);
         }
         else
         {
            _loc2_ = {
               "code":param1.code,
               "description":param1.description,
               "product":param1.product,
               "productDetail":param1.productDetail,
               "popupDataID":param1.popupDataID
            };
            if(this.homeState)
            {
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.addPopup(new ErrorPopupSubState(this,_loc2_));
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.showPopUps(this.homeState);
            }
            else
            {
               this.returnToHomeState(_loc2_);
            }
         }
      }
      
      private function returnToHomeState(param1:Object) : void
      {
         if(this.homeState)
         {
            this.homeState.exitCurrentState();
         }
         else
         {
            changeState(new HomeState(this,false),true);
         }
         if(param1)
         {
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.addPopup(new ErrorPopupSubState(this,param1));
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.showPopUps(this.homeState);
         }
      }
      
      private function keyUp(param1:KeyboardEvent) : void
      {
         if(Config.debugMode)
         {
            switch(param1.keyCode)
            {
               case 113:
                  this.saveAll();
                  break;
               case 50:
                  if(param1.ctrlKey)
                  {
                     this.saveAll();
                  }
            }
         }
         else if(param1.keyCode == 114 && param1.ctrlKey && param1.altKey)
         {
            this.saveAll("cpw");
         }
      }
      
      private function saveAll(param1:String = "zip") : void
      {
         var _loc10_:Vector.<String> = null;
         var _loc11_:* = undefined;
         var _loc12_:BattleServer = null;
         var _loc13_:* = undefined;
         var _loc2_:String = null;
         var _loc3_:String = "All";
         var _loc4_:LogUtils = LogUtils;
         var _loc5_:String = "";
         if(LogUtils.DEBUG_LOG.hasOwnProperty(_loc3_))
         {
            _loc10_ = LogUtils.DEBUG_LOG[_loc3_];
            for each(_loc11_ in _loc10_)
            {
               _loc5_ += _loc11_ + "\n";
            }
         }
         var _loc6_:String = _loc5_;
         var _loc7_:Zip = new Zip();
         _loc7_.addFileFromString(this.playerNameAndId() + "DebugLog.txt",_loc6_);
         if(this.matchScreenShot)
         {
            _loc7_.addFile(this.playerNameAndId() + "MatchScreenshot.png",PNGEncoder.encode(this.matchScreenShot.bitmapData));
         }
         _loc7_.addFile(this.playerNameAndId() + "Screenshot.png",PNGEncoder.encode(DCUtils.takeScreenShot().bitmapData));
         var _loc8_:BattleServer = this.battleServer;
         if(_loc8_._messages.length > 0)
         {
            _loc2_ = "";
            _loc12_ = this.battleServer;
            for each(_loc13_ in _loc12_._messages)
            {
               _loc2_ += _loc13_ + "\n";
            }
            _loc7_.addFileFromString(this.playerNameAndId() + "Messages.txt",_loc2_);
         }
         var _loc9_:ByteArray = new ByteArray();
         if(_loc9_.length < 104857600)
         {
            _loc7_.serialize(_loc9_);
            this.saveFile(_loc9_,this.playerNameAndId() + "DebugAll." + param1);
         }
         else
         {
            LogUtils.log("Log too big: " + _loc9_.length,this,3,"Game",true,true);
         }
      }
      
      private function saveFile(param1:*, param2:String) : void
      {
         var data:* = param1;
         var fileName:String = param2;
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
         return this._player.name + " (" + this._player.id + ") ";
      }
   }
}

