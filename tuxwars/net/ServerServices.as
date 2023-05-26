package tuxwars.net
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.messages.ServerResponseReceivedMessage;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.net.ServerResponse;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.FpsCounter;
   import com.dchoc.utils.LogUtils;
   import flash.utils.getTimer;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.control.PurchaseMessage;
   import tuxwars.challenges.events.ChallengeItemBoughtMessage;
   import tuxwars.challenges.events.ChallengeItemCraftedMessage;
   import tuxwars.data.Tuner;
   import tuxwars.data.challenges.ChallengeData;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.home.ui.screen.crafting.Research;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.CouponData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.data.RecipeData;
   import tuxwars.net.messages.ShopItemCouponMessage;
   import tuxwars.net.messages.ShopItemLevelUpSalesMessage;
   import tuxwars.net.messages.ShopItemMessage;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.battlelock.BattleLockMessagePopUpSubState;
   import tuxwars.ui.popups.states.nomoney.NoMoneyPopUpSubState;
   import tuxwars.utils.SyncChecker;
   
   public class ServerServices
   {
      
      private static var passedLeaderboardFriends:Object;
      
      private static var currentGame:TuxWarsGame;
      
      private static var waitingForCallbackToEquipment:String;
       
      
      public function ServerServices()
      {
         super();
         throw new Error("ServerServices is a static class!");
      }
      
      public static function init(game:TuxWarsGame) : void
      {
         currentGame = game;
         MessageCenter.addListener("BuyItem",buyItem);
         MessageCenter.addListener("BuyItemLevelUpSales",buyItemLevelUpSales);
         MessageCenter.addListener("ClearLevelUpSale",closeLevelUpSales);
         MessageCenter.addListener("BuyItemCouponSales",buyItemCouponSales);
         MessageCenter.addListener("UnlockItem",unlockItem);
         MessageCenter.addListener("EquipItem",equipItem);
         MessageCenter.addListener("UnequipItem",unEquipItem);
         MessageCenter.addListener("FreeWeaponPackage",freeWeaponPackageRequest);
         MessageCenter.addListener("CraftItem",craftItem);
         MessageCenter.addListener("ResearchStart",startResearch);
         MessageCenter.addListener("ResearchComplete",completeResearch);
         MessageCenter.addListener("ResearchCompleteInstant",completeResearchInstant);
         MessageCenter.addListener("CollectResearchRewards",collectResearchRewards);
         MessageCenter.addListener("InboxUpdate",inboxUpdate);
         MessageCenter.addListener("CheckGiftStatus",checkGiftStatus);
         MessageCenter.addListener("CanSendGiftBackToSender",canSendGiftBack);
         MessageCenter.addListener("ChallengeCompleteUpdateNotInBattle",challengesUpdateNotInBattle);
         MessageCenter.addListener("SlotMachineServerPlay",slotMachinePlay);
         MessageCenter.addListener("SlotMachineServerResetSpins",slotMachineResetSpins);
         MessageCenter.addListener("MatchStarted",matchStarted);
         MessageCenter.addListener("SendFps",sendFps);
         MessageCenter.addListener("MaintenanceMode",isMaintenanceMode);
         MessageCenter.addListener("TournamentUpdate",tournamentUpdate);
         MessageCenter.addListener("CollectTournamentRewards",tournamentRewardClaim);
         MessageCenter.addListener("ResponseError",handleServerError);
         MessageCenter.addListener("ResponseReceived_",responseReceived);
      }
      
      public static function dispose() : void
      {
         MessageCenter.removeListener("BuyItem",buyItem);
         MessageCenter.removeListener("BuyItemLevelUpSales",buyItemLevelUpSales);
         MessageCenter.removeListener("ClearLevelUpSale",closeLevelUpSales);
         MessageCenter.removeListener("BuyItemCouponSales",buyItemCouponSales);
         MessageCenter.removeListener("UnlockItem",unlockItem);
         MessageCenter.removeListener("EquipItem",equipItem);
         MessageCenter.removeListener("UnequipItem",unEquipItem);
         MessageCenter.removeListener("CraftItem",craftItem);
         MessageCenter.removeListener("ResearchStart",startResearch);
         MessageCenter.removeListener("ResearchComplete",completeResearch);
         MessageCenter.removeListener("ResearchCompleteInstant",completeResearchInstant);
         MessageCenter.removeListener("InboxUpdate",inboxUpdate);
         MessageCenter.removeListener("CheckGiftStatus",checkGiftStatus);
         MessageCenter.removeListener("CanSendGiftBackToSender",canSendGiftBack);
         MessageCenter.removeListener("ChallengeCompleteUpdateNotInBattle",challengesUpdateNotInBattle);
         MessageCenter.removeListener("SlotMachineServerPlay",slotMachinePlay);
         MessageCenter.removeListener("SlotMachineServerResetSpins",slotMachineResetSpins);
         MessageCenter.removeListener("MatchStarted",matchStarted);
         MessageCenter.removeListener("SendFps",sendFps);
         MessageCenter.removeListener("MaintenanceMode",isMaintenanceMode);
         MessageCenter.removeListener("TournamentUpdate",tournamentUpdate);
         MessageCenter.removeListener("CollectTournamentRewards",tournamentRewardClaim);
         MessageCenter.removeListener("ResponseError",handleServerError);
         MessageCenter.removeListener("ResponseReceived_",responseReceived);
      }
      
      public static function getAndClearPassedFriendStats() : Object
      {
         var _loc1_:Object = passedLeaderboardFriends;
         passedLeaderboardFriends = null;
         return _loc1_;
      }
      
      private static function responseReceived(responseMessage:ServerResponseReceivedMessage) : void
      {
         if(responseMessage.response.data.syncMessage && responseMessage.response.serviceId != "GetAccountInformation" && responseMessage.response.serviceId != "ConfirmBattleEnded" && responseMessage.response.serviceId != "PlaySlotMachine" && (responseMessage.response.serviceId != "BuyItem" || !BattleManager.isBattleInProgress()) && responseMessage.response.serviceId != "ClientTracking")
         {
            SyncChecker.check(responseMessage.response.serviceId,responseMessage.response.data.syncMessage,currentGame);
         }
         if(responseMessage.response.serviceId == "ConfirmBattleEnded" && responseMessage.response.data.passFriendStats && responseMessage.response.data.passFriendStats.weekly)
         {
            passedLeaderboardFriends = responseMessage.response.data.passFriendStats.weekly;
         }
      }
      
      private static function handleServerError(msg:ServerResponseReceivedMessage) : void
      {
         var _loc2_:* = null;
         LogUtils.log("Server Error: " + msg.response.error,null,3,"Server");
         waitingForCallbackToEquipment = null;
         switch(msg.response.responseCode)
         {
            case 11:
               _loc2_ = msg.response.data.error_data;
               var _loc3_:PopUpManager = PopUpManager;
               if(!tuxwars.ui.popups.PopUpManager._instance)
               {
                  tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
               }
               tuxwars.ui.popups.PopUpManager._instance.addPopup(new NoMoneyPopUpSubState(currentGame,_loc2_.currency));
               break;
            case 1070:
               var _loc4_:PopUpManager = PopUpManager;
               if(!tuxwars.ui.popups.PopUpManager._instance)
               {
                  tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
               }
               tuxwars.ui.popups.PopUpManager._instance.addPopup(new BattleLockMessagePopUpSubState(currentGame));
               break;
            case 1017:
               LogUtils.log("Item already unlocked!","ServerServices",3,"Server");
               return;
            case 1071:
               return;
            case 2:
               MessageCenter.sendEvent(new ErrorMessage("Account not found",msg.response.serviceId,"The server cannot find account for the player id: " + currentGame.player.id));
               return;
            default:
               MessageCenter.sendEvent(new ErrorMessage("Error Unspecified",msg.response.serviceId,msg.response.error));
               return;
         }
         returnToHomeState();
      }
      
      private static function buyItem(msg:ShopItemMessage) : void
      {
         var _loc4_:ShopItem = msg.shopItem;
         var _loc3_:Object = {
            "item_id":_loc4_.id,
            "amount":1,
            "in_battle":BattleManager.isBattleInProgress() || tuxwars.battle.BattleManager._connectedToBattleManager
         };
         var _loc2_:ServerRequest = new ServerRequest("BuyItem",_loc3_,false,buyItemCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function buyItemCallback(response:ServerResponse) : void
      {
         var _loc2_:Object = response.data;
         if((BattleManager.isBattleInProgress() || tuxwars.battle.BattleManager._connectedToBattleManager) && !tuxwars.tutorial.Tutorial._tutorial)
         {
            MessageCenter.sendEvent(new PurchaseMessage());
         }
         MessageCenter.sendMessage("ItemBought",_loc2_);
         MessageCenter.sendEvent(new ChallengeItemBoughtMessage(_loc2_.item.item_id,currentGame.player.id));
      }
      
      private static function buyItemLevelUpSales(msg:ShopItemLevelUpSalesMessage) : void
      {
         var _loc4_:ShopItem = msg.shopItem;
         var _loc3_:Object = {
            "item_id":_loc4_.id,
            "amount":1,
            "in_battle":BattleManager.isBattleInProgress() || tuxwars.battle.BattleManager._connectedToBattleManager
         };
         var _loc2_:ServerRequest = new ServerRequest("BuyLevelUpSale",_loc3_,false,buyItemLevelUpSalesCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function buyItemLevelUpSalesCallback(response:ServerResponse) : void
      {
         var _loc2_:Object = response.data;
         MessageCenter.sendMessage("ItemBoughtLevelUpSales",_loc2_);
         MessageCenter.sendEvent(new ChallengeItemBoughtMessage(_loc2_.item.item_id,currentGame.player.id));
      }
      
      private static function buyItemCouponSales(msg:ShopItemCouponMessage) : void
      {
         var _loc4_:CouponData = msg.couponData;
         var _loc3_:Object = {
            "coupon_id":_loc4_.id,
            "in_battle":BattleManager.isBattleInProgress() || tuxwars.battle.BattleManager._connectedToBattleManager
         };
         var _loc2_:ServerRequest = new ServerRequest("AcceptCouponItem",_loc3_,false,buyItemCouponCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function buyItemCouponCallback(response:ServerResponse) : void
      {
         var _loc2_:Object = response.data;
         MessageCenter.sendMessage("ItemBoughtCouponSales",_loc2_);
         MessageCenter.sendEvent(new ChallengeItemBoughtMessage(_loc2_.item.item_id,currentGame.player.id));
      }
      
      private static function closeLevelUpSales(msg:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("ClearLevelUpSale");
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function sendFps(msg:Message) : void
      {
         if(BattleManager.isPracticeMode())
         {
            return;
         }
         var _loc3_:FpsCounter = msg.data;
         var _loc5_:BattleManager = BattleManager;
         var _loc6_:BattleManager = BattleManager;
         var _loc4_:Object = {
            "eventType":"fps",
            "browser":DCUtils.getBrowser(),
            "averageFps":_loc3_.frameRate,
            "averageLogic":_loc3_.logicUpdateRate,
            "averagePhysLogic":_loc3_.physicsUpdateRate,
            "lowestFps":_loc3_.lowestFps,
            "highestFps":_loc3_.highestFps,
            "levelName":_loc3_.levelName,
            "timeBetweenTurns":_loc3_.timeBetweenTurns,
            "playerTurnsTime":tuxwars.battle.BattleManager._playerTurnsTime,
            "playerTurnsTimeDiff":tuxwars.battle.BattleManager._playerTurnsTimeDiffRealActual
         };
         var _loc2_:ServerRequest = new ServerRequest("ClientTracking",_loc4_);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function matchStarted(msg:Message) : void
      {
         if(BattleManager.isPracticeMode())
         {
            return;
         }
         var levelName:String = "";
         try
         {
            levelName = currentGame.tuxWorld.physicsWorld.level.id;
         }
         catch(error:Error)
         {
         }
         var _loc3_:Object = {
            "eventType":"matchStarted",
            "levelName":levelName,
            "timeToStart":(getTimer() - msg.data) / 1000
         };
         var _loc2_:ServerRequest = new ServerRequest("ClientTracking",_loc3_);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function unlockItem(msg:Message) : void
      {
         var _loc4_:ShopItem = msg.data;
         var _loc3_:Object = {"item_id":_loc4_.id};
         var _loc2_:ServerRequest = new ServerRequest("UnlockItem",_loc3_,false,unlockItemCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function unlockItemCallback(response:ServerResponse) : void
      {
         if(BattleManager.isBattleInProgress() || tuxwars.battle.BattleManager._connectedToBattleManager)
         {
            MessageCenter.sendEvent(new PurchaseMessage());
         }
         MessageCenter.sendMessage("ItemUnlocked",response.data);
      }
      
      private static function equipItem(msg:Message) : void
      {
         var _loc4_:ShopItem = msg.data;
         var _loc3_:Object = {"item_id":_loc4_.id};
         var _loc2_:ServerRequest = new ServerRequest("WearItem",_loc3_,false,equipItemCallback);
         MessageCenter.sendEvent(_loc2_);
         waitingForCallbackToEquipment = _loc2_.callId;
      }
      
      private static function equipItemCallback(response:ServerResponse) : void
      {
         if(response.callId == waitingForCallbackToEquipment)
         {
            waitingForCallbackToEquipment = null;
         }
         var _loc2_:Object = response.data;
         MessageCenter.sendMessage("ItemEquipped",_loc2_);
      }
      
      public static function isEquipmentChangingBusy() : Boolean
      {
         return waitingForCallbackToEquipment != null;
      }
      
      private static function unEquipItem(msg:Message) : void
      {
         var _loc4_:ShopItem = msg.data;
         var _loc3_:Object = {"item_id":_loc4_.id};
         var _loc2_:ServerRequest = new ServerRequest("UnwearItem",_loc3_,false,unEquipItemCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function unEquipItemCallback(response:ServerResponse) : void
      {
         var _loc2_:Object = response.data;
         MessageCenter.sendMessage("ItemUnEquipped",_loc2_);
      }
      
      private static function craftItem(msg:Message) : void
      {
         var _loc4_:RecipeData = msg.data;
         var _loc3_:Object = {"recipe_id":_loc4_.id};
         var _loc2_:ServerRequest = new ServerRequest("CraftItem",_loc3_,false,craftItemCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function craftItemCallback(response:ServerResponse) : void
      {
         var _loc2_:Object = response.data;
         MessageCenter.sendMessage("ItemCrafted",_loc2_);
         MessageCenter.sendEvent(new ChallengeItemCraftedMessage(_loc2_.crafted_item.item_id,currentGame.player.id));
      }
      
      private static function startResearch(msg:Message) : void
      {
         var _loc2_:Vector.<ItemData> = msg.data;
         var ingredientsNames:String = "";
         for each(var item in _loc2_)
         {
            if(ingredientsNames.length > 0)
            {
               ingredientsNames += ",";
            }
            ingredientsNames += item.id;
         }
         var _loc6_:Object = {"ingredients":ingredientsNames};
         var _loc4_:ServerRequest = new ServerRequest("StartResearch",_loc6_,false,null);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function completeResearch(msg:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("CompleteResearch",null,false,completeResearchCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function completeResearchCallback(response:ServerResponse) : void
      {
         var _loc2_:Object = response.data;
         if(_loc2_ != null)
         {
            if(_loc2_.found_recipe_id != null)
            {
               MessageCenter.sendMessage("ResearchSuccess",_loc2_);
            }
            else
            {
               MessageCenter.sendMessage("ResearchNoResult",_loc2_);
            }
         }
      }
      
      private static function completeResearchInstant(msg:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("CompleteInstantResearch",null,false,completeResearchInstantCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function completeResearchInstantCallback(response:ServerResponse) : void
      {
         var _loc2_:Object = response.data;
         if(_loc2_ != null)
         {
            var _loc3_:Tuner = Tuner;
            currentGame.player.addPremiumMoney(-Number(tuxwars.data.Tuner.getField("ResearchInstantCompleteCost").value));
            var _loc4_:Research = Research;
            if(!tuxwars.home.ui.screen.crafting.Research._instance)
            {
               new tuxwars.home.ui.screen.crafting.Research();
            }
            tuxwars.home.ui.screen.crafting.Research._instance.instantComplete(_loc2_);
         }
      }
      
      private static function collectResearchRewards(msg:Message) : void
      {
         var _loc2_:Vector.<ItemData> = msg.data;
         var ingredientsNames:String = "";
         for each(var item in _loc2_)
         {
            if(ingredientsNames.length > 0)
            {
               ingredientsNames += ",";
            }
            ingredientsNames += item.id;
         }
         var _loc6_:Object = {"ingredients":ingredientsNames};
         var _loc4_:ServerRequest = new ServerRequest("CollectResearchRewards",_loc6_,false,collectResearchRewardsCallback);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function collectResearchRewardsCallback(response:ServerResponse) : void
      {
         var _loc2_:Object = response.data;
         if(_loc2_ != null)
         {
            MessageCenter.sendMessage("CollectResearchRewardsResponse",_loc2_);
         }
      }
      
      private static function tournamentUpdate(msg:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("GetTournamentInformation",msg.data,false,tournamentUpdateCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function tournamentUpdateCallback(response:ServerResponse) : void
      {
         LogUtils.log("tournamentUpdateCallback","ServerServices",0,"Tournament");
         var _loc2_:Object = response.data;
         if(_loc2_ != null)
         {
            MessageCenter.sendMessage("TournamentUpdated",_loc2_);
         }
      }
      
      private static function tournamentRewardClaim(msg:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("CollectTournamentRewards",msg.data,false,tournamentRewardClaimCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function tournamentRewardClaimCallback(response:ServerResponse) : void
      {
         LogUtils.log("tournamentRewardClaimCallback","ServerServices",0,"Tournament");
         var _loc2_:Object = response.data;
         if(_loc2_ != null)
         {
            MessageCenter.sendMessage("TournamentRewardClaimed",_loc2_);
         }
      }
      
      private static function inboxUpdate(msg:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("GetInboxStatus",null,false,inboxUpdateCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function inboxUpdateCallback(response:ServerResponse) : void
      {
         LogUtils.log("inboxUpdateCallback","ServerServices",0,"Inbox",false,false,true);
         var _loc2_:Object = response.data;
         if(_loc2_ != null)
         {
            MessageCenter.sendMessage("InboxUpdated",_loc2_);
         }
      }
      
      private static function checkGiftStatus(msg:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("CheckGiftStatus",msg.data,false,giftStatusCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function giftStatusCallback(response:ServerResponse) : void
      {
         LogUtils.log("giftStatusCallback","ServerServices",0,"Gift",false,false,true);
         var _loc2_:Object = response.data;
         if(_loc2_ != null)
         {
            MessageCenter.sendMessage("GiftStatusChecked",_loc2_);
         }
      }
      
      private static function canSendGiftBack(msg:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("CanSendGiftBackToSender",msg.data,false,canSendGiftBackCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function canSendGiftBackCallback(response:ServerResponse) : void
      {
         LogUtils.log("canSendGiftBackCallback","ServerServices",0,"Gift",false,false,true);
         var _loc2_:Object = response.data;
         if(_loc2_ != null)
         {
            MessageCenter.sendMessage("CanSendGiftBackToSenderChecked",_loc2_);
         }
      }
      
      private static function challengesUpdateNotInBattle(msg:Message) : void
      {
         var _loc2_:ChallengeData = msg.data;
         var _loc3_:Object = {"challenge_id":_loc2_.id};
         var _loc4_:ServerRequest = new ServerRequest("CompleteChallenge",_loc3_,false,challengesUpdateNotInBattleCallback);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function challengesUpdateNotInBattleCallback(response:ServerResponse) : void
      {
         if(response.data)
         {
            MessageCenter.sendMessage("ChallengesUpdateServerResponse",response.data);
         }
      }
      
      private static function isMaintenanceMode(msg:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("CheckServerStatus",null,false,isMaintenanceModeCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function isMaintenanceModeCallback(response:ServerResponse) : void
      {
         var _loc2_:Object = response.data;
         var maintanaceMode:Boolean = false;
         if(_loc2_)
         {
            if(_loc2_.hasOwnProperty("productionUpdate"))
            {
               maintanaceMode = Boolean(_loc2_.productionUpdate);
            }
         }
         MessageCenter.sendMessage("MaintenanceModeReply",maintanaceMode);
      }
      
      private static function slotMachinePlay(msg:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("PlaySlotMachine",null,false,slotMachinePlayCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function slotMachinePlayCallback(response:ServerResponse) : void
      {
         var _loc2_:Object = response.data;
         if(_loc2_ != null)
         {
            if(_loc2_.central_row_positions != null && _loc2_.number_of_neighbors != null)
            {
               MessageCenter.sendMessage("SlotMachineServerPlayResponse",_loc2_);
            }
            else
            {
               LogUtils.log("Data corrupt or not sufficient","ServerServices",3,"SlotMachine");
            }
         }
      }
      
      private static function slotMachineResetSpins(msg:Message) : void
      {
         var _loc3_:Object = {"reset_amount":msg.data};
         var _loc2_:ServerRequest = new ServerRequest("ResetSlotMachineSpins",_loc3_,false,slotMachineResetSpinsCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function slotMachineResetSpinsCallback(response:ServerResponse) : void
      {
         var _loc2_:Object = response.data;
         MessageCenter.sendMessage("SlotMachineServerResetSpinsResponse");
      }
      
      private static function returnToHomeState() : void
      {
         if(currentGame.homeState)
         {
            currentGame.homeState.exitCurrentState(true);
         }
         else
         {
            currentGame.changeState(new HomeState(currentGame,false),true);
         }
         var _loc1_:PopUpManager = PopUpManager;
         if(!tuxwars.ui.popups.PopUpManager._instance)
         {
            tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
         }
         tuxwars.ui.popups.PopUpManager._instance.showPopUps(currentGame.homeState);
      }
      
      private static function freeWeaponPackageRequest(msg:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("FreeWeaponPackagePopUp",null,false,freeWeaponPackageRequestCallBack);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function freeWeaponPackageRequestCallBack(response:ServerResponse) : void
      {
         var _loc2_:Object = response.data;
         MessageCenter.sendMessage("FreeWeaponPackageResponse",_loc2_);
      }
   }
}
