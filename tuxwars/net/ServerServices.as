package tuxwars.net
{
   import com.dchoc.events.*;
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.utils.*;
   import flash.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.challenges.events.*;
   import tuxwars.data.*;
   import tuxwars.data.challenges.ChallengeData;
   import tuxwars.home.states.homestate.*;
   import tuxwars.home.ui.screen.crafting.*;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.CouponData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.data.RecipeData;
   import tuxwars.net.messages.ShopItemCouponMessage;
   import tuxwars.net.messages.ShopItemLevelUpSalesMessage;
   import tuxwars.net.messages.ShopItemMessage;
   import tuxwars.tutorial.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.battlelock.*;
   import tuxwars.ui.popups.states.nomoney.*;
   import tuxwars.utils.*;
   
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
      
      public static function init(param1:TuxWarsGame) : void
      {
         currentGame = param1;
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
      
      private static function responseReceived(param1:ServerResponseReceivedMessage) : void
      {
         if(param1.response.data.syncMessage && param1.response.serviceId != "GetAccountInformation" && param1.response.serviceId != "ConfirmBattleEnded" && param1.response.serviceId != "PlaySlotMachine" && (param1.response.serviceId != "BuyItem" || !BattleManager.isBattleInProgress()) && param1.response.serviceId != "ClientTracking")
         {
            SyncChecker.check(param1.response.serviceId,param1.response.data.syncMessage,currentGame);
         }
         if(param1.response.serviceId == "ConfirmBattleEnded" && param1.response.data.passFriendStats && Boolean(param1.response.data.passFriendStats.weekly))
         {
            passedLeaderboardFriends = param1.response.data.passFriendStats.weekly;
         }
      }
      
      private static function handleServerError(param1:ServerResponseReceivedMessage) : void
      {
         var _loc2_:Object = null;
         LogUtils.log("Server Error: " + param1.response.error,null,3,"Server");
         waitingForCallbackToEquipment = null;
         switch(param1.response.responseCode)
         {
            case 11:
               _loc2_ = param1.response.data.error_data;
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.addPopup(new NoMoneyPopUpSubState(currentGame,_loc2_.currency));
               break;
            case 1070:
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.addPopup(new BattleLockMessagePopUpSubState(currentGame));
               break;
            case 1017:
               LogUtils.log("Item already unlocked!","ServerServices",3,"Server");
               return;
            case 1071:
               return;
            case 2:
               MessageCenter.sendEvent(new ErrorMessage("Account not found",param1.response.serviceId,"The server cannot find account for the player id: " + currentGame.player.id));
               return;
            default:
               MessageCenter.sendEvent(new ErrorMessage("Error Unspecified",param1.response.serviceId,param1.response.error));
               return;
         }
         returnToHomeState();
      }
      
      private static function buyItem(param1:ShopItemMessage) : void
      {
         var _loc2_:ShopItem = param1.shopItem;
         var _loc3_:Object = {
            "item_id":_loc2_.id,
            "amount":1,
            "in_battle":BattleManager.isBattleInProgress() || BattleManager._connectedToBattleManager
         };
         var _loc4_:ServerRequest = new ServerRequest("BuyItem",_loc3_,false,buyItemCallback);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function buyItemCallback(param1:ServerResponse) : void
      {
         var _loc2_:Object = param1.data;
         if((BattleManager.isBattleInProgress() || BattleManager._connectedToBattleManager) && !Tutorial._tutorial)
         {
            MessageCenter.sendEvent(new PurchaseMessage());
         }
         MessageCenter.sendMessage("ItemBought",_loc2_);
         MessageCenter.sendEvent(new ChallengeItemBoughtMessage(_loc2_.item.item_id,currentGame.player.id));
      }
      
      private static function buyItemLevelUpSales(param1:ShopItemLevelUpSalesMessage) : void
      {
         var _loc2_:ShopItem = param1.shopItem;
         var _loc3_:Object = {
            "item_id":_loc2_.id,
            "amount":1,
            "in_battle":BattleManager.isBattleInProgress() || BattleManager._connectedToBattleManager
         };
         var _loc4_:ServerRequest = new ServerRequest("BuyLevelUpSale",_loc3_,false,buyItemLevelUpSalesCallback);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function buyItemLevelUpSalesCallback(param1:ServerResponse) : void
      {
         var _loc2_:Object = param1.data;
         MessageCenter.sendMessage("ItemBoughtLevelUpSales",_loc2_);
         MessageCenter.sendEvent(new ChallengeItemBoughtMessage(_loc2_.item.item_id,currentGame.player.id));
      }
      
      private static function buyItemCouponSales(param1:ShopItemCouponMessage) : void
      {
         var _loc2_:CouponData = param1.couponData;
         var _loc3_:Object = {
            "coupon_id":_loc2_.id,
            "in_battle":BattleManager.isBattleInProgress() || BattleManager._connectedToBattleManager
         };
         var _loc4_:ServerRequest = new ServerRequest("AcceptCouponItem",_loc3_,false,buyItemCouponCallback);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function buyItemCouponCallback(param1:ServerResponse) : void
      {
         var _loc2_:Object = param1.data;
         MessageCenter.sendMessage("ItemBoughtCouponSales",_loc2_);
         MessageCenter.sendEvent(new ChallengeItemBoughtMessage(_loc2_.item.item_id,currentGame.player.id));
      }
      
      private static function closeLevelUpSales(param1:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("ClearLevelUpSale");
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function sendFps(param1:Message) : void
      {
         if(BattleManager.isPracticeMode())
         {
            return;
         }
         var _loc2_:FpsCounter = param1.data;
         var _loc3_:Object = {
            "eventType":"fps",
            "browser":DCUtils.getBrowser(),
            "averageFps":_loc2_.frameRate,
            "averageLogic":_loc2_.logicUpdateRate,
            "averagePhysLogic":_loc2_.physicsUpdateRate,
            "lowestFps":_loc2_.lowestFps,
            "highestFps":_loc2_.highestFps,
            "levelName":_loc2_.levelName,
            "timeBetweenTurns":_loc2_.timeBetweenTurns,
            "playerTurnsTime":BattleManager._playerTurnsTime,
            "playerTurnsTimeDiff":BattleManager._playerTurnsTimeDiffRealActual
         };
         var _loc4_:ServerRequest = new ServerRequest("ClientTracking",_loc3_);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function matchStarted(param1:Message) : void
      {
         if(BattleManager.isPracticeMode())
         {
            return;
         }
         var _loc2_:String = "";
         try
         {
            _loc2_ = currentGame.tuxWorld.physicsWorld.level.id;
         }
         catch(error:Error)
         {
         }
         var _loc3_:Object = {
            "eventType":"matchStarted",
            "levelName":_loc2_,
            "timeToStart":(getTimer() - param1.data) / 1000
         };
         var _loc4_:ServerRequest = new ServerRequest("ClientTracking",_loc3_);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function unlockItem(param1:Message) : void
      {
         var _loc2_:ShopItem = param1.data;
         var _loc3_:Object = {"item_id":_loc2_.id};
         var _loc4_:ServerRequest = new ServerRequest("UnlockItem",_loc3_,false,unlockItemCallback);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function unlockItemCallback(param1:ServerResponse) : void
      {
         if(Boolean(BattleManager.isBattleInProgress()) || Boolean(BattleManager._connectedToBattleManager))
         {
            MessageCenter.sendEvent(new PurchaseMessage());
         }
         MessageCenter.sendMessage("ItemUnlocked",param1.data);
      }
      
      private static function equipItem(param1:Message) : void
      {
         var _loc2_:ShopItem = param1.data;
         var _loc3_:Object = {"item_id":_loc2_.id};
         var _loc4_:ServerRequest = new ServerRequest("WearItem",_loc3_,false,equipItemCallback);
         MessageCenter.sendEvent(_loc4_);
         waitingForCallbackToEquipment = _loc4_.callId;
      }
      
      private static function equipItemCallback(param1:ServerResponse) : void
      {
         if(param1.callId == waitingForCallbackToEquipment)
         {
            waitingForCallbackToEquipment = null;
         }
         var _loc2_:Object = param1.data;
         MessageCenter.sendMessage("ItemEquipped",_loc2_);
      }
      
      public static function isEquipmentChangingBusy() : Boolean
      {
         return waitingForCallbackToEquipment != null;
      }
      
      private static function unEquipItem(param1:Message) : void
      {
         var _loc2_:ShopItem = param1.data;
         var _loc3_:Object = {"item_id":_loc2_.id};
         var _loc4_:ServerRequest = new ServerRequest("UnwearItem",_loc3_,false,unEquipItemCallback);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function unEquipItemCallback(param1:ServerResponse) : void
      {
         var _loc2_:Object = param1.data;
         MessageCenter.sendMessage("ItemUnEquipped",_loc2_);
      }
      
      private static function craftItem(param1:Message) : void
      {
         var _loc2_:RecipeData = param1.data;
         var _loc3_:Object = {"recipe_id":_loc2_.id};
         var _loc4_:ServerRequest = new ServerRequest("CraftItem",_loc3_,false,craftItemCallback);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function craftItemCallback(param1:ServerResponse) : void
      {
         var _loc2_:Object = param1.data;
         MessageCenter.sendMessage("ItemCrafted",_loc2_);
         MessageCenter.sendEvent(new ChallengeItemCraftedMessage(_loc2_.crafted_item.item_id,currentGame.player.id));
      }
      
      private static function startResearch(param1:Message) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:Object = null;
         var _loc6_:ServerRequest = null;
         var _loc2_:Vector.<ItemData> = param1.data;
         var _loc3_:* = "";
         for each(_loc4_ in _loc2_)
         {
            if(_loc3_.length > 0)
            {
               _loc3_ += ",";
            }
            _loc3_ += _loc4_.id;
         }
         _loc5_ = {"ingredients":_loc3_};
         _loc6_ = new ServerRequest("StartResearch",_loc5_,false,null);
         MessageCenter.sendEvent(_loc6_);
      }
      
      private static function completeResearch(param1:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("CompleteResearch",null,false,completeResearchCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function completeResearchCallback(param1:ServerResponse) : void
      {
         var _loc2_:Object = param1.data;
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
      
      private static function completeResearchInstant(param1:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("CompleteInstantResearch",null,false,completeResearchInstantCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function completeResearchInstantCallback(param1:ServerResponse) : void
      {
         var _loc2_:Object = param1.data;
         if(_loc2_ != null)
         {
            currentGame.player.addPremiumMoney(-Tuner.getField("ResearchInstantCompleteCost").value);
            if(!Research._instance)
            {
               new Research();
            }
            Research._instance.instantComplete(_loc2_);
         }
      }
      
      private static function collectResearchRewards(param1:Message) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:Object = null;
         var _loc6_:ServerRequest = null;
         var _loc2_:Vector.<ItemData> = param1.data;
         var _loc3_:* = "";
         for each(_loc4_ in _loc2_)
         {
            if(_loc3_.length > 0)
            {
               _loc3_ += ",";
            }
            _loc3_ += _loc4_.id;
         }
         _loc5_ = {"ingredients":_loc3_};
         _loc6_ = new ServerRequest("CollectResearchRewards",_loc5_,false,collectResearchRewardsCallback);
         MessageCenter.sendEvent(_loc6_);
      }
      
      private static function collectResearchRewardsCallback(param1:ServerResponse) : void
      {
         var _loc2_:Object = param1.data;
         if(_loc2_ != null)
         {
            MessageCenter.sendMessage("CollectResearchRewardsResponse",_loc2_);
         }
      }
      
      private static function tournamentUpdate(param1:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("GetTournamentInformation",param1.data,false,tournamentUpdateCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function tournamentUpdateCallback(param1:ServerResponse) : void
      {
         LogUtils.log("tournamentUpdateCallback","ServerServices",0,"Tournament");
         var _loc2_:Object = param1.data;
         if(_loc2_ != null)
         {
            MessageCenter.sendMessage("TournamentUpdated",_loc2_);
         }
      }
      
      private static function tournamentRewardClaim(param1:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("CollectTournamentRewards",param1.data,false,tournamentRewardClaimCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function tournamentRewardClaimCallback(param1:ServerResponse) : void
      {
         LogUtils.log("tournamentRewardClaimCallback","ServerServices",0,"Tournament");
         var _loc2_:Object = param1.data;
         if(_loc2_ != null)
         {
            MessageCenter.sendMessage("TournamentRewardClaimed",_loc2_);
         }
      }
      
      private static function inboxUpdate(param1:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("GetInboxStatus",null,false,inboxUpdateCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function inboxUpdateCallback(param1:ServerResponse) : void
      {
         LogUtils.log("inboxUpdateCallback","ServerServices",0,"Inbox",false,false,true);
         var _loc2_:Object = param1.data;
         if(_loc2_ != null)
         {
            MessageCenter.sendMessage("InboxUpdated",_loc2_);
         }
      }
      
      private static function checkGiftStatus(param1:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("CheckGiftStatus",param1.data,false,giftStatusCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function giftStatusCallback(param1:ServerResponse) : void
      {
         LogUtils.log("giftStatusCallback","ServerServices",0,"Gift",false,false,true);
         var _loc2_:Object = param1.data;
         if(_loc2_ != null)
         {
            MessageCenter.sendMessage("GiftStatusChecked",_loc2_);
         }
      }
      
      private static function canSendGiftBack(param1:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("CanSendGiftBackToSender",param1.data,false,canSendGiftBackCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function canSendGiftBackCallback(param1:ServerResponse) : void
      {
         LogUtils.log("canSendGiftBackCallback","ServerServices",0,"Gift",false,false,true);
         var _loc2_:Object = param1.data;
         if(_loc2_ != null)
         {
            MessageCenter.sendMessage("CanSendGiftBackToSenderChecked",_loc2_);
         }
      }
      
      private static function challengesUpdateNotInBattle(param1:Message) : void
      {
         var _loc2_:ChallengeData = param1.data;
         var _loc3_:Object = {"challenge_id":_loc2_.id};
         var _loc4_:ServerRequest = new ServerRequest("CompleteChallenge",_loc3_,false,challengesUpdateNotInBattleCallback);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function challengesUpdateNotInBattleCallback(param1:ServerResponse) : void
      {
         if(param1.data)
         {
            MessageCenter.sendMessage("ChallengesUpdateServerResponse",param1.data);
         }
      }
      
      private static function isMaintenanceMode(param1:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("CheckServerStatus",null,false,isMaintenanceModeCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function isMaintenanceModeCallback(param1:ServerResponse) : void
      {
         var _loc2_:Object = param1.data;
         var _loc3_:Boolean = false;
         if(_loc2_)
         {
            if(_loc2_.hasOwnProperty("productionUpdate"))
            {
               _loc3_ = Boolean(_loc2_.productionUpdate);
            }
         }
         MessageCenter.sendMessage("MaintenanceModeReply",_loc3_);
      }
      
      private static function slotMachinePlay(param1:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("PlaySlotMachine",null,false,slotMachinePlayCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function slotMachinePlayCallback(param1:ServerResponse) : void
      {
         var _loc2_:Object = param1.data;
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
      
      private static function slotMachineResetSpins(param1:Message) : void
      {
         var _loc2_:Object = {"reset_amount":param1.data};
         var _loc3_:ServerRequest = new ServerRequest("ResetSlotMachineSpins",_loc2_,false,slotMachineResetSpinsCallback);
         MessageCenter.sendEvent(_loc3_);
      }
      
      private static function slotMachineResetSpinsCallback(param1:ServerResponse) : void
      {
         var _loc2_:Object = param1.data;
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
         if(!PopUpManager.instance)
         {
            PopUpManager.instance = new PopUpManager();
         }
         PopUpManager.instance.showPopUps(currentGame.homeState);
      }
      
      private static function freeWeaponPackageRequest(param1:Message) : void
      {
         var _loc2_:ServerRequest = new ServerRequest("FreeWeaponPackagePopUp",null,false,freeWeaponPackageRequestCallBack);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function freeWeaponPackageRequestCallBack(param1:ServerResponse) : void
      {
         var _loc2_:Object = param1.data;
         MessageCenter.sendMessage("FreeWeaponPackageResponse",_loc2_);
      }
   }
}

