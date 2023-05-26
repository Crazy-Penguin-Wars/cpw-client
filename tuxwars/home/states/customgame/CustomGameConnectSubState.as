package tuxwars.home.states.customgame
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.friends.Friend;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.net.ServerResponse;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.BattleResponse;
   import tuxwars.battle.net.BattleServerConnectMessage;
   import tuxwars.battle.net.BattleServerDisconnectMessage;
   import tuxwars.battle.net.messages.control.ConnectMessage;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.Challenges;
   import tuxwars.data.MatchData;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.ui.logic.privategame.host.PlayerSlotData;
   import tuxwars.items.ClothingItem;
   import tuxwars.states.TuxState;
   import tuxwars.ui.components.LoadingIndicatorScreen;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.error.ErrorPopupSubState;
   import tuxwars.ui.popups.states.serverconnectionfailed.ServerConnectionFailedMessagePopUpSubState;
   
   public class CustomGameConnectSubState extends TuxState
   {
       
      
      private var key:String;
      
      private var vip:Boolean;
      
      private var request:ServerRequest;
      
      protected var gameSettings:Object;
      
      private var _loadingIndicator:LoadingIndicatorScreen;
      
      public function CustomGameConnectSubState(game:TuxWarsGame, gameName:String, request:ServerRequest)
      {
         super(game,gameName);
         var _loc5_:* = gameName;
         var _loc4_:BattleManager = BattleManager;
         tuxwars.battle.BattleManager._customGameName = _loc5_;
         BattleManager.setPracticeMode(false);
         this.request = request;
      }
      
      override public function enter() : void
      {
         super.enter();
         request.callback = playNowCallback;
         MessageCenter.sendEvent(request);
         _loadingIndicator = new LoadingIndicatorScreen(game as TuxWarsGame,"COMMUNICATIONG_WITH_SERVER",250,0);
      }
      
      override public function exit() : void
      {
         MessageCenter.removeListener("BattleResponse",responseHandler);
         MessageCenter.removeListener("BattleServerConnectionFailed",serverConnectionFailedCallback);
         MessageCenter.removeListener("MaintenanceModeReply",maintanaceModeReply);
         MessageCenter.removeListener("ServerConnected",serverConnectedCallback);
         _loadingIndicator.dispose();
         _loadingIndicator = null;
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
      
      private function playNowCallback(response:ServerResponse) : void
      {
         var _loc2_:Object = response.data;
         key = _loc2_.key;
         vip = _loc2_.vip_active_for_this_match;
         LogUtils.log("Got key from server: " + key + " vip: " + vip + " (" + request.serviceId + ")",this,1,"Server");
         handleDummyPlayer(_loc2_);
         MessageCenter.addListener("ServerConnected",serverConnectedCallback);
         MessageCenter.addListener("BattleServerConnectionFailed",serverConnectionFailedCallback);
         MessageCenter.sendEvent(new BattleServerConnectMessage(_loc2_.host,_loc2_.port));
         LogUtils.log("Connecting to " + _loc2_.host + ":" + _loc2_.port,this,1,"Server");
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
            MessageCenter.sendEvent(new ErrorMessage("Maintenance Mode","Maintenance Mode","Maintenance mode is active",null,null,"error_maintenance_ongoing"));
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
            tuxwars.ui.popups.PopUpManager._instance.showPopUps(tuxGame.state as TuxState);
         }
      }
      
      private function serverConnectedCallback(msg:Message) : void
      {
         LogUtils.log("Connected to match maker.",this,1,"Server");
         MessageCenter.removeListener("ServerConnected",serverConnectedCallback);
         MessageCenter.addListener("BattleResponse",responseHandler);
         MessageCenter.sendEvent(new ConnectMessage(29,key,tuxGame.player.id,2,Config.getOS(),params,isOwner));
      }
      
      private function responseHandler(response:BattleResponse) : void
      {
         if(response.responseType == 31)
         {
            if(response.data.successful)
            {
               if(isOwner)
               {
                  tuxGame.homeState.changeState(nextState);
               }
            }
            else
            {
               MessageCenter.sendEvent(new BattleServerDisconnectMessage());
               if(request.data && request.data.private_game_rematch)
               {
                  var _loc2_:BattleManager = BattleManager;
                  tuxGame.homeState.changeState(new CustomGameJoinSubState(tuxGame,tuxwars.battle.BattleManager._customGameName,new ServerRequest("PlayNow",request.data)));
               }
               else
               {
                  var _loc3_:PopUpManager = PopUpManager;
                  if(!tuxwars.ui.popups.PopUpManager._instance)
                  {
                     tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
                  }
                  tuxwars.ui.popups.PopUpManager._instance.addPopup(new ErrorPopupSubState(game,{
                     "code":"Game Creation Failed",
                     "description":"Server refused to create a private game for you."
                  }));
                  var _loc4_:PopUpManager = PopUpManager;
                  if(!tuxwars.ui.popups.PopUpManager._instance)
                  {
                     tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
                  }
                  tuxwars.ui.popups.PopUpManager._instance.showPopUps(parent as TuxState);
               }
            }
         }
         else if(response.responseType == 30)
         {
            gameSettings = response.data;
            tuxGame.homeState.changeState(nextState);
         }
         else
         {
            LogUtils.log("Invalid message: " + response.responseText,this,3,"ErrorLogging",true,true);
         }
      }
      
      protected function createGameModel(name:String) : PrivateGameModel
      {
         var _loc2_:PrivateGameModel = new PrivateGameModel(name,MatchData.getDefaultMatchData(),key,vip);
         _loc2_.players.push(createLocalPlayerData());
         return _loc2_;
      }
      
      private function createLocalPlayerData() : PlayerSlotData
      {
         var _loc3_:Friend = tuxGame.player.friends.findMe();
         var _loc2_:PlayerSlotData = new PlayerSlotData(tuxGame.player.id,tuxGame.player.name,tuxGame.player.level,_loc3_.picUrl);
         for each(var clothing in tuxGame.player.wornItemsContainer.getWornItems())
         {
            _loc2_.clothes.push(clothing);
         }
         return _loc2_;
      }
      
      private function handleDummyPlayer(data:Object) : void
      {
         var _loc2_:* = null;
         if(data.dcg_id != tuxGame.player.id)
         {
            LogUtils.addDebugLine("Player","Changing dummy player\'s id to " + data.dcg_id);
            var _loc3_:ChallengeManager = ChallengeManager;
            if(!tuxwars.challenges.ChallengeManager._instance)
            {
               tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
            }
            _loc2_ = tuxwars.challenges.ChallengeManager._instance.getPlayerChallenges(tuxGame.player.id);
            tuxGame.player.id = data.dcg_id;
            Config.setUserId(data.dcg_id);
            var _loc4_:ChallengeManager = ChallengeManager;
            if(!tuxwars.challenges.ChallengeManager._instance)
            {
               tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
            }
            tuxwars.challenges.ChallengeManager._instance.addPlayerChallenges(data.dcg_id,_loc2_.data,false);
            tuxGame.player.dummy = true;
         }
      }
   }
}
