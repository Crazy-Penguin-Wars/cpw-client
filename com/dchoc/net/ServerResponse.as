package com.dchoc.net
{
   import com.dchoc.messages.Message;
   
   public class ServerResponse extends Message
   {
       
      
      private var _responseCode:int;
      
      private var _serviceId:String;
      
      private var _error:String;
      
      private var _maintenanceMode:Boolean;
      
      private var _callId:String;
      
      public function ServerResponse(responseCode:int, serviceId:String, callId:String, data:Object, error:String, maintenanceMode:Boolean)
      {
         super("DataReceived",data);
         _responseCode = responseCode;
         _serviceId = serviceId;
         _callId = callId;
         _error = error;
         _maintenanceMode = maintenanceMode;
      }
      
      public function get responseCode() : int
      {
         return _responseCode;
      }
      
      public function get serviceId() : String
      {
         return _serviceId;
      }
      
      public function get callId() : String
      {
         return _callId;
      }
      
      public function get error() : String
      {
         return _error;
      }
      
      public function get maintenanceMode() : Boolean
      {
         return _maintenanceMode;
      }
   }
}
