package tuxwars.home.states.matchloading.connecting
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.BattleResponse;
   import tuxwars.battle.net.BattleServerConnectMessage;
   import tuxwars.battle.net.BattleServerDisconnectMessage;
   import tuxwars.battle.net.messages.control.ConnectMessage;
   import tuxwars.events.TextIDMessage;
   import tuxwars.home.states.BattleAssetLoadingSubState;
   import tuxwars.home.states.matchloading.MultiplayerMatchLoadingSubState;
   import tuxwars.home.states.matchloading.levelloading.LevelLoadingSubState;
   import tuxwars.net.CRMService;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.serverconnectionfailed.ServerConnectionFailedMessagePopUpSubState;
   
   public class ConnectToBattleServerSubState extends TuxState
   {
       
      
      private var matchMakerKey:String;
      
      private var gameReady:Boolean;
      
      private var response:BattleResponse;
      
      private var preloadingFinished:Boolean;
      
      public function ConnectToBattleServerSubState(game:TuxWarsGame, data:Object)
      {
         super(game,data);
      }
      
      override public function enter() : void
      {
         super.enter();
         MessageCenter.sendEvent(new TextIDMessage("MATCH_LOADING_CONNECTING_TO_SERVER"));
         MessageCenter.addListener("BattleAssetsLoaded",battleAssetsLoaded);
         MessageCenter.addListener("BattleResponse",serverResponseHandler);
         changeState(new BattleAssetLoadingSubState(tuxGame));
         MessageCenter.addListener("BattleServerConnectionFailed",serverConnectionFailedCallback);
         var _loc1_:Object = params;
         if(_loc1_.key != null)
         {
            MessageCenter.addListener("ServerConnected",matchMakerServerConnected);
            matchMakerKey = _loc1_.key.toString();
            LogUtils.log("Match maker key: " + matchMakerKey,this,1,"Match",true);
            MessageCenter.sendEvent(new BattleServerConnectMessage(_loc1_.host,_loc1_.port));
         }
         else if(_loc1_.matchKey != null)
         {
            MessageCenter.addListener("ServerConnected",battleServerConnected);
            matchMakerKey = _loc1_.matchKey.toString();
            LogUtils.log("Match maker key: " + matchMakerKey,this,1,"Match",true);
            MessageCenter.sendEvent(new BattleServerConnectMessage(_loc1_.address,_loc1_.port));
         }
         else
         {
            MessageCenter.sendEvent(new ErrorMessage("Internal error","ConnectToBattleServerSubStateEnter","No MM key."));
         }
      }
      
      override public function exit() : void
      {
         var _loc1_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            CRMService.sendEvent("Tutorial","Play_Tutorial","Cancelled","PressPlay","PressCancel");
         }
         CRMService.sendEvent("Game","MatchMaker","Cancelled","PressPlay","PressCancel");
         MessageCenter.removeListener("ServerConnected",matchMakerServerConnected);
         MessageCenter.removeListener("ServerConnected",battleServerConnected);
         MessageCenter.removeListener("BattleResponse",serverResponseHandler);
         MessageCenter.removeListener("BattleServerConnectionFailed",serverConnectionFailedCallback);
         MessageCenter.removeListener("MaintenanceModeReply",maintanaceModeReply);
         response = null;
         super.exit();
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(gameReady && preloadingFinished)
         {
            parent.changeState(new LevelLoadingSubState(tuxGame,response.data,params.vip_active_for_this_match,params.tournament));
         }
      }
      
      private function matchMakerServerConnected(msg:Message) : void
      {
         MessageCenter.removeListener("ServerConnected",matchMakerServerConnected);
         LogUtils.log("Connected to matchmaker, sending connect message",this,1,"Match",true);
         var _loc3_:Object = params;
         var _loc5_:String = _loc3_.game_identifier;
         var _loc4_:int = int(_loc3_.player_count);
         var _loc2_:int = _loc5_ && _loc4_ > 0 ? 3 : 1;
         var _loc6_:String = !!tuxGame.player.betData ? tuxGame.player.betData.id : null;
         MessageCenter.sendEvent(new ConnectMessage(29,matchMakerKey,tuxGame.player.id,_loc2_,Config.getOS(),null,false,_loc5_,_loc4_,_loc6_));
      }
      
      private function battleServerConnected(msg:Message) : void
      {
         MessageCenter.removeListener("ServerConnected",battleServerConnected);
         LogUtils.log("Connected to battle server, sending connect message",this,1,"Match",true);
         BattleManager.init(tuxGame);
         var _loc2_:String = !!tuxGame.player.betData ? tuxGame.player.betData.id : null;
         MessageCenter.sendEvent(new ConnectMessage(26,matchMakerKey,tuxGame.player.id,0,Config.getOS(),null,true,null,0,_loc2_));
         MessageCenter.sendMessage("BattleServerConnected");
      }
      
      private function serverResponseHandler(response:BattleResponse) : void
      {
         var _loc2_:* = null;
         if(response.responseType == 27)
         {
            MessageCenter.sendEvent(new BattleServerDisconnectMessage());
            MessageCenter.addListener("ServerConnected",battleServerConnected);
            _loc2_ = response.data;
            LogUtils.log("Connecting to " + _loc2_.address + ":" + _loc2_.port,this,1,"Server",true);
            MessageCenter.sendEvent(new BattleServerConnectMessage(_loc2_.address,_loc2_.port));
         }
         else if(response.responseType == 21)
         {
            this.response = response;
            gameReady = true;
            if(!preloadingFinished)
            {
               MessageCenter.sendEvent(new TextIDMessage("MATCH_LOADING_ASSETS"));
            }
         }
         else if(response.responseType == 19)
         {
            tuxGame.homeState.exitCurrentState();
            if(params.key != null)
            {
               tuxGame.homeState.changeState(new MultiplayerMatchLoadingSubState(tuxGame,new ServerRequest("PlayNow")));
            }
         }
      }
      
      private function battleAssetsLoaded(msg:Message) : void
      {
         MessageCenter.removeListener("BattleAssetsLoaded",battleAssetsLoaded);
         preloadingFinished = true;
         exitCurrentState();
         if(!gameReady)
         {
            MessageCenter.sendEvent(new TextIDMessage("MATCH_LOADING_CONNECT_TO_MATCH_MAKER"));
         }
      }
      
      private function serverConnectionFailedCallback(msg:Message) : void
      {
         MessageCenter.addListener("MaintenanceModeReply",maintanaceModeReply);
         MessageCenter.sendMessage("MaintenanceMode");
      }
      
      private function maintanaceModeReply(msg:Message) : void
      {
         MessageCenter.removeListener("MaintenanceModeReply",maintanaceModeReply);
         var _loc2_:Boolean = msg.data;
         if(_loc2_)
         {
            MessageCenter.sendEvent(new ErrorMessage("Maintanace Mode","Maintanace Mode","Maintanance mode is active",null,null,"error_maintenance_ongoing"));
         }
         else
         {
            var _loc3_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.addPopup(new ServerConnectionFailedMessagePopUpSubState(tuxGame));
            var _loc4_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.showPopUps(tuxGame.homeState);
         }
      }
   }
}
