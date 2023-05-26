package tuxwars.net
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.net.ServerResponse;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.friendselector.FriendSelectorState;
   import tuxwars.home.ui.logic.gifts.GiftManager;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   import tuxwars.home.ui.logic.inbox.RequestData;
   import tuxwars.net.objects.JavaScriptObject;
   import tuxwars.net.objects.RequestObject;
   
   public class GiftService
   {
      
      public static const CRM_TYPE_GIFT:String = "Gift";
      
      public static const CRM_PRODUCT_SEND_GIFT:String = "Send Gift";
      
      public static const PLATFORM_REQUEST_TYPE_GIFT:int = 0;
      
      private static var currentGame:TuxWarsGame;
       
      
      public function GiftService()
      {
         super();
         throw new Error("GiftService is a static class!");
      }
      
      public static function init(game:TuxWarsGame) : void
      {
         LogUtils.log("Initialized GiftService","GiftService",0,"Gift",false,false,false);
         currentGame = game;
         MessageCenter.addListener("beforeSendRequestCallback",beforeSendRequestCallback);
         MessageCenter.addListener("afterSendRequestCallback",afterSendRequestCallback);
         MessageCenter.addListener("ResponseReceived_" + "SendGiftRequest",callbackCatcher);
         MessageCenter.addListener("ResponseReceived_" + "AcceptGift",callbackCatcher);
         MessageCenter.addListener("InboxGiftAccept",accept);
      }
      
      public static function dispose(game:TuxWarsGame) : void
      {
         LogUtils.log("Disposed GiftService","GiftService",0,"Gift",false,false,false);
         currentGame = null;
         MessageCenter.removeListener("beforeSendRequestCallback",beforeSendRequestCallback);
         MessageCenter.removeListener("afterSendRequestCallback",afterSendRequestCallback);
         MessageCenter.removeListener("ResponseReceived_" + "SendGiftRequest",callbackCatcher);
         MessageCenter.removeListener("ResponseReceived_" + "AcceptGift",callbackCatcher);
         MessageCenter.removeListener("InboxGiftAccept",accept);
      }
      
      public static function sendGift(giftReference:GiftReference, titleTID:String, messageTID:String, to:Array, fromWhereInClient:String, titleTIDParam:Array = null, messageTIDParam:Array = null, filters:Array = null, excludes:String = null) : void
      {
         var sendRequest:* = null;
         CRMService.sendEvent("Social","Gift","Started",giftReference.id,null,0,null,true);
         LogUtils.log("Send Gift: " + giftReference.id + " with target to: " + (to != null ? to.toString() : null) + " from: " + fromWhereInClient + " with filters: " + (filters != null ? filters.toString() : null) + " with excludes: " + (excludes != null ? excludes.toString() : null),"GiftService",0,"Gift",false,false,false);
         if(to == null && Config.useHomemadeFriendSelector())
         {
            sendRequest = new SendRequestObject("GIFT",friendsSelectorResponse,titleTID,messageTID,fromWhereInClient,titleTIDParam,messageTIDParam);
            sendRequest.giftReference = giftReference;
            currentGame.homeState.changeState(new FriendSelectorState(currentGame,sendRequest));
         }
         else
         {
            JavaScriptServices.callJavascript(createObject(ProjectManager.getText(titleTID,titleTIDParam),ProjectManager.getText(messageTID,messageTIDParam),to,filters,excludes,null,giftReference,fromWhereInClient),false);
         }
      }
      
      public static function friendsSelectorResponse(selectedList:String, sendRequest:SendRequestObject) : void
      {
         var inviteArray:Array = [];
         inviteArray.push(selectedList);
         JavaScriptServices.callJavascript(createObject(sendRequest.title,sendRequest.message,inviteArray,null,null,null,sendRequest.giftReference,sendRequest.fromWhereInClient),false);
      }
      
      private static function createObject(title:String, message:String, to:Array, filters:Array, excludes:String, toPlatform:String, giftReference:GiftReference, fromWhereInClient:String) : JavaScriptObject
      {
         var obj:RequestObject = new RequestObject(to,filters,toPlatform,title,message,giftReference.id);
         obj.type = 0;
         obj.crm_event_type = "Gift";
         obj.product = "Send Gift";
         obj.product_detail = giftReference.id;
         obj.exclude_ids = excludes;
         return obj;
      }
      
      private static function callbackCatcher(msg:Message) : void
      {
         var _loc2_:* = null;
         if(msg.data)
         {
            if(Config.debugMode)
            {
               LogUtils.log("DEBUG: " + msg.data,"GiftService",0,"Gift",false,false,false);
            }
            if(msg.data is String)
            {
               _loc2_ = JSON.parse(msg.data);
               if(_loc2_ != null)
               {
                  if(_loc2_.data != null && _loc2_.data.type == 0)
                  {
                     LogUtils.log("callbackCatcher data is as follows, use if needed","GiftService",0,"Gift",false,false,false);
                     LogUtils.log(msg.data,"GiftService",0,"Gift",false,false,false);
                  }
               }
            }
         }
      }
      
      private static function beforeSendRequestCallback(msg:Message) : void
      {
         callbackCatcher(msg);
      }
      
      private static function afterSendRequestCallback(msg:Message) : void
      {
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(msg.data)
         {
            _loc6_ = JSON.parse(msg.data);
            if(_loc6_)
            {
               if(_loc6_.data != null && _loc6_.data.type == 0)
               {
                  _loc2_ = _loc6_.to;
                  if(_loc2_)
                  {
                     _loc5_ = _loc6_.data.data;
                     _loc3_ = _loc6_.request;
                     _loc4_ = _loc2_.toString();
                     notifyGameServerGiftSend(_loc3_,_loc4_,_loc5_,Config.getPlatform());
                  }
                  else
                  {
                     CRMService.sendEvent("Social","Gift","Cancelled",_loc5_);
                  }
               }
            }
         }
      }
      
      private static function notifyGameServerGiftSend(requestID:String, recipientIDs:String, giftID:String, responsePlatformId:String) : void
      {
         var _loc6_:* = null;
         var _loc5_:* = null;
         LogUtils.log("Send gift requestID:" + requestID + " for giftID: " + giftID + " to recipientIDs: " + recipientIDs + " responsePlatformId: " + responsePlatformId,"GiftService",0,"Gift",false,false,false);
         if(requestID != null && recipientIDs != null && giftID != null)
         {
            _loc6_ = {
               "request_id":requestID,
               "recipient_ids":recipientIDs,
               "gift_id":giftID,
               "recipients_platform":responsePlatformId
            };
            currentGame.giftingInfo.addGiftForFriends(giftID,recipientIDs);
            _loc5_ = new ServerRequest("SendGiftRequest",_loc6_,false,notifyGameServerGiftSendCallback);
            MessageCenter.sendEvent(_loc5_);
         }
         else
         {
            LogUtils.log("notifyGameServerGiftSend something is null","ServerServices",0,"Gift",false,false,true);
         }
      }
      
      private static function notifyGameServerGiftSendCallback(response:ServerResponse) : void
      {
         LogUtils.log("notifyGameServerGiftSendCallback","ServerServices",0,"Gift",false,false,false);
      }
      
      private static function accept(msg:Message) : void
      {
         var _loc4_:RequestData = msg.data;
         LogUtils.log("Accepted gift: " + _loc4_.giftID + " from: " + _loc4_.senderID,"GiftService",0,"Gift",false,false,false);
         var _loc3_:Object = {"request_ids":_loc4_.requestID};
         var _loc2_:ServerRequest = new ServerRequest("AcceptGift",_loc3_,false,acceptCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function acceptCallback(response:ServerResponse) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         LogUtils.log("giftAcceptCallback","GiftService",0,"Gift",false,false,true);
         if(response.data != null && response.data.accept_gift_results != null && response.data.accept_gift_results.result != null)
         {
            _loc3_ = response.data.accept_gift_results.result.received;
            if(_loc3_)
            {
               addGift(_loc3_);
               _loc2_ = {};
               _loc2_["received"] = _loc3_;
               _loc2_["request_id"] = response.data.accept_gift_results.result.request_id;
               MessageCenter.sendMessage("InboxGiftAcceptReceipt",_loc2_);
            }
         }
         else
         {
            MessageCenter.sendMessage("InboxGiftAcceptReceipt",null);
         }
      }
      
      private static function addGift(id:String) : void
      {
         var _loc2_:GiftReference = GiftManager.getGiftReference(id);
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
               currentGame.player.inventory.addItem(id);
               break;
            default:
               LogUtils.log("Unknown gift type: " + _loc2_.type,"GiftService",2,"Gift");
         }
      }
   }
}
