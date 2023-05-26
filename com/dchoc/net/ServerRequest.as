package com.dchoc.net
{
   import com.dchoc.messages.Message;
   import com.dchoc.utils.LogUtils;
   import flash.utils.getTimer;
   
   public class ServerRequest extends Message
   {
       
      
      private var _serviceId:String;
      
      private var _buffered:Boolean;
      
      private var _callback:Function;
      
      private var _callId:String;
      
      private var _timeCreated:int;
      
      public function ServerRequest(serviceId:String, params:Object = null, buffered:Boolean = false, callback:Function = null)
      {
         var _loc5_:Object = !!params ? params : {};
         _loc5_.uid = Config.getUserId();
         super("SendRequest",_loc5_);
         _serviceId = serviceId;
         _buffered = buffered;
         _callback = callback;
         _timeCreated = getTimer();
         if(buffered && callback != null)
         {
            LogUtils.log("Both buffered flag and callback function are set.",this);
         }
      }
      
      public function get serviceId() : String
      {
         return _serviceId;
      }
      
      public function set buffered(buffered:Boolean) : void
      {
         _buffered = buffered;
      }
      
      public function get buffered() : Boolean
      {
         return _buffered;
      }
      
      public function set callback(callback:Function) : void
      {
         _callback = callback;
      }
      
      public function get callback() : Function
      {
         return _callback;
      }
      
      public function get timeCreated() : int
      {
         return _timeCreated;
      }
      
      public function hasCallback() : Boolean
      {
         return _callback != null;
      }
      
      public function set callId(callId:String) : void
      {
         _callId = callId;
      }
      
      public function get callId() : String
      {
         return _callId;
      }
   }
}
