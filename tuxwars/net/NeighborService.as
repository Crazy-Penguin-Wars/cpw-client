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
   import tuxwars.home.ui.logic.inbox.RequestData;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.home.ui.screen.neighbors.NeighborsScreen;
   import tuxwars.net.objects.JavaScriptObject;
   import tuxwars.net.objects.RequestObject;
   
   public class NeighborService
   {
      
      public static const CRM_TYPE_INVITE:String = "Invite";
      
      public static const PLATFORM_REQUEST_INVITE:int = 7;
      
      private static var currentGame:TuxWarsGame;
       
      
      public function NeighborService()
      {
         super();
         throw new Error("NeighborService is a static class!");
      }
      
      public static function init(game:TuxWarsGame) : void
      {
         LogUtils.log("Initialized NeighborService","NeighborService",0,"Neighbor",false,false,false);
         currentGame = game;
         MessageCenter.addListener("beforeSendRequestCallback",beforeSendRequestCallback);
         MessageCenter.addListener("afterSendRequestCallback",afterSendRequestCallback);
         MessageCenter.addListener("ResponseReceived_" + "SendNeighborRequest",callbackCatcher);
         MessageCenter.addListener("ResponseReceived_" + "AcceptNeighbor",callbackCatcher);
         MessageCenter.addListener("ResponseReceived_" + "RemoveNeighbor",callbackCatcher);
         MessageCenter.addListener("ResponseReceived_" + "CancelNeighbor",callbackCatcher);
         MessageCenter.addListener("ResponseReceived_" + "RejectNeighbor",callbackCatcher);
         MessageCenter.addListener("NeighborAccept",accept);
         MessageCenter.addListener("NeighborIgnore",reject);
         MessageCenter.addListener("NeighbourRemove",remove);
      }
      
      public static function dispose(game:TuxWarsGame) : void
      {
         LogUtils.log("Dispose NeighborService","NeighborService",0,"Neighbor",false,false,false);
         currentGame = null;
         MessageCenter.removeListener("beforeSendRequestCallback",beforeSendRequestCallback);
         MessageCenter.removeListener("afterSendRequestCallback",afterSendRequestCallback);
         MessageCenter.removeListener("ResponseReceived_" + "SendNeighborRequest",callbackCatcher);
         MessageCenter.removeListener("ResponseReceived_" + "AcceptNeighbor",callbackCatcher);
         MessageCenter.removeListener("ResponseReceived_" + "RemoveNeighbor",callbackCatcher);
         MessageCenter.removeListener("ResponseReceived_" + "CancelNeighbor",callbackCatcher);
         MessageCenter.removeListener("ResponseReceived_" + "RejectNeighbor",callbackCatcher);
         MessageCenter.removeListener("NeighborAccept",accept);
         MessageCenter.removeListener("NeighborIgnore",reject);
         MessageCenter.removeListener("NeighbourRemove",remove);
      }
      
      public static function sendNeighborRequest(titleTID:String, messageTID:String, to:Array, fromWhereInClient:String, titleTIDParam:Array = null, messageTIDParam:Array = null, TODOFilters:Array = null) : void
      {
         var sendRequest:* = null;
         LogUtils.log("Send Neighbor Request to: " + (to != null ? to.toString() : null) + " from: " + fromWhereInClient + " with filters: " + (TODOFilters != null ? TODOFilters.toString() : null),"NeighborService",0,"Neighbor",false,false,false);
         if(to == null && Config.useHomemadeFriendSelector())
         {
            sendRequest = new SendRequestObject("INVITE",friendsSelectorResponse,titleTID,messageTID,fromWhereInClient,titleTIDParam,messageTIDParam);
            currentGame.homeState.changeState(new FriendSelectorState(currentGame,sendRequest));
         }
         else
         {
            JavaScriptServices.callJavascript(createObject(ProjectManager.getText(titleTID,titleTIDParam),ProjectManager.getText(messageTID,messageTIDParam),to,Config.getPlatform(),null,fromWhereInClient),false);
         }
      }
      
      public static function sendNeighborRequestSelectFriends(titleTID:String, messageTID:String, fromWhereInClient:String, titleTIDParam:Array = null, messageTIDParam:Array = null, TODOFilters:Array = null) : void
      {
         sendNeighborRequest(titleTID,messageTID,null,fromWhereInClient,titleTIDParam,messageTIDParam,TODOFilters);
      }
      
      public static function friendsSelectorResponse(selectedList:String, sendRequest:SendRequestObject) : void
      {
         var inviteArray:Array = [];
         inviteArray.push(selectedList);
         JavaScriptServices.callJavascript(createObject(sendRequest.title,sendRequest.message,inviteArray,Config.getPlatform(),null,sendRequest.fromWhereInClient),false);
      }
      
      private static function createObject(title:String, message:String, to:Array, toPlatform:String, filters:Array, fromWhereInClient:String) : JavaScriptObject
      {
         var obj:RequestObject = new RequestObject(to != null ? to : null,filters != null ? filters : null,toPlatform,title,message,null);
         obj.type = 7;
         obj.crm_event_type = "Invite";
         obj.product = fromWhereInClient;
         return obj;
      }
      
      private static function callbackCatcher(msg:Message) : void
      {
         var _loc2_:* = null;
         if(msg.data)
         {
            if(Config.debugMode)
            {
               LogUtils.log("DEBUG: " + msg.data,"NeighborService",0,"Neighbor",false,false,false);
            }
            if(msg.data is String)
            {
               _loc2_ = JSON.parse(msg.data);
               if(_loc2_ != null)
               {
                  if(_loc2_.data != null && _loc2_.data.type == 7)
                  {
                     LogUtils.log("callbackCatcher data is as follows, use if needed","NeighborService",0,"Neighbor",false,false,false);
                     LogUtils.log(msg.data,"NeighborService",0,"Neighbor",false,false,false);
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
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(msg.data)
         {
            LogUtils.log(msg.data,null,0,"Neighbor");
            _loc5_ = JSON.parse(msg.data);
            if(_loc5_ != null)
            {
               if(_loc5_.data != null && _loc5_.data.type == 7)
               {
                  _loc2_ = _loc5_.to;
                  if(_loc2_ != null)
                  {
                     _loc3_ = _loc5_.request;
                     _loc4_ = _loc2_.toString();
                     notifyGameServerOfSendNeighborRequest(_loc3_,_loc4_,Config.getPlatform());
                  }
               }
            }
         }
      }
      
      private static function notifyGameServerOfSendNeighborRequest(requestID:String, recipientIDs:String, responsePlatformId:String) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         LogUtils.log("Send neighbor requestID:" + requestID + " to recipientIDs: " + recipientIDs + " responsePlatformId: " + responsePlatformId,"_NeighborService",0,"Neighbor",false,false,false);
         if(requestID != null && recipientIDs != null)
         {
            _loc5_ = {
               "request_id":requestID,
               "recipient_ids":recipientIDs,
               "recipients_platform":responsePlatformId
            };
            _loc4_ = new ServerRequest("SendNeighborRequest",_loc5_,false,notifyGameServerNeighborCallback);
            MessageCenter.sendEvent(_loc4_);
         }
         else
         {
            LogUtils.log("notifyGameServerNeighborAdd something is null","NeighborService",0,"Neighbor",false,false,true);
         }
      }
      
      private static function notifyGameServerNeighborCallback(response:ServerResponse) : void
      {
         LogUtils.log("addCallback","NeighborService",0,"Neighbor",false,false,true);
      }
      
      private static function accept(msg:Message) : void
      {
         LogUtils.log("Accepted neighbor request from: " + msg.data.senderID,"NeighborService",0,"Neighbor",false,false,false);
         var _loc3_:Object = {"sender_id":msg.data.senderID};
         var _loc2_:ServerRequest = new ServerRequest("AcceptNeighbor",_loc3_,false,acceptCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function acceptCallback(response:ServerResponse) : void
      {
         if(response.data && response.data.deleted_requests_count <= 0)
         {
            LogUtils.log("acceptCallback deleted requests number too low!","NeighborService",2,"Neighbor",false,false,false);
         }
         else
         {
            LogUtils.log("acceptCallback success","NeighborService",4,"Neighbor",false,false,false);
            currentGame.player.friends.changeFriendStatus(response.data.sender_id,"Neighbor");
            IHomeScreen(currentGame.homeState.screenHandler.screen).refreshFriends();
         }
      }
      
      private static function reject(msg:Message) : void
      {
         var _loc4_:RequestData = msg.data;
         var _loc3_:Object = {"sender_id":_loc4_.senderID};
         var _loc2_:ServerRequest = new ServerRequest("RejectNeighbor",_loc3_,false,rejectCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function rejectCallback(response:ServerResponse) : void
      {
         LogUtils.log("rejectCallback success","NeighborService",4,"Neighbor",false,false,false);
      }
      
      private static function cancel(msg:Message) : void
      {
         var _loc3_:Object = {"recipient_id":msg.data};
         var _loc2_:ServerRequest = new ServerRequest("CancelNeighbor",_loc3_,false,cancelCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function cancelCallback(response:ServerResponse) : void
      {
         LogUtils.log("cancelCallback success","NeighborService",4,"Neighbor",false,false,false);
         currentGame.player.friends.changeFriendStatus(response.data.neighbor_id,"NoNeighbor");
         if(currentGame.currentState && currentGame.currentState.screenHandler)
         {
            NeighborsScreen(currentGame.currentState.screenHandler.screen).refreshList();
         }
      }
      
      private static function remove(msg:Message) : void
      {
         var _loc3_:Object = {"neighbor_id":msg.data.data};
         var _loc2_:ServerRequest = new ServerRequest("RemoveNeighbor",_loc3_,false,removeCallback);
         MessageCenter.sendEvent(_loc2_);
      }
      
      private static function removeCallback(response:ServerResponse) : void
      {
         LogUtils.log("removeCallback success","NeighborService",4,"Neighbor",false,false,false);
         currentGame.player.friends.changeFriendStatus(response.data.neighbor_id,"NoNeighbor");
         if(currentGame.currentState && currentGame.currentState.screenHandler)
         {
            NeighborsScreen(currentGame.currentState.screenHandler.screen).refreshList();
         }
         IHomeScreen(currentGame.homeState.screenHandler.screen).refreshFriends();
      }
   }
}
