package tuxwars.home.states.customgame
{
   import com.dchoc.events.*;
   import com.dchoc.friends.Friend;
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.utils.*;
   import tuxwars.*;
   import tuxwars.battle.*;
   import tuxwars.battle.net.*;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.challenges.*;
   import tuxwars.data.*;
   import tuxwars.home.ui.logic.privategame.host.*;
   import tuxwars.states.*;
   import tuxwars.ui.components.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.error.*;
   import tuxwars.ui.popups.states.serverconnectionfailed.*;
   
   public class CustomGameConnectSubState extends TuxState
   {
      private var key:String;
      
      private var vip:Boolean;
      
      private var request:ServerRequest;
      
      protected var gameSettings:Object;
      
      private var _loadingIndicator:LoadingIndicatorScreen;
      
      public function CustomGameConnectSubState(param1:TuxWarsGame, param2:String, param3:ServerRequest)
      {
         super(param1,param2);
         var _loc4_:* = param2;
         BattleManager.customGameName = _loc4_;
         BattleManager.setPracticeMode(false);
         this.request = param3;
      }
      
      override public function enter() : void
      {
         super.enter();
         this.request.callback = this.playNowCallback;
         MessageCenter.sendEvent(this.request);
         this._loadingIndicator = new LoadingIndicatorScreen(game as TuxWarsGame,"COMMUNICATIONG_WITH_SERVER",250,0);
      }
      
      override public function exit() : void
      {
         MessageCenter.removeListener("BattleResponse",this.responseHandler);
         MessageCenter.removeListener("BattleServerConnectionFailed",this.serverConnectionFailedCallback);
         MessageCenter.removeListener("MaintenanceModeReply",this.maintanaceModeReply);
         MessageCenter.removeListener("ServerConnected",this.serverConnectedCallback);
         this._loadingIndicator.dispose();
         this._loadingIndicator = null;
         super.exit();
      }
      
      protected function get isOwner() : Boolean
      {
         throw new Error("This method must be implemented by sub-classes!");
      }
      
      protected function get nextState() : TuxState
      {
         throw new Error("This method must be implemented by sub-classes!");
      }
      
      private function playNowCallback(param1:ServerResponse) : void
      {
         var _loc2_:Object = param1.data;
         this.key = _loc2_.key;
         this.vip = _loc2_.vip_active_for_this_match;
         LogUtils.log("Got key from server: " + this.key + " vip: " + this.vip + " (" + this.request.serviceId + ")",this,1,"Server");
         this.handleDummyPlayer(_loc2_);
         MessageCenter.addListener("ServerConnected",this.serverConnectedCallback);
         MessageCenter.addListener("BattleServerConnectionFailed",this.serverConnectionFailedCallback);
         MessageCenter.sendEvent(new BattleServerConnectMessage(_loc2_.host,_loc2_.port));
         LogUtils.log("Connecting to " + _loc2_.host + ":" + _loc2_.port,this,1,"Server");
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
            MessageCenter.sendEvent(new ErrorMessage("Maintenance Mode","Maintenance Mode","Maintenance mode is active",null,null,"error_maintenance_ongoing"));
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
            PopUpManager.instance.showPopUps(tuxGame.state as TuxState);
         }
      }
      
      private function serverConnectedCallback(param1:Message) : void
      {
         LogUtils.log("Connected to match maker.",this,1,"Server");
         MessageCenter.removeListener("ServerConnected",this.serverConnectedCallback);
         MessageCenter.addListener("BattleResponse",this.responseHandler);
         MessageCenter.sendEvent(new ConnectMessage(29,this.key,tuxGame.player.id,2,Config.getOS(),params,this.isOwner));
      }
      
      private function responseHandler(param1:BattleResponse) : void
      {
         if(param1.responseType == 31)
         {
            if(param1.data.successful)
            {
               if(this.isOwner)
               {
                  tuxGame.homeState.changeState(this.nextState);
               }
            }
            else
            {
               MessageCenter.sendEvent(new BattleServerDisconnectMessage());
               if(Boolean(this.request.data) && Boolean(this.request.data.private_game_rematch))
               {
                  tuxGame.homeState.changeState(new CustomGameJoinSubState(tuxGame,BattleManager.customGameName,new ServerRequest("PlayNow",this.request.data)));
               }
               else
               {
                  if(!PopUpManager.instance)
                  {
                     PopUpManager.instance = new PopUpManager();
                  }
                  PopUpManager.instance.addPopup(new ErrorPopupSubState(game,{
                     "code":"Game Creation Failed",
                     "description":"Server refused to create a private game for you."
                  }));
                  if(!PopUpManager.instance)
                  {
                     PopUpManager.instance = new PopUpManager();
                  }
                  PopUpManager.instance.showPopUps(parent as TuxState);
               }
            }
         }
         else if(param1.responseType == 30)
         {
            this.gameSettings = param1.data;
            tuxGame.homeState.changeState(this.nextState);
         }
         else
         {
            LogUtils.log("Invalid message: " + param1.responseText,this,3,"ErrorLogging",true,true);
         }
      }
      
      protected function createGameModel(param1:String) : PrivateGameModel
      {
         var _loc2_:PrivateGameModel = new PrivateGameModel(param1,MatchData.getDefaultMatchData(),this.key,this.vip);
         _loc2_.players.push(this.createLocalPlayerData());
         return _loc2_;
      }
      
      private function createLocalPlayerData() : PlayerSlotData
      {
         var _loc3_:* = undefined;
         var _loc1_:Friend = tuxGame.player.friends.findMe();
         var _loc2_:PlayerSlotData = new PlayerSlotData(tuxGame.player.id,tuxGame.player.name,tuxGame.player.level,_loc1_.picUrl);
         for each(_loc3_ in tuxGame.player.wornItemsContainer.getWornItems())
         {
            _loc2_.clothes.push(_loc3_);
         }
         return _loc2_;
      }
      
      private function handleDummyPlayer(param1:Object) : void
      {
         var _loc2_:Challenges = null;
         if(param1.dcg_id != tuxGame.player.id)
         {
            LogUtils.addDebugLine("Player","Changing dummy player\'s id to " + param1.dcg_id);
            if(!ChallengeManager.instance)
            {
               ChallengeManager.instance = new ChallengeManager();
            }
            _loc2_ = ChallengeManager.instance.getPlayerChallenges(tuxGame.player.id);
            tuxGame.player.id = param1.dcg_id;
            Config.setUserId(param1.dcg_id);
            if(!ChallengeManager.instance)
            {
               ChallengeManager.instance = new ChallengeManager();
            }
            ChallengeManager.instance.addPlayerChallenges(param1.dcg_id,_loc2_.data,false);
            tuxGame.player.dummy = true;
         }
      }
   }
}

