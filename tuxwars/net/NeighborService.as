package tuxwars.net
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.friendselector.*;
   import tuxwars.home.ui.logic.inbox.RequestData;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.home.ui.screen.neighbors.*;
   import tuxwars.net.objects.*;
   
   public class NeighborService
   {
      private static var currentGame:TuxWarsGame;
      
      public static const CRM_TYPE_INVITE:String = "Invite";
      
      public static const PLATFORM_REQUEST_INVITE:int = 7;
      
      public function NeighborService()
      {
         super();
         throw new Error("NeighborService is a static class!");
      }
      
      public static function init(param1:TuxWarsGame) : void
      {
         LogUtils.log("Initialized NeighborService","NeighborService",0,"Neighbor",false,false,false);
         currentGame = param1;
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
      
      public static function dispose(param1:TuxWarsGame) : void
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
      
      public static function sendNeighborRequest(param1:String, param2:String, param3:Array, param4:String, param5:Array = null, param6:Array = null, param7:Array = null) : void
      {
         var _loc8_:SendRequestObject = null;
         LogUtils.log("Send Neighbor Request to: " + (param3 != null ? param3.toString() : null) + " from: " + param4 + " with filters: " + (param7 != null ? param7.toString() : null),"NeighborService",0,"Neighbor",false,false,false);
         if(param3 == null && Config.useHomemadeFriendSelector())
         {
            _loc8_ = new SendRequestObject("INVITE",friendsSelectorResponse,param1,param2,param4,param5,param6);
            currentGame.homeState.changeState(new FriendSelectorState(currentGame,_loc8_));
         }
         else
         {
            JavaScriptServices.callJavascript(createObject(ProjectManager.getText(param1,param5),ProjectManager.getText(param2,param6),param3,Config.getPlatform(),null,param4),false);
         }
      }
      
      public static function sendNeighborRequestSelectFriends(param1:String, param2:String, param3:String, param4:Array = null, param5:Array = null, param6:Array = null) : void
      {
         sendNeighborRequest(param1,param2,null,param3,param4,param5,param6);
      }
      
      public static function friendsSelectorResponse(param1:String, param2:SendRequestObject) : void
      {
         var _loc3_:Array = [];
         _loc3_.push(param1);
         JavaScriptServices.callJavascript(createObject(param2.title,param2.message,_loc3_,Config.getPlatform(),null,param2.fromWhereInClient),false);
      }
      
      private static function createObject(param1:String, param2:String, param3:Array, param4:String, param5:Array, param6:String) : JavaScriptObject
      {
         var _loc7_:RequestObject = new RequestObject(param3 != null ? param3 : null,param5 != null ? param5 : null,param4,param1,param2,null);
         _loc7_.type = 7;
         _loc7_.crm_event_type = "Invite";
         _loc7_.product = param6;
         return _loc7_;
      }
      
      private static function callbackCatcher(param1:Message) : void
      {
         var _loc2_:Object = null;
         if(param1.data)
         {
            if(Config.debugMode)
            {
               LogUtils.log("DEBUG: " + param1.data,"NeighborService",0,"Neighbor",false,false,false);
            }
            if(param1.data is String)
            {
               _loc2_ = JSON.parse(param1.data);
               if(_loc2_ != null)
               {
                  if(_loc2_.data != null && _loc2_.data.type == 7)
                  {
                     LogUtils.log("callbackCatcher data is as follows, use if needed","NeighborService",0,"Neighbor",false,false,false);
                     LogUtils.log(param1.data,"NeighborService",0,"Neighbor",false,false,false);
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
         if(param1.data)
         {
            LogUtils.log(param1.data,null,0,"Neighbor");
            _loc2_ = JSON.parse(param1.data);
            if(_loc2_ != null)
            {
               if(_loc2_.data != null && _loc2_.data.type == 7)
               {
                  _loc3_ = _loc2_.to;
                  if(_loc3_ != null)
                  {
                     _loc4_ = _loc2_.request;
                     _loc5_ = _loc3_.toString();
                     notifyGameServerOfSendNeighborRequest(_loc4_,_loc5_,Config.getPlatform());
                  }
               }
            }
         }
      }
      
      private static function notifyGameServerOfSendNeighborRequest(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:Object = null;
         var _loc5_:ServerRequest = null;
         LogUtils.log("Send neighbor requestID:" + param1 + " to recipientIDs: " + param2 + " responsePlatformId: " + param3,"_NeighborService",0,"Neighbor",false,false,false);
         if(param1 != null && param2 != null)
         {
            _loc4_ = {
               "request_id":param1,
               "recipient_ids":param2,
               "recipients_platform":param3
            };
            _loc5_ = new ServerRequest("SendNeighborRequest",_loc4_,false,notifyGameServerNeighborCallback);
            MessageCenter.sendEvent(_loc5_);
         }
         else
         {
            LogUtils.log("notifyGameServerNeighborAdd something is null","NeighborService",0,"Neighbor",false,false,true);
         }
      }
      
      private static function notifyGameServerNeighborCallback(param1:ServerResponse) : void
      {
         LogUtils.log("addCallback","NeighborService",0,"Neighbor",false,false,true);
      }
      
      private static function accept(param1:Message) : void
      {
         LogUtils.log("Accepted neighbor request from: " + param1.data.senderID,"NeighborService",0,"Neighbor",false,false,false);
         var _loc2_:Object = {"sender_id":param1.data.senderID};
         var _loc3_:ServerRequest = new ServerRequest("AcceptNeighbor",_loc2_,false,acceptCallback);
         MessageCenter.sendEvent(_loc3_);
      }
      
      private static function acceptCallback(param1:ServerResponse) : void
      {
         if(param1.data && param1.data.deleted_requests_count <= 0)
         {
            LogUtils.log("acceptCallback deleted requests number too low!","NeighborService",2,"Neighbor",false,false,false);
         }
         else
         {
            LogUtils.log("acceptCallback success","NeighborService",4,"Neighbor",false,false,false);
            currentGame.player.friends.changeFriendStatus(param1.data.sender_id,"Neighbor");
            IHomeScreen(currentGame.homeState.screenHandler.screen).refreshFriends();
         }
      }
      
      private static function reject(param1:Message) : void
      {
         var _loc2_:RequestData = param1.data;
         var _loc3_:Object = {"sender_id":_loc2_.senderID};
         var _loc4_:ServerRequest = new ServerRequest("RejectNeighbor",_loc3_,false,rejectCallback);
         MessageCenter.sendEvent(_loc4_);
      }
      
      private static function rejectCallback(param1:ServerResponse) : void
      {
         LogUtils.log("rejectCallback success","NeighborService",4,"Neighbor",false,false,false);
      }
      
      private static function cancel(param1:Message) : void
      {
         var _loc2_:Object = {"recipient_id":param1.data};
         var _loc3_:ServerRequest = new ServerRequest("CancelNeighbor",_loc2_,false,cancelCallback);
         MessageCenter.sendEvent(_loc3_);
      }
      
      private static function cancelCallback(param1:ServerResponse) : void
      {
         LogUtils.log("cancelCallback success","NeighborService",4,"Neighbor",false,false,false);
         currentGame.player.friends.changeFriendStatus(param1.data.neighbor_id,"NoNeighbor");
         if(Boolean(currentGame.currentState) && Boolean(currentGame.currentState.screenHandler))
         {
            NeighborsScreen(currentGame.currentState.screenHandler.screen).refreshList();
         }
      }
      
      private static function remove(param1:Message) : void
      {
         var _loc2_:Object = {"neighbor_id":param1.data.data};
         var _loc3_:ServerRequest = new ServerRequest("RemoveNeighbor",_loc2_,false,removeCallback);
         MessageCenter.sendEvent(_loc3_);
      }
      
      private static function removeCallback(param1:ServerResponse) : void
      {
         LogUtils.log("removeCallback success","NeighborService",4,"Neighbor",false,false,false);
         currentGame.player.friends.changeFriendStatus(param1.data.neighbor_id,"NoNeighbor");
         if(Boolean(currentGame.currentState) && Boolean(currentGame.currentState.screenHandler))
         {
            NeighborsScreen(currentGame.currentState.screenHandler.screen).refreshList();
         }
         IHomeScreen(currentGame.homeState.screenHandler.screen).refreshFriends();
      }
   }
}

