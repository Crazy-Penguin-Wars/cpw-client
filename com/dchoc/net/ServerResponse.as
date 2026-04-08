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
      
      public function ServerResponse(param1:int, param2:String, param3:String, param4:Object, param5:String, param6:Boolean)
      {
         super("DataReceived",param4);
         this._responseCode = param1;
         this._serviceId = param2;
         this._callId = param3;
         this._error = param5;
         this._maintenanceMode = param6;
      }
      
      public function get responseCode() : int
      {
         return this._responseCode;
      }
      
      public function get serviceId() : String
      {
         return this._serviceId;
      }
      
      public function get callId() : String
      {
         return this._callId;
      }
      
      public function get error() : String
      {
         return this._error;
      }
      
      public function get maintenanceMode() : Boolean
      {
         return this._maintenanceMode;
      }
   }
}

