package com.dchoc.net
{
   import com.dchoc.messages.Message;
   import com.dchoc.utils.*;
   import flash.utils.*;
   
   public class ServerRequest extends Message
   {
      private var _serviceId:String;
      
      private var _buffered:Boolean;
      
      private var _callback:Function;
      
      private var _callId:String;
      
      private var _timeCreated:int;
      
      public function ServerRequest(param1:String, param2:Object = null, param3:Boolean = false, param4:Function = null)
      {
         var _loc5_:Object = !!param2 ? param2 : {};
         _loc5_.uid = Config.getUserId();
         super("SendRequest",_loc5_);
         this._serviceId = param1;
         this._buffered = param3;
         this._callback = param4;
         this._timeCreated = getTimer();
         if(param3 && param4 != null)
         {
            LogUtils.log("Both buffered flag and callback function are set.",this);
         }
      }
      
      public function get serviceId() : String
      {
         return this._serviceId;
      }
      
      public function set buffered(param1:Boolean) : void
      {
         this._buffered = param1;
      }
      
      public function get buffered() : Boolean
      {
         return this._buffered;
      }
      
      public function set callback(param1:Function) : void
      {
         this._callback = param1;
      }
      
      public function get callback() : Function
      {
         return this._callback;
      }
      
      public function get timeCreated() : int
      {
         return this._timeCreated;
      }
      
      public function hasCallback() : Boolean
      {
         return this._callback != null;
      }
      
      public function set callId(param1:String) : void
      {
         this._callId = param1;
      }
      
      public function get callId() : String
      {
         return this._callId;
      }
   }
}

