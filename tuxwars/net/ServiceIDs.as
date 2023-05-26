package tuxwars.net
{
   public class ServiceIDs
   {
      
      public static const GET_ACCOUNT_INFO:String = "GetAccountInformation";
      
      public static const PLAY_NOW:String = "PlayNow";
      
      public static const CONFIRM_BATTLE_END:String = "ConfirmBattleEnded";
      
      public static const FREE_WEAPON_PACKAGE_POPUP:String = "FreeWeaponPackagePopUp";
      
      public static const CHECK_SERVER_STATUS:String = "CheckServerStatus";
      
      public static const CUSTOM_GAME:String = "CustomGame";
      
      public static const BUY_ITEM:String = "BuyItem";
      
      public static const BUY_ITEM_LEVEL_UP_SALES:String = "BuyLevelUpSale";
      
      public static const CLEAR_LEVEL_UP_SALES:String = "ClearLevelUpSale";
      
      public static const BUY_ITEM_COUPON_SALES:String = "AcceptCouponItem";
      
      public static const CRAFT_ITEM:String = "CraftItem";
      
      public static const START_RESEARCH:String = "StartResearch";
      
      public static const COLLECT_RESEARCH_REWARDS:String = "CollectResearchRewards";
      
      public static const CLIENT_TRACKING:String = "ClientTracking";
      
      public static const MATCH_STARTED:String = "MatchStarted";
      
      public static const COMPLETE_RESEARCH:String = "CompleteResearch";
      
      public static const COMPLETE_INSTANT_RESEARCH:String = "CompleteInstantResearch";
      
      public static const INBOX_STATUS:String = "GetInboxStatus";
      
      public static const GIFT_STATUS:String = "CheckGiftStatus";
      
      public static const CAN_SEND_GIFT_BACK:String = "CanSendGiftBackToSender";
      
      public static const UNLOCK_ITEM:String = "UnlockItem";
      
      public static const SELL_ITEM:String = "SellItem";
      
      public static const WEAR_ITEM:String = "WearItem";
      
      public static const UNWEAR_ITEM:String = "UnwearItem";
      
      public static const SEND_NEIGHBOR_REQUEST:String = "SendNeighborRequest";
      
      public static const ACCEPT_NEIGHBOR:String = "AcceptNeighbor";
      
      public static const REMOVE_NEIGHBOR:String = "RemoveNeighbor";
      
      public static const CANCEL_NEIGHBOR:String = "CancelNeighbor";
      
      public static const REJECT_NEIGHBOR:String = "RejectNeighbor";
      
      public static const REWARD_GIFT:String = "RewardGift";
      
      public static const SEND_GIFT_REQUEST:String = "SendGiftRequest";
      
      public static const ACCEPT_GIFT:String = "AcceptGift";
      
      public static const SET_FLAG:String = "SetFlag";
      
      public static const COMPLETE_CHALLENGE:String = "CompleteChallenge";
      
      public static const SLOTMACHINE_PLAY:String = "PlaySlotMachine";
      
      public static const SLOTMACHINE_RESET_SPINS:String = "ResetSlotMachineSpins";
      
      public static const MONEY_PURCHASE:String = "MoneyPurchase";
      
      public static const BUY_VIP:String = "BuyVIPMembership";
      
      public static const GET_USER_STATISTICS:String = "GetUserStatistic";
      
      public static const GET_TOURNAMENT_INFORMATION:String = "GetTournamentInformation";
      
      public static const COLLECT_TOURNAMENT_REWARDS:String = "CollectTournamentRewards";
       
      
      public function ServiceIDs()
      {
         super();
         throw new Error("ServiceIDs is a static class!");
      }
   }
}
