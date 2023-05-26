package tuxwars.net
{
   import com.dchoc.utils.LogUtils;
   import flash.utils.getQualifiedClassName;
   import tuxwars.battle.ui.screen.afterresultsales.AfterResultSalesScreen;
   import tuxwars.battle.ui.screen.boosterselection.BoosterSelectionScreen;
   import tuxwars.battle.ui.screen.couponfound.CouponFoundScreen;
   import tuxwars.battle.ui.screen.weaponselection.WeaponSelectionScreen;
   import tuxwars.home.ui.screen.crafting.CraftingScreen;
   import tuxwars.home.ui.screen.dailynews.DailyNewsScreen;
   import tuxwars.home.ui.screen.equipment.EquipmentScreen;
   import tuxwars.home.ui.screen.matchloading.MatchLoadingScreen;
   import tuxwars.home.ui.screen.shop.ShopScreen;
   import tuxwars.net.objects.CRMEventObject;
   import tuxwars.net.objects.JavaScriptCRMObject;
   import tuxwars.ui.popups.screen.crm.CRMMessagePopUpScreen;
   
   public class CRMService
   {
      
      public static const GROUP_SOCIAL:String = "Social";
      
      public static const GROUP_TUTORIAL:String = "Tutorial";
      
      public static const GROUP_GAME:String = "Game";
      
      public static const GROUP_GAME_DATA:String = "GameData";
      
      public static const GROUP_ECONOMY:String = "Economy";
      
      public static const GROUP_ACTION:String = "Action";
      
      public static const GROUP_LEVEL:String = "Level";
      
      public static const GROUP_GAME_ERROR:String = "Game Error";
      
      public static const GROUP_SLOTMACHINE:String = "SlotMachine";
      
      public static const GROUP_POPUP:String = "PopUp";
      
      public static const TYPE_SESSION_STARTED:String = "Session Started";
      
      public static const TYPE_PLAY_TUTORIAL:String = "Play_Tutorial";
      
      public static const TYPE_PLAY_SLOTMACHINE:String = "Play_SlotMachine";
      
      public static const TYPE_BUTTON_PRESSED:String = "Button_Pressed";
      
      public static const TYPE_MENU:String = "Menu";
      
      public static const TYPE_TABS:String = "Tabs";
      
      public static const TYPE_SETTINGS_CHANGED:String = "Settings_changed";
      
      public static const TYPE_NOT_ENOUGH_CASH:String = "Not_enough_Cash";
      
      public static const TYPE_EARN_GC:String = "Earn GC";
      
      public static const TYPE_EARN_PC:String = "Earn PC";
      
      public static const TYPE_EARN_XP:String = "Earn XP";
      
      public static const TYPE_EARN_VIP:String = "Earn VIP";
      
      public static const TYPE_BUY_VIP:String = "Buy VIP";
      
      public static const TYPE_EARN_ITEM:String = "Earn_Item";
      
      public static const TYPE_EARN_SCORE:String = "Earn_Score";
      
      public static const TYPE_EARN_HEALING:String = "Earn_Healing";
      
      public static const TYPE_PULL_LEVER:String = "Pull_lever";
      
      public static const TYPE_FB_INVITE:String = "FB_Invite";
      
      public static const TYPE_SPEND_GC:String = "Spend GC";
      
      public static const TYPE_SPEND_PC:String = "Spend PC";
      
      public static const TYPE_PC_PURCHASE:String = "Purchase PC";
      
      public static const TYPE_GC_PURCHASE:String = "Purchase GC";
      
      public static const TYPE_CHALLENGE:String = "Challenge";
      
      public static const TYPE_SERVICE_TIME_GETACCOUNTINFORMATION:String = "Service_time_GetAccountInformation";
      
      public static const TYPE_FLASH_LOADING:String = "Flash_Loading";
      
      public static const TYPE_FPS_TIME_3_MINUTES:String = "Fps_time_3_minutes";
      
      public static const TYPE_INSTALL_PAGE_VIEWED:String = "Install_Page_Viewed";
      
      public static const TYPE_APP_INSTALLED:String = "App_installed";
      
      public static const TYPE_LEVEL_REACHED:String = "Level_reached";
      
      public static const TYPE_FB_GIFT:String = "Gift";
      
      public static const TYPE_FEED_POSTED:String = "Feed_posted";
      
      public static const TYPE_FEED_CLICKED:String = "Feed_clicked";
      
      public static const TYPE_REQUEST_SENT:String = "Request_sent";
      
      public static const TYPE_REQUEST_CLICKED:String = "Request_clicked";
      
      public static const TYPE_DAILY_NEWS:String = "Cpw_news";
      
      public static const TYPE_USE_WEAPON:String = "Use_Weapon";
      
      public static const TYPE_BATTLE_ENDED:String = "Battle_Ended";
      
      public static const TYPE_CLIENT:String = "Client";
      
      public static const TYPE_MATCHMAKER:String = "MatchMaker";
      
      public static const TYPE_SLOTMACHINE_REWARD:String = "Slotmachine_Reward";
      
      public static const TYPE_CHARACTER_MENU:String = "CharacterMenu";
      
      public static const TYPE_LEVEL_UP:String = "Level Up";
      
      public static const TYPE_SHOWN:String = "Shown";
      
      public static const TYPE_PERFORMANCE:String = "Performance";
      
      public static const TYPE_CRM_MESSAGE:String = "CRM_Message";
      
      public static const TYPE_MESSAGE_SPEED_DATA:String = "Message_Speed";
      
      public static const TYPE_TOURNAMENT_ENDED:String = "Tournament_Ended";
      
      public static const LABEL_CLICKED:String = "Clicked";
      
      public static const LABEL_REACHED:String = "Reached";
      
      public static const LABEL_CANCELLED:String = "Cancelled";
      
      public static const LABEL_SENT:String = "Sent";
      
      public static const LABEL_STARTED:String = "Started";
      
      public static const LABEL_CONFIRMED:String = "Confirmed";
      
      public static const LABEL_ON_FLASH:String = "OnFlash";
      
      public static const LABEL_ON_CLIENT:String = "On_Client";
      
      public static const LABEL_GET_POWERUP:String = "Get_powerup";
      
      public static const LABEL_USED:String = "Used";
      
      public static const LABEL_SHOW_ERROR_POPUP:String = "ShowErrorPopup";
      
      public static const LABEL_REWARD:String = "Reward";
      
      public static const LABEL_VIPMEMBERSHIP:String = "VIPMEMBERSHIP";
      
      private static const storedClassName:Object = {};
      
      {
         storedClassName[getQualifiedClassName(EquipmentScreen)] = "CharacterMenu";
         storedClassName[getQualifiedClassName(ShopScreen)] = "SuppliesMenu";
         storedClassName[getQualifiedClassName(WeaponSelectionScreen)] = "WeaponSelection";
         storedClassName[getQualifiedClassName(BoosterSelectionScreen)] = "BoosterSelection";
         storedClassName[getQualifiedClassName(AfterResultSalesScreen)] = "AfterResultSales";
         storedClassName[getQualifiedClassName(CouponFoundScreen)] = "Coupon";
         storedClassName[getQualifiedClassName(CraftingScreen)] = "CraftingMenu";
         storedClassName[getQualifiedClassName(DailyNewsScreen)] = "DailyNewsScreen";
         storedClassName[getQualifiedClassName(MatchLoadingScreen)] = "MatchLoadingScreen";
         storedClassName[getQualifiedClassName(CRMMessagePopUpScreen)] = "CRMMessagePopUpScreen";
      }
      
      public function CRMService()
      {
         super();
         throw new Error("CRMService is a static class!");
      }
      
      public static function sendEvent(group:String, type:String, userAction:String = null, product:String = null, productDetail:String = null, value:int = 0, parameters:Object = null, leaveFullScreen:Boolean = false) : void
      {
         if(!group)
         {
            LogUtils.log("Group is null.","CRMService",3,"CRM",true,true,true);
         }
         if(!type)
         {
            LogUtils.log("Type is null.","CRMService",3,"CRM",true,true,true);
         }
         var _loc10_:Object = {};
         if(parameters)
         {
            for(var key in parameters)
            {
               _loc10_[key] = parameters[key];
            }
         }
         if(userAction)
         {
            _loc10_["user_action"] = userAction;
         }
         if(product)
         {
            _loc10_["product"] = product;
         }
         if(productDetail)
         {
            _loc10_["product_detail"] = productDetail;
         }
         if(value != 0)
         {
            _loc10_["value"] = value;
         }
         JavaScriptServices.callJavascript(new CRMEventObject(group,type,_loc10_),leaveFullScreen);
      }
      
      public static function sendEventObject(data:Object) : void
      {
         sendEvent(data.group,data.type,data.label,data.product);
      }
      
      public static function addCommonCrmParametersForRequestData(requestData:JavaScriptCRMObject) : void
      {
         if(requestData.group == "Social")
         {
            LogUtils.log("TODO FIND data for ... commonCrmParameters",null,3,"JavaScriptObject",false,false,true);
         }
      }
      
      public static function classChecker(value:*) : String
      {
         var qualifiedClassName:String = getQualifiedClassName(value);
         if(storedClassName.hasOwnProperty(qualifiedClassName))
         {
            return storedClassName[qualifiedClassName];
         }
         return "NotSpecified";
      }
   }
}
