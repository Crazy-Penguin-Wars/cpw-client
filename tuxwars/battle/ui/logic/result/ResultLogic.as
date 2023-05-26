package tuxwars.battle.ui.logic.result
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.messages.ServerResponseReceivedMessage;
   import com.dchoc.net.Server;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.net.ServerResponse;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import tuxwars.GameSettings;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.BattleResults;
   import tuxwars.battle.PlayerResult;
   import tuxwars.battle.net.BattleResponse;
   import tuxwars.battle.net.BattleServerDisconnectMessage;
   import tuxwars.battle.rewards.LootItem;
   import tuxwars.battle.ui.logic.afterresultsales.AfterResultSalesLogic;
   import tuxwars.battle.ui.screen.result.ResultScreen;
   import tuxwars.battle.ui.states.afterresultsales.AfterResultSalesState;
   import tuxwars.battle.ui.states.couponfound.CouponFoundState;
   import tuxwars.data.IngameBetData;
   import tuxwars.data.LeaderboardPopUpPriorities;
   import tuxwars.data.RematchData;
   import tuxwars.data.VIPData;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.home.states.matchloading.MultiplayerMatchLoadingSubState;
   import tuxwars.home.states.matchloading.PracticeMatchLoadingSubState;
   import tuxwars.home.states.matchloading.TournamentMatchLoadingSubState;
   import tuxwars.home.states.shop.ShopState;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.items.data.CouponData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.net.CRMService;
   import tuxwars.net.FeedService;
   import tuxwars.net.ServerServices;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.logic.passedstat.PassedStatData;
   import tuxwars.ui.popups.states.loot.LootPopupSubState;
   import tuxwars.ui.popups.states.passedstat.PassedStatPopUpSubState;
   
   public class ResultLogic extends TuxUILogic
   {
       
      
      private var battleEndResponse:ServerResponse;
      
      private var battleResults:BattleResults;
      
      private var readyClients:Array;
      
      private var _canStartRematch:Boolean;
      
      private var _rematchIdentifier:String;
      
      private var _rematchPlayerCount:int;
      
      public function ResultLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      override public function preInit(params:*) : void
      {
         var _loc2_:* = null;
         super.preInit(params);
         _canStartRematch = false;
         _rematchIdentifier = "";
         _rematchPlayerCount = 0;
         CRMService.sendEvent("Game","Battle_Ended","On_Client");
         battleResults = params;
         if(battleResults)
         {
            for each(var lootItem in battleResults.itemsLooted)
            {
               _loc2_ = ItemManager.getItemData(lootItem.id);
               if(showItemPopup(_loc2_))
               {
                  var _loc4_:PopUpManager = PopUpManager;
                  if(!tuxwars.ui.popups.PopUpManager._instance)
                  {
                     tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
                  }
                  tuxwars.ui.popups.PopUpManager._instance.addPopup(new LootPopupSubState(game,_loc2_));
               }
            }
            var _loc7_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.showPopUps(state);
         }
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         MessageCenter.addListener("BattleResponse",responseCallback);
         if(!game.player.dummy && !battleResults.isPracticeMode)
         {
            battleEndResponse = Server.findNextResponse("ConfirmBattleEnded");
            if(battleEndResponse)
            {
               Server.removeResponse(battleEndResponse);
               if(battleEndResponse.data.internal_code != 1070)
               {
                  resultScreen.battleCompletedResponseGot(battleEndResponse);
                  processRewards();
               }
               else
               {
                  MessageCenter.addListener("ResponseReceived_" + "ConfirmBattleEnded",storeServerResponse);
                  MessageCenter.sendEvent(new ServerRequest("ConfirmBattleEnded"));
                  addLoadingIndicator();
               }
            }
            else
            {
               MessageCenter.addListener("ResponseReceived_" + "ConfirmBattleEnded",storeServerResponse);
               addLoadingIndicator();
               LogUtils.log("Did not have a response for service: ConfirmBattleEnded waiting ... (no resend, recheck value: " + Server.findNextResponse("ConfirmBattleEnded") + ")",this,0,"ServerResponse",false,false,false);
            }
         }
      }
      
      override public function dispose() : void
      {
         removeLoadingIndicator();
         MessageCenter.removeListener("facebookFeedPostedCallback",feedPosted);
         MessageCenter.removeListener("BattleResponse",responseCallback);
         MessageCenter.sendEvent(new BattleServerDisconnectMessage());
         super.dispose();
      }
      
      public function showCouponScreen() : Boolean
      {
         var _loc1_:CouponData = battleResults.getCouponLoot(0);
         if(_loc1_)
         {
            game.currentState.changeState(new CouponFoundState(game,[battleResults,_loc1_]));
            return true;
         }
         return false;
      }
      
      public function showAfterResultSalesScreen(nextState:int) : void
      {
         var _loc2_:BattleManager = BattleManager;
         game.battleState.changeState(new AfterResultSalesState(game,[nextState,battleResults,_rematchIdentifier,_rematchPlayerCount,tuxwars.battle.BattleManager._customGameName]));
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
            goHomeWithoutAnnoyingPopup();
         }
         else
         {
            showAfterResultSalesScreen(AfterResultSalesLogic.GO_HOME);
         }
      }
      
      public function playAgain() : void
      {
         for each(var c in readyClients)
         {
            RematchData.setRematchPlayer(BattleManager.findPlayerGameObject(c));
         }
         if(BattleManager.isPracticeMode())
         {
            playAgainWithoutAnnoyingPopup();
         }
         else if(BattleManager.isTournamentMode())
         {
            showAfterResultSalesScreen(AfterResultSalesLogic.PLAY_AGAIN_TOURNAMENT);
         }
         else
         {
            var _loc4_:BattleManager = BattleManager;
            if(tuxwars.battle.BattleManager._customGameName != null)
            {
               var _loc5_:BattleManager = BattleManager;
               RematchData.setCustomGameName(tuxwars.battle.BattleManager._customGameName);
               showAfterResultSalesScreen(AfterResultSalesLogic.PLAY_AGAIN_CUSTOM);
            }
            else
            {
               showAfterResultSalesScreen(AfterResultSalesLogic.PLAY_AGAIN);
            }
         }
      }
      
      public function getReadyClients() : Array
      {
         return readyClients;
      }
      
      public function postBragFeed() : void
      {
         var _loc1_:String = BragFeeds.getBragFeedId(battleResults.playerResults);
         if(_loc1_ != null)
         {
            FeedService.publishMessage(_loc1_);
            MessageCenter.addListener("facebookFeedPostedCallback",feedPosted);
         }
      }
      
      public function feedPosted(msg:Message) : void
      {
         MessageCenter.removeListener("facebookFeedPostedCallback",feedPosted);
         resultScreen.shareButton.setEnabled(false);
      }
      
      public function goHomeWithoutAnnoyingPopup() : void
      {
         game.changeState(new HomeState(game));
      }
      
      private function playAgainWithoutAnnoyingPopup() : void
      {
         var _loc2_:* = null;
         var _loc1_:TuxWarsGame = game;
         if(!game.homeState)
         {
            _loc1_.changeState(new HomeState(_loc1_),true);
         }
         if(battleResults && battleResults.isPracticeMode)
         {
            GameSettings.setShowAllWeaponsInPractice(false);
            _loc1_.homeState.changeState(new PracticeMatchLoadingSubState(_loc1_));
         }
         else
         {
            _loc2_ = {};
            _loc2_["game_identifier"] = _rematchIdentifier;
            _loc2_["player_count"] = _rematchPlayerCount;
            if(battleResults && battleResults.isTournamentMode)
            {
               _loc2_["tournament"] = true;
               _loc1_.homeState.changeState(new TournamentMatchLoadingSubState(_loc1_,new ServerRequest("PlayNow",_loc2_)));
            }
            else
            {
               _loc1_.homeState.changeState(new MultiplayerMatchLoadingSubState(_loc1_,new ServerRequest("PlayNow",_loc2_)));
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
         _loc1_.homeState.changeState(new ShopState(_loc1_,battleResults));
      }
      
      public function recievedServerResponse() : Boolean
      {
         return battleEndResponse != null && battleEndResponse.data.internal_code != 1070;
      }
      
      private function processRewards() : void
      {
         if(recievedServerResponse())
         {
            MessageCenter.sendMessage("ChallengesUpdateServerResponse",battleEndResponse.data);
            giveBattleRewards();
         }
         showCouponScreen();
         var _loc1_:Object = ServerServices.getAndClearPassedFriendStats();
         var _loc2_:String = getStatDataWithHighestPriority(_loc1_);
         if(_loc2_ != null)
         {
            var _loc3_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.triggerPopup(new PassedStatPopUpSubState(game,new PassedStatData(_loc1_[_loc2_],_loc2_)),game.currentState);
         }
      }
      
      private function showItemPopup(item:ItemData) : Boolean
      {
         if(item)
         {
            switch(item.type)
            {
               case "Booster":
               case "Clothing":
               case "Recipe":
               case "Trophy":
                  break;
               case "Weapon":
                  break;
               case "Crafting":
               case "Customization":
               case "Emoticon":
               case "Status":
                  return false;
               default:
                  LogUtils.log("Type: " + item.type + " not specified if popup is supposed to show or not!",this,2,"PopUpManager",false,true,true);
                  return false;
            }
            return true;
         }
         LogUtils.log("Item is null",this,2,"PopUpManager",false,true,true);
         return false;
      }
      
      private function giveBattleRewards() : void
      {
         var betPayout:int = 0;
         var _loc1_:int = battleResults.coinsGained;
         var _loc2_:int = battleResults.expGained;
         var _loc11_:int = BattleManager.isPracticeMode() ? 0 : battleResults.getCoinsPositionBonus(game.player.id);
         var _loc5_:int = BattleManager.isPracticeMode() ? 0 : battleResults.getExpPositionBonus(game.player.id);
         var _loc9_:int = BattleManager.isVIP() ? (_loc1_ + _loc11_) * VIPData.getIngameMoneyMultiplier() - _loc1_ - _loc11_ : 0;
         var _loc4_:int = BattleManager.isVIP() ? (_loc2_ + _loc5_) * VIPData.getExpMultiplier() - _loc2_ - _loc5_ : 0;
         var _loc7_:int = _loc1_ + _loc11_ + _loc9_;
         var _loc3_:int = _loc2_ + _loc5_ + _loc4_;
         game.player.addExp(_loc3_);
         game.player.addIngameMoney(_loc7_,false);
         game.player.addPremiumMoney(battleResults.cashGained);
         var _loc12_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            CRMService.sendEvent("Tutorial","Earn XP","Confirmed","Earn XP",null,_loc3_);
            CRMService.sendEvent("Tutorial","Earn GC","Confirmed","Earn GC",null,_loc7_);
         }
         CRMService.sendEvent("Economy","Earn XP","Started",null,null,_loc3_);
         CRMService.sendEvent("Economy","Earn GC","Started",null,null,_loc7_);
         CRMService.sendEvent("Economy","Earn PC","Started",null,null,battleResults.cashGained);
         if(battleResults.itemsLooted)
         {
            for each(var item in battleResults.itemsLooted)
            {
               if(item.id != null && item.id.length > 0)
               {
                  game.player.inventory.addItem(item.id,item.amount,true,false);
                  CRMService.sendEvent("Economy","Earn_Item","Started",item.id);
               }
            }
         }
         if(!BattleManager.isPracticeMode() && tuxwars.battle.BattleManager._customGameName == null && !BattleManager.isZeroPointGame() && battleResults.getPosition(game.player.id) == 1)
         {
            for each(var playerResult in battleResults.playerResults)
            {
               if(playerResult.player.isMe() && playerResult.player.betData)
               {
                  if(playerResult.player.betData.valuePremium > 0)
                  {
                     betPayout = IngameBetData.getPayout();
                     game.player.addPremiumMoney(betPayout);
                     CRMService.sendEvent("Economy","Earn PC","Confirmed","Betting",null,betPayout);
                     break;
                  }
                  if(playerResult.player.betData.valueIngame > 0)
                  {
                     betPayout = IngameBetData.getPayout();
                     game.player.addIngameMoney(betPayout,false);
                     CRMService.sendEvent("Economy","Earn GC","Confirmed","Betting",null,betPayout);
                     break;
                  }
                  break;
               }
            }
         }
         if(BattleManager.isZeroPointGame())
         {
            for each(playerResult in battleResults.playerResults)
            {
               if(playerResult.player.isMe() && playerResult.player.betData)
               {
                  if(playerResult.player.betData.valuePremium > 0)
                  {
                     game.player.addPremiumMoney(IngameBetData.getBetAmount());
                     CRMService.sendEvent("Economy","Earn PC","Confirmed","Betting",null,IngameBetData.getBetAmount());
                     break;
                  }
                  if(playerResult.player.betData.valueIngame > 0)
                  {
                     game.player.addIngameMoney(IngameBetData.getBetAmount(),false);
                     CRMService.sendEvent("Economy","Earn GC","Confirmed","Betting",null,IngameBetData.getBetAmount());
                     break;
                  }
                  break;
               }
            }
         }
      }
      
      private function storeServerResponse(response:ServerResponseReceivedMessage) : void
      {
         MessageCenter.removeListener("ResponseReceived_" + "ConfirmBattleEnded",storeServerResponse);
         battleEndResponse = response.response;
         Server.removeResponse(battleEndResponse);
         if(battleEndResponse.data.internal_code != 1070)
         {
            resultScreen.battleCompletedResponseGot(battleEndResponse);
            processRewards();
         }
         else
         {
            MessageCenter.addListener("ResponseReceived_" + "ConfirmBattleEnded",storeServerResponse);
            MessageCenter.sendEvent(new ServerRequest("ConfirmBattleEnded"));
         }
      }
      
      private function addLoadingIndicator() : void
      {
         resultScreen.addLoadingIndicator();
      }
      
      private function removeLoadingIndicator() : void
      {
         resultScreen.removeLoadingIndicator();
      }
      
      private function get resultScreen() : ResultScreen
      {
         return screen;
      }
      
      private function getStatDataWithHighestPriority(passedStatData:Object) : String
      {
         var names:Vector.<String> = DCUtils.propertyNames(passedStatData);
         names.sort(function(stat1:String, stat2:String):int
         {
            return LeaderboardPopUpPriorities.compare(stat1,stat2);
         });
         return names.length > 0 ? names[0] : null;
      }
      
      public function canStartRematch() : Boolean
      {
         return _canStartRematch;
      }
      
      private function responseCallback(response:BattleResponse) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         switch(response.responseType - 41)
         {
            case 0:
               LogUtils.log("Rematch response msg: " + response.responseText,this,1,"ReceivedMessage");
               _rematchPlayerCount = 0;
               readyClients = response.data.ready_clients;
               for each(var c in readyClients)
               {
                  resultScreen.updateRematchStamp(c,1);
                  _rematchPlayerCount++;
               }
               _loc2_ = response.data.pending_clients;
               for each(c in _loc2_)
               {
                  resultScreen.updateRematchStamp(c,0);
               }
               _loc3_ = response.data.left_clients;
               for each(c in _loc3_)
               {
                  resultScreen.updateRematchStamp(c,2);
               }
               _canStartRematch = response.data.start;
               _rematchIdentifier = response.data.game_identifier;
               break;
            default:
               LogUtils.log("Unknown message: " + response.responseText,this,2,"ReceivedMessage");
         }
      }
   }
}
