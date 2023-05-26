package com.dchoc.net
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.messages.ServerResponseReceivedMessage;
   import com.dchoc.utils.DCUtils;
   
   public class Server
   {
      
      private static var serverConnection:ServerConnection;
      
      private static const requestBuffer:Array = [];
      
      private static const responseBuffer:Array = [];
       
      
      public function Server()
      {
         super();
      }
      
      public static function init(serverConnectionClass:Class = null) : void
      {
         serverConnection = new (!!serverConnectionClass ? serverConnectionClass : ServerConnection)();
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
      
      private static function makeServerRequest(request:ServerRequest) : void
      {
         requestBuffer.push(request);
         var _loc2_:String = serverConnection.callService(request.serviceId,request.data);
         request.callId = _loc2_;
      }
      
      private static function dataReceived(response:ServerResponse) : void
      {
         var _loc3_:* = null;
         var _loc2_:ServerRequest = findRequest(response.callId);
         if(!_loc2_)
         {
            MessageCenter.sendEvent(new ErrorMessage("Request Not Found",response.serviceId,"Request for call id: " + response.serviceId + " was not found."));
            return;
         }
         if(response.data.gameVersion && response.data.gameVersion != Config.getVersion() && Config.getVersion())
         {
            MessageCenter.sendEvent(new Message("Wrong Version"));
         }
         if(response.responseCode == 0)
         {
            if(_loc2_.buffered)
            {
               responseBuffer.push(response);
            }
            else if(_loc2_.hasCallback())
            {
               _loc3_ = _loc2_.callback;
               _loc3_(response);
            }
            MessageCenter.sendEvent(new ServerResponseReceivedMessage("ResponseReceived_",response));
            MessageCenter.sendEvent(new ServerResponseReceivedMessage("ResponseReceived_" + response.serviceId,response));
         }
         else
         {
            MessageCenter.sendEvent(new ServerResponseReceivedMessage("ResponseError",response));
         }
         removeRequest(_loc2_);
      }
      
      public static function findResponse(callId:String) : ServerResponse
      {
         return DCUtils.find(responseBuffer,"callId",callId);
      }
      
      public static function findNextResponse(serviceId:String) : ServerResponse
      {
         return DCUtils.find(responseBuffer,"serviceId",serviceId);
      }
      
      public static function removeResponse(response:ServerResponse) : void
      {
         responseBuffer.splice(responseBuffer.indexOf(response),1);
      }
      
      public static function findRequest(callId:String) : ServerRequest
      {
         return DCUtils.find(requestBuffer,"callId",callId);
      }
      
      public static function findNextRequest(serviceId:String) : ServerRequest
      {
         return DCUtils.find(requestBuffer,"serviceId",serviceId);
      }
      
      public static function removeRequest(request:ServerRequest) : void
      {
         requestBuffer.splice(requestBuffer.indexOf(request),1);
      }
   }
}
