package tuxwars.battle.ui.logic.result
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.utils.*;
   import tuxwars.*;
   import tuxwars.battle.*;
   import tuxwars.battle.net.*;
   import tuxwars.battle.ui.logic.afterresultsales.*;
   import tuxwars.battle.ui.screen.result.ResultScreen;
   import tuxwars.battle.ui.states.afterresultsales.*;
   import tuxwars.battle.ui.states.couponfound.*;
   import tuxwars.data.*;
   import tuxwars.home.states.homestate.*;
   import tuxwars.home.states.matchloading.*;
   import tuxwars.home.states.shop.*;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.items.data.CouponData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   import tuxwars.net.*;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.logic.passedstat.*;
   import tuxwars.ui.popups.states.loot.*;
   import tuxwars.ui.popups.states.passedstat.*;
   
   public class ResultLogic extends TuxUILogic
   {
      private var battleEndResponse:ServerResponse;
      
      private var battleResults:BattleResults;
      
      private var readyClients:Array;
      
      private var _canStartRematch:Boolean;
      
      private var _rematchIdentifier:String;
      
      private var _rematchPlayerCount:int;
      
      public function ResultLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function preInit(param1:*) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:ItemData = null;
         super.preInit(param1);
         this._canStartRematch = false;
         this._rematchIdentifier = "";
         this._rematchPlayerCount = 0;
         CRMService.sendEvent("Game","Battle_Ended","On_Client");
         this.battleResults = param1;
         if(this.battleResults)
         {
            for each(_loc3_ in this.battleResults.itemsLooted)
            {
               _loc2_ = ItemManager.getItemData(_loc3_.id);
               if(this.showItemPopup(_loc2_))
               {
                  if(!PopUpManager.instance)
                  {
                     PopUpManager.instance = new PopUpManager();
                  }
                  PopUpManager.instance.addPopup(new LootPopupSubState(game,_loc2_));
               }
            }
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.showPopUps(state);
         }
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         MessageCenter.addListener("BattleResponse",this.responseCallback);
         if(!game.player.dummy && !this.battleResults.isPracticeMode)
         {
            this.battleEndResponse = Server.findNextResponse("ConfirmBattleEnded");
            if(this.battleEndResponse)
            {
               Server.removeResponse(this.battleEndResponse);
               if(this.battleEndResponse.data.internal_code != 1070)
               {
                  this.resultScreen.battleCompletedResponseGot(this.battleEndResponse);
                  this.processRewards();
               }
               else
               {
                  MessageCenter.addListener("ResponseReceived_" + "ConfirmBattleEnded",this.storeServerResponse);
                  MessageCenter.sendEvent(new ServerRequest("ConfirmBattleEnded"));
                  this.addLoadingIndicator();
               }
            }
            else
            {
               MessageCenter.addListener("ResponseReceived_" + "ConfirmBattleEnded",this.storeServerResponse);
               this.addLoadingIndicator();
               LogUtils.log("Did not have a response for service: ConfirmBattleEnded waiting ... (no resend, recheck value: " + Server.findNextResponse("ConfirmBattleEnded") + ")",this,0,"ServerResponse",false,false,false);
            }
         }
      }
      
      override public function dispose() : void
      {
         this.removeLoadingIndicator();
         MessageCenter.removeListener("facebookFeedPostedCallback",this.feedPosted);
         MessageCenter.removeListener("BattleResponse",this.responseCallback);
         MessageCenter.sendEvent(new BattleServerDisconnectMessage());
         super.dispose();
      }
      
      public function showCouponScreen() : Boolean
      {
         var _loc1_:CouponData = this.battleResults.getCouponLoot(0);
         if(_loc1_)
         {
            game.currentState.changeState(new CouponFoundState(game,[this.battleResults,_loc1_]));
            return true;
         }
         return false;
      }
      
      public function showAfterResultSalesScreen(param1:int) : void
      {
         game.battleState.changeState(new AfterResultSalesState(game,[param1,this.battleResults,this._rematchIdentifier,this._rematchPlayerCount,BattleManager.customGameName]));
      }
      
      public function showShopAfterResultScreen() : void
      {
         CRMService.sendEvent("Game","Menu","Clicked","Supplies");
         game.homeState.changeState(new ShopState(game));
      }
      
      public function goHome() : void
      {
         if(BattleManager.isPracticeMode())
         {
            this.goHomeWithoutAnnoyingPopup();
         }
         else
         {
            this.showAfterResultSalesScreen(AfterResultSalesLogic.GO_HOME);
         }
      }
      
      public function playAgain() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.readyClients)
         {
            RematchData.setRematchPlayer(BattleManager.findPlayerGameObject(_loc1_));
         }
         if(BattleManager.isPracticeMode())
         {
            this.playAgainWithoutAnnoyingPopup();
         }
         else if(BattleManager.isTournamentMode())
         {
            this.showAfterResultSalesScreen(AfterResultSalesLogic.PLAY_AGAIN_TOURNAMENT);
         }
         else if(BattleManager.customGameName != null)
         {
            RematchData.setCustomGameName(BattleManager._custcustomGameNameomGameName);
            this.showAfterResultSalesScreen(AfterResultSalesLogic.PLAY_AGAIN_CUSTOM);
         }
         else
         {
            this.showAfterResultSalesScreen(AfterResultSalesLogic.PLAY_AGAIN);
         }
      }
      
      public function getReadyClients() : Array
      {
         return this.readyClients;
      }
      
      public function postBragFeed() : void
      {
         var _loc1_:String = BragFeeds.getBragFeedId(this.battleResults.playerResults);
         if(_loc1_ != null)
         {
            FeedService.publishMessage(_loc1_);
            MessageCenter.addListener("facebookFeedPostedCallback",this.feedPosted);
         }
      }
      
      public function feedPosted(param1:Message) : void
      {
         MessageCenter.removeListener("facebookFeedPostedCallback",this.feedPosted);
         this.resultScreen.shareButton.setEnabled(false);
      }
      
      public function goHomeWithoutAnnoyingPopup() : void
      {
         game.changeState(new HomeState(game));
      }
      
      private function playAgainWithoutAnnoyingPopup() : void
      {
         var _loc1_:Object = null;
         var _loc2_:TuxWarsGame = game;
         if(!game.homeState)
         {
            _loc2_.changeState(new HomeState(_loc2_),true);
         }
         if(Boolean(this.battleResults) && Boolean(this.battleResults.isPracticeMode))
         {
            GameSettings.setShowAllWeaponsInPractice(false);
            _loc2_.homeState.changeState(new PracticeMatchLoadingSubState(_loc2_));
         }
         else
         {
            _loc1_ = {};
            _loc1_["game_identifier"] = this._rematchIdentifier;
            _loc1_["player_count"] = this._rematchPlayerCount;
            if(Boolean(this.battleResults) && Boolean(this.battleResults.isTournamentMode))
            {
               _loc1_["tournament"] = true;
               _loc2_.homeState.changeState(new TournamentMatchLoadingSubState(_loc2_,new ServerRequest("PlayNow",_loc1_)));
            }
            else
            {
               _loc2_.homeState.changeState(new MultiplayerMatchLoadingSubState(_loc2_,new ServerRequest("PlayNow",_loc1_)));
            }
         }
      }
      
      public function openShop() : void
      {
         var _loc1_:TuxWarsGame = game;
         if(!_loc1_.homeState)
         {
            _loc1_.changeState(new HomeState(_loc1_),true);
         }
         _loc1_.homeState.changeState(new ShopState(_loc1_,this.battleResults));
      }
      
      public function recievedServerResponse() : Boolean
      {
         return this.battleEndResponse != null && this.battleEndResponse.data.internal_code != 1070;
      }
      
      private function processRewards() : void
      {
         if(this.recievedServerResponse())
         {
            MessageCenter.sendMessage("ChallengesUpdateServerResponse",this.battleEndResponse.data);
            this.giveBattleRewards();
         }
         this.showCouponScreen();
         var _loc1_:Object = ServerServices.getAndClearPassedFriendStats();
         var _loc2_:String = this.getStatDataWithHighestPriority(_loc1_);
         if(_loc2_ != null)
         {
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.triggerPopup(new PassedStatPopUpSubState(game,new PassedStatData(_loc1_[_loc2_],_loc2_)),game.currentState);
         }
      }
      
      private function showItemPopup(param1:ItemData) : Boolean
      {
         if(param1)
         {
            switch(param1.type)
            {
               case "Booster":
               case "Clothing":
               case "Recipe":
               case "Trophy":
               case "Weapon":
                  return true;
               case "Crafting":
               case "Customization":
               case "Emoticon":
               case "Status":
                  return false;
               default:
                  LogUtils.log("Type: " + param1.type + " not specified if popup is supposed to show or not!",this,2,"PopUpManager",false,true,true);
                  return false;
            }
         }
         else
         {
            LogUtils.log("Item is null",this,2,"PopUpManager",false,true,true);
            return false;
         }
      }
      
      private function giveBattleRewards() : void
      {
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc1_:int = 0;
         var _loc2_:int = int(this.battleResults.coinsGained);
         var _loc3_:int = int(this.battleResults.expGained);
         var _loc4_:int = !!BattleManager.isPracticeMode() ? 0 : int(this.battleResults.getCoinsPositionBonus(game.player.id));
         var _loc5_:int = !!BattleManager.isPracticeMode() ? 0 : int(this.battleResults.getExpPositionBonus(game.player.id));
         var _loc6_:int = !!BattleManager.isVIP() ? int((_loc2_ + _loc4_) * VIPData.getIngameMoneyMultiplier() - _loc2_ - _loc4_) : 0;
         var _loc7_:int = !!BattleManager.isVIP() ? int((_loc3_ + _loc5_) * VIPData.getExpMultiplier() - _loc3_ - _loc5_) : 0;
         var _loc8_:int = _loc2_ + _loc4_ + _loc6_;
         var _loc9_:int = _loc3_ + _loc5_ + _loc7_;
         game.player.addExp(_loc9_);
         game.player.addIngameMoney(_loc8_,false);
         game.player.addPremiumMoney(this.battleResults.cashGained);
         if(Tutorial._tutorial)
         {
            CRMService.sendEvent("Tutorial","Earn XP","Confirmed","Earn XP",null,_loc9_);
            CRMService.sendEvent("Tutorial","Earn GC","Confirmed","Earn GC",null,_loc8_);
         }
         CRMService.sendEvent("Economy","Earn XP","Started",null,null,_loc9_);
         CRMService.sendEvent("Economy","Earn GC","Started",null,null,_loc8_);
         CRMService.sendEvent("Economy","Earn PC","Started",null,null,this.battleResults.cashGained);
         if(this.battleResults.itemsLooted)
         {
            for each(_loc10_ in this.battleResults.itemsLooted)
            {
               if(_loc10_.id != null && _loc10_.id.length > 0)
               {
                  game.player.inventory.addItem(_loc10_.id,_loc10_.amount,true,false);
                  CRMService.sendEvent("Economy","Earn_Item","Started",_loc10_.id);
               }
            }
         }
         if(!BattleManager.isPracticeMode() && BattleManager.customGameName == null && !BattleManager.isZeroPointGame() && this.battleResults.getPosition(game.player.id) == 1)
         {
            for each(_loc11_ in this.battleResults.playerResults)
            {
               if(Boolean(_loc11_.player.isMe()) && Boolean(_loc11_.player.betData))
               {
                  if(_loc11_.player.betData.valuePremium > 0)
                  {
                     _loc1_ = int(IngameBetData.getPayout());
                     game.player.addPremiumMoney(_loc1_);
                     CRMService.sendEvent("Economy","Earn PC","Confirmed","Betting",null,_loc1_);
                  }
                  else if(_loc11_.player.betData.valueIngame > 0)
                  {
                     _loc1_ = int(IngameBetData.getPayout());
                     game.player.addIngameMoney(_loc1_,false);
                     CRMService.sendEvent("Economy","Earn GC","Confirmed","Betting",null,_loc1_);
                  }
                  break;
               }
            }
         }
         if(BattleManager.isZeroPointGame())
         {
            for each(_loc11_ in this.battleResults.playerResults)
            {
               if(Boolean(_loc11_.player.isMe()) && Boolean(_loc11_.player.betData))
               {
                  if(_loc11_.player.betData.valuePremium > 0)
                  {
                     game.player.addPremiumMoney(IngameBetData.getBetAmount());
                     CRMService.sendEvent("Economy","Earn PC","Confirmed","Betting",null,IngameBetData.getBetAmount());
                  }
                  else if(_loc11_.player.betData.valueIngame > 0)
                  {
                     game.player.addIngameMoney(IngameBetData.getBetAmount(),false);
                     CRMService.sendEvent("Economy","Earn GC","Confirmed","Betting",null,IngameBetData.getBetAmount());
                  }
                  break;
               }
            }
         }
      }
      
      private function storeServerResponse(param1:ServerResponseReceivedMessage) : void
      {
         MessageCenter.removeListener("ResponseReceived_" + "ConfirmBattleEnded",this.storeServerResponse);
         this.battleEndResponse = param1.response;
         Server.removeResponse(this.battleEndResponse);
         if(this.battleEndResponse.data.internal_code != 1070)
         {
            this.resultScreen.battleCompletedResponseGot(this.battleEndResponse);
            this.processRewards();
         }
         else
         {
            MessageCenter.addListener("ResponseReceived_" + "ConfirmBattleEnded",this.storeServerResponse);
            MessageCenter.sendEvent(new ServerRequest("ConfirmBattleEnded"));
         }
      }
      
      private function addLoadingIndicator() : void
      {
         this.resultScreen.addLoadingIndicator();
      }
      
      private function removeLoadingIndicator() : void
      {
         this.resultScreen.removeLoadingIndicator();
      }
      
      private function get resultScreen() : ResultScreen
      {
         return screen;
      }
      
      private function getStatDataWithHighestPriority(param1:Object) : String
      {
         var passedStatData:Object = param1;
         var names:Vector.<String> = DCUtils.propertyNames(passedStatData);
         names.sort(function(param1:String, param2:String):int
         {
            return LeaderboardPopUpPriorities.compare(param1,param2);
         });
         return names.length > 0 ? names[0] : null;
      }
      
      public function canStartRematch() : Boolean
      {
         return this._canStartRematch;
      }
      
      private function responseCallback(param1:BattleResponse) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         switch(param1.responseType - 41)
         {
            case 0:
               LogUtils.log("Rematch response msg: " + param1.responseText,this,1,"ReceivedMessage");
               this._rematchPlayerCount = 0;
               this.readyClients = param1.data.ready_clients;
               for each(_loc4_ in this.readyClients)
               {
                  this.resultScreen.updateRematchStamp(_loc4_,1);
                  ++this._rematchPlayerCount;
               }
               _loc2_ = param1.data.pending_clients;
               for each(_loc4_ in _loc2_)
               {
                  this.resultScreen.updateRematchStamp(_loc4_,0);
               }
               _loc3_ = param1.data.left_clients;
               for each(_loc4_ in _loc3_)
               {
                  this.resultScreen.updateRematchStamp(_loc4_,2);
               }
               this._canStartRematch = param1.data.start;
               this._rematchIdentifier = param1.data.game_identifier;
               break;
            default:
               LogUtils.log("Unknown message: " + param1.responseText,this,2,"ReceivedMessage");
         }
      }
   }
}

