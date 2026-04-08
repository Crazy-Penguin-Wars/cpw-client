package com.dchoc.net
{
   import com.dchoc.events.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   
   public class Server
   {
      private static var serverConnection:ServerConnection;
      
      private static const requestBuffer:Array = [];
      
      private static const responseBuffer:Array = [];
      
      public function Server()
      {
         super();
      }
      
      public static function init(param1:Class = null) : void
      {
         serverConnection = new (!!param1 ? param1 : ServerConnection)();
         MessageCenter.addListener("SendRequest",makeServerRequest);
         MessageCenter.addListener("DataReceived",dataReceived);
      }
      
      public static function dispose() : void
      {
         MessageCenter.removeListener("SendRequest",makeServerRequest);
         MessageCenter.removeListener("DataReceived",dataReceived);
         serverConnection = null;
         requestBuffer.splice(0,requestBuffer.length);
         responseBuffer.splice(0,responseBuffer.length);
      }
      
      private static function makeServerRequest(param1:ServerRequest) : void
      {
         requestBuffer.push(param1);
         var _loc2_:String = serverConnection.callService(param1.serviceId,param1.data);
         param1.callId = _loc2_;
      }
      
      private static function dataReceived(param1:ServerResponse) : void
      {
         var _loc2_:Function = null;
         var _loc3_:ServerRequest = findRequest(param1.callId);
         if(!_loc3_)
         {
            MessageCenter.sendEvent(new ErrorMessage("Request Not Found",param1.serviceId,"Request for call id: " + param1.serviceId + " was not found."));
            return;
         }
         if(param1.data.gameVersion && param1.data.gameVersion != Config.getVersion() && Boolean(Config.getVersion()))
         {
            MessageCenter.sendEvent(new Message("Wrong Version"));
         }
         if(param1.responseCode == 0)
         {
            if(_loc3_.buffered)
            {
               responseBuffer.push(param1);
            }
            else if(_loc3_.hasCallback())
            {
               _loc2_ = _loc3_.callback;
               _loc2_(param1);
            }
            MessageCenter.sendEvent(new ServerResponseReceivedMessage("ResponseReceived_",param1));
            MessageCenter.sendEvent(new ServerResponseReceivedMessage("ResponseReceived_" + param1.serviceId,param1));
         }
         else
         {
            MessageCenter.sendEvent(new ServerResponseReceivedMessage("ResponseError",param1));
         }
         removeRequest(_loc3_);
      }
      
      public static function findResponse(param1:String) : ServerResponse
      {
         return DCUtils.find(responseBuffer,"callId",param1);
      }
      
      public static function findNextResponse(param1:String) : ServerResponse
      {
         return DCUtils.find(responseBuffer,"serviceId",param1);
      }
      
      public static function removeResponse(param1:ServerResponse) : void
      {
         responseBuffer.splice(responseBuffer.indexOf(param1),1);
      }
      
      public static function findRequest(param1:String) : ServerRequest
      {
         return DCUtils.find(requestBuffer,"callId",param1);
      }
      
      public static function findNextRequest(param1:String) : ServerRequest
      {
         return DCUtils.find(requestBuffer,"serviceId",param1);
      }
      
      public static function removeRequest(param1:ServerRequest) : void
      {
         requestBuffer.splice(requestBuffer.indexOf(param1),1);
      }
   }
}

