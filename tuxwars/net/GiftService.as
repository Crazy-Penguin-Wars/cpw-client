package tuxwars.net
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.friendselector.*;
   import tuxwars.home.ui.logic.gifts.*;
   import tuxwars.home.ui.logic.inbox.RequestData;
   import tuxwars.net.objects.*;
   
   public class GiftService
   {
      private static var currentGame:TuxWarsGame;
      
      public static const CRM_TYPE_GIFT:String = "Gift";
      
      public static const CRM_PRODUCT_SEND_GIFT:String = "Send Gift";
      
      public static const PLATFORM_REQUEST_TYPE_GIFT:int = 0;
      
      public function GiftService()
      {
         super();
         throw new Error("GiftService is a static class!");
      }
      
      public static function init(param1:TuxWarsGame) : void
      {
         LogUtils.log("Initialized GiftService","GiftService",0,"Gift",false,false,false);
         currentGame = param1;
         MessageCenter.addListener("beforeSendRequestCallback",beforeSendRequestCallback);
         MessageCenter.addListener("afterSendRequestCallback",afterSendRequestCallback);
         MessageCenter.addListener("ResponseReceived_" + "SendGiftRequest",callbackCatcher);
         MessageCenter.addListener("ResponseReceived_" + "AcceptGift",callbackCatcher);
         MessageCenter.addListener("InboxGiftAccept",accept);
      }
      
      public static function dispose(param1:TuxWarsGame) : void
      {
         LogUtils.log("Disposed GiftService","GiftService",0,"Gift",false,false,false);
         currentGame = null;
         MessageCenter.removeListener("beforeSendRequestCallback",beforeSendRequestCallback);
         MessageCenter.removeListener("afterSendRequestCallback",afterSendRequestCallback);
         MessageCenter.removeListener("ResponseReceived_" + "SendGiftRequest",callbackCatcher);
         MessageCenter.removeListener("ResponseReceived_" + "AcceptGift",callbackCatcher);
         MessageCenter.removeListener("InboxGiftAccept",accept);
      }
      
      public static function sendGift(param1:GiftReference, param2:String, param3:String, param4:Array, param5:String, param6:Array = null, param7:Array = null, param8:Array = null, param9:String = null) : void
      {
         var _loc10_:SendRequestObject = null;
         CRMService.sendEvent("Social","Gift","Started",param1.id,null,0,null,true);
         LogUtils.log("Send Gift: " + param1.id + " with target to: " + (param4 != null ? param4.toString() : null) + " from: " + param5 + " with filters: " + (param8 != null ? param8.toString() : null) + " with excludes: " + (param9 != null ? param9.toString() : null),"GiftService",0,"Gift",false,false,false);
         if(param4 == null && Config.useHomemadeFriendSelector())
         {
            _loc10_ = new SendRequestObject("GIFT",friendsSelectorResponse,param2,param3,param5,param6,param7);
            _loc10_.giftReference = param1;
            currentGame.homeState.changeState(new FriendSelectorState(currentGame,_loc10_));
         }
         else
         {
            JavaScriptServices.callJavascript(createObject(ProjectManager.getText(param2,param6),ProjectManager.getText(param3,param7),param4,param8,param9,null,param1,param5),false);
         }
      }
      
      public static function friendsSelectorResponse(param1:String, param2:SendRequestObject) : void
      {
         var _loc3_:Array = [];
         _loc3_.push(param1);
         JavaScriptServices.callJavascript(createObject(param2.title,param2.message,_loc3_,null,null,null,param2.giftReference,param2.fromWhereInClient),false);
      }
      
      private static function createObject(param1:String, param2:String, param3:Array, param4:Array, param5:String, param6:String, param7:GiftReference, param8:String) : JavaScriptObject
      {
         var _loc9_:RequestObject = new RequestObject(param3,param4,param6,param1,param2,param7.id);
         _loc9_.type = 0;
         _loc9_.crm_event_type = "Gift";
         _loc9_.product = "Send Gift";
         _loc9_.product_detail = param7.id;
         _loc9_.exclude_ids = param5;
         return _loc9_;
      }
      
      private static function callbackCatcher(param1:Message) : void
      {
         var _loc2_:Object = null;
         if(param1.data)
         {
            if(Config.debugMode)
            {
               LogUtils.log("DEBUG: " + param1.data,"GiftService",0,"Gift",false,false,false);
            }
            if(param1.data is String)
            {
               _loc2_ = JSON.parse(param1.data);
               if(_loc2_ != null)
               {
                  if(_loc2_.data != null && _loc2_.data.type == 0)
                  {
                     LogUtils.log("callbackCatcher data is as follows, use if needed","GiftService",0,"Gift",false,false,false);
                     LogUtils.log(param1.data,"GiftService",0,"Gift",false,false,false);
                  }
               }
            }
         }
      }
      
      private static function beforeSendRequestCallback(param1:Message) : void
      {
         callbackCatcher(param1);
      }
      
      private static function afterSendRequestCallback(param1:Message) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(param1.data)
         {
            _loc2_ = JSON.parse(param1.data);
            if(_loc2_)
            {
               if(_loc2_.data != null && _loc2_.data.type == 0)
               {
                  _loc3_ = _loc2_.to;
                  if(_loc3_)
                  {
                     _loc4_ = _loc2_.data.data;
                     _loc5_ = _loc2_.request;
                     _loc6_ = _loc3_.toString();
                     notifyGameServerGiftSend(_loc5_,_loc6_,_loc4_,Config.getPlatform());
                  }
                  else
                  {
                     CRMService.sendEvent("Social","Gift","Cancelled",_loc4_);
                  }
               }
            }
         }
      }
      
      private static function notifyGameServerGiftSend(param1:String, param2:String, param3:String, param4:String) : void
      {
         var _loc5_:Object = null;
         var _loc6_:ServerRequest = null;
         LogUtils.log("Send gift requestID:" + param1 + " for giftID: " + param3 + " to recipientIDs: " + param2 + " responsePlatformId: " + param4,"GiftService",0,"Gift",false,false,false);
         if(param1 != null && param2 != null && param3 != null)
         {
            _loc5_ = {
               "request_id":param1,
               "recipient_ids":param2,
               "gift_id":param3,
               "recipients_platform":param4
            };
            currentGame.giftingInfo.addGiftForFriends(param3,param2);
            _loc6_ = new ServerRequest("SendGiftRequest",_loc5_,false,notifyGameServerGiftSendCallback);
            MessageCenter.sendEvent(_loc6_);
         }
         else
         {
            LogUtils.log("notifyGameServerGiftSend something is null","ServerServices",0,"Gift",false,false,true);
         }
      }
      
      private static function notifyGameServerGiftSendCallback(param1:ServerResponse) : void
      {
         LogUtils.log("notifyGameServerGiftSendCallback","ServerServices",0,"Gift",false,false,false);
      }
      
      private static function accept(param1:Message) : void
      {
         var _loc2_:RequestData = param1.data;
         LogUtils.log("Accepted gift: " + _loc2_.giftID + " from: " + _loc2_.senderID,"GiftService",0,"Gift",false,false,false);
         var _loc3_:Object = {"request_ids":_loc2_.requestID};
         var _loc4_:ServerRequest = new ServerRequest("AcceptGift",_loc3_,false,acceptCallback);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function acceptCallback(param1:ServerResponse) : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         LogUtils.log("giftAcceptCallback","GiftService",0,"Gift",false,false,true);
         if(param1.data != null && param1.data.accept_gift_results != null && param1.data.accept_gift_results.result != null)
         {
            _loc2_ = param1.data.accept_gift_results.result.received;
            if(_loc2_)
            {
               addGift(_loc2_);
               _loc3_ = {};
               _loc3_["received"] = _loc2_;
               _loc3_["request_id"] = param1.data.accept_gift_results.result.request_id;
               MessageCenter.sendMessage("InboxGiftAcceptReceipt",_loc3_);
            }
         }
         else
         {
            MessageCenter.sendMessage("InboxGiftAcceptReceipt",null);
         }
      }
      
      private static function addGift(param1:String) : void
      {
         var _loc2_:GiftReference = GiftManager.getGiftReference(param1);
         switch(_loc2_.type)
         {
            case "Coins":
               currentGame.player.addIngameMoney(_loc2_.amount);
               break;
            case "Cash":
               currentGame.player.addPremiumMoney(_loc2_.amount);
               break;
            case "Exp":
               currentGame.player.addExp(_loc2_.amount);
               break;
            case "Item":
               currentGame.player.inventory.addItem(param1);
               break;
            default:
               LogUtils.log("Unknown gift type: " + _loc2_.type,"GiftService",2,"Gift");
         }
      }
   }
}

