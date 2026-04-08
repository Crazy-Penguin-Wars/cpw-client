package tuxwars.home.states.matchloading.connecting
{
   import com.dchoc.events.*;
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.net.*;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.events.*;
   import tuxwars.home.states.*;
   import tuxwars.home.states.matchloading.*;
   import tuxwars.home.states.matchloading.levelloading.*;
   import tuxwars.net.*;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.serverconnectionfailed.*;
   
   public class ConnectToBattleServerSubState extends TuxState
   {
      private var matchMakerKey:String;
      
      private var gameReady:Boolean;
      
      private var response:BattleResponse;
      
      private var preloadingFinished:Boolean;
      
      public function ConnectToBattleServerSubState(param1:TuxWarsGame, param2:Object)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         MessageCenter.sendEvent(new TextIDMessage("MATCH_LOADING_CONNECTING_TO_SERVER"));
         MessageCenter.addListener("BattleAssetsLoaded",this.battleAssetsLoaded);
         MessageCenter.addListener("BattleResponse",this.serverResponseHandler);
         changeState(new BattleAssetLoadingSubState(tuxGame));
         MessageCenter.addListener("BattleServerConnectionFailed",this.serverConnectionFailedCallback);
         var _loc1_:Object = params;
         if(_loc1_.key != null)
         {
            MessageCenter.addListener("ServerConnected",this.matchMakerServerConnected);
            this.matchMakerKey = _loc1_.key.toString();
            LogUtils.log("Match maker key: " + this.matchMakerKey,this,1,"Match",true);
            MessageCenter.sendEvent(new BattleServerConnectMessage(_loc1_.host,_loc1_.port));
         }
         else if(_loc1_.matchKey != null)
         {
            MessageCenter.addListener("ServerConnected",this.battleServerConnected);
            this.matchMakerKey = _loc1_.matchKey.toString();
            LogUtils.log("Match maker key: " + this.matchMakerKey,this,1,"Match",true);
            MessageCenter.sendEvent(new BattleServerConnectMessage(_loc1_.address,_loc1_.port));
         }
         else
         {
            MessageCenter.sendEvent(new ErrorMessage("Internal error","ConnectToBattleServerSubStateEnter","No MM key."));
         }
      }
      
      override public function exit() : void
      {
         if(Tutorial._tutorial)
         {
            CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Cancelled","PressPlay","PressCancel");
         }
         CRMService.sendEvent("Game","MatchMaker","Cancelled","PressPlay","PressCancel");
         MessageCenter.removeListener("ServerConnected",this.matchMakerServerConnected);
         MessageCenter.removeListener("ServerConnected",this.battleServerConnected);
         MessageCenter.removeListener("BattleResponse",this.serverResponseHandler);
         MessageCenter.removeListener("BattleServerConnectionFailed",this.serverConnectionFailedCallback);
         MessageCenter.removeListener("MaintenanceModeReply",this.maintanaceModeReply);
         this.response = null;
         super.exit();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(Boolean(this.gameReady) && Boolean(this.preloadingFinished))
         {
            parent.changeState(new LevelLoadingSubState(tuxGame,this.response.data,params.vip_active_for_this_match,params.tournament));
         }
      }
      
      private function matchMakerServerConnected(param1:Message) : void
      {
         MessageCenter.removeListener("ServerConnected",this.matchMakerServerConnected);
         LogUtils.log("Connected to matchmaker, sending connect message",this,1,"Match",true);
         var _loc2_:Object = params;
         var _loc3_:String = _loc2_.game_identifier;
         var _loc4_:int = int(_loc2_.player_count);
         var _loc5_:int = Boolean(_loc3_) && _loc4_ > 0 ? 3 : 1;
         var _loc6_:String = !!tuxGame.player.betData ? tuxGame.player.betData.id : null;
         MessageCenter.sendEvent(new ConnectMessage(29,this.matchMakerKey,tuxGame.player.id,_loc5_,Config.getOS(),null,false,_loc3_,_loc4_,_loc6_));
      }
      
      private function battleServerConnected(param1:Message) : void
      {
         MessageCenter.removeListener("ServerConnected",this.battleServerConnected);
         LogUtils.log("Connected to battle server, sending connect message",this,1,"Match",true);
         BattleManager.init(tuxGame);
         var _loc2_:String = !!tuxGame.player.betData ? tuxGame.player.betData.id : null;
         MessageCenter.sendEvent(new ConnectMessage(26,this.matchMakerKey,tuxGame.player.id,0,Config.getOS(),null,true,null,0,_loc2_));
         MessageCenter.sendMessage("BattleServerConnected");
      }
      
      private function serverResponseHandler(param1:BattleResponse) : void
      {
         var _loc2_:Object = null;
         if(param1.responseType == 27)
         {
            MessageCenter.sendEvent(new BattleServerDisconnectMessage());
            MessageCenter.addListener("ServerConnected",this.battleServerConnected);
            _loc2_ = param1.data;
            LogUtils.log("Connecting to " + _loc2_.address + ":" + _loc2_.port,this,1,"Server",true);
            MessageCenter.sendEvent(new BattleServerConnectMessage(_loc2_.address,_loc2_.port));
         }
         else if(param1.responseType == 21)
         {
            this.response = param1;
            this.gameReady = true;
            if(!this.preloadingFinished)
            {
               MessageCenter.sendEvent(new TextIDMessage("MATCH_LOADING_ASSETS"));
            }
         }
         else if(param1.responseType == 19)
         {
            tuxGame.homeState.exitCurrentState();
            if(params.key != null)
            {
               tuxGame.homeState.changeState(new MultiplayerMatchLoadingSubState(tuxGame,new ServerRequest("PlayNow")));
            }
         }
      }
      
      private function battleAssetsLoaded(param1:Message) : void
      {
         MessageCenter.removeListener("BattleAssetsLoaded",this.battleAssetsLoaded);
         this.preloadingFinished = true;
         exitCurrentState();
         if(!this.gameReady)
         {
            MessageCenter.sendEvent(new TextIDMessage("MATCH_LOADING_CONNECT_TO_MATCH_MAKER"));
         }
      }
      
      private function serverConnectionFailedCallback(param1:Message) : void
      {
         MessageCenter.addListener("MaintenanceModeReply",this.maintanaceModeReply);
         MessageCenter.sendMessage("MaintenanceMode");
      }
      
      private function maintanaceModeReply(param1:Message) : void
      {
         MessageCenter.removeListener("MaintenanceModeReply",this.maintanaceModeReply);
         var _loc2_:Boolean = param1.data;
         if(_loc2_)
         {
            MessageCenter.sendEvent(new ErrorMessage("Maintanace Mode","Maintanace Mode","Maintanance mode is active",null,null,"error_maintenance_ongoing"));
         }
         else
         {
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.addPopup(new ServerConnectionFailedMessagePopUpSubState(tuxGame));
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.showPopUps(tuxGame.homeState);
         }
      }
   }
}

