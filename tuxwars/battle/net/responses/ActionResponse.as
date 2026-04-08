package tuxwars.battle.net.responses
{
   import com.dchoc.messages.Message;
   
   public class ActionResponse extends Message
   {
      private var _sendTime:int;
      
      private var _senderId:String;
      
      public function ActionResponse(param1:Object)
      {
         var _loc2_:Array = null;
         super("ActionResponse",param1);
         if(param1.hasOwnProperty("_t"))
         {
            _loc2_ = param1._t.split("_");
            this._sendTime = parseInt(_loc2_[0]);
            this._senderId = _loc2_[1];
         }
      }
      
      public function get responseType() : int
      {
         return data.t;
      }
      
      public function get id() : String
      {
         return data.id;
      }
      
      public function get senderId() : String
      {
         return this._senderId;
      }
      
      public function get sendTime() : int
      {
         return this._sendTime;
      }
      
      public function get receivedTime() : int
      {
         return !!data.hasOwnProperty("_rt") ? int(data._rt) : 0;
      }
      
      public function get handlingTime() : int
      {
         return !!data.hasOwnProperty("_ht") ? int(data._ht) : 0;
      }
      
      public function get queueTime() : int
      {
         return !!data.hasOwnProperty("_qt") ? int(data._qt) : 0;
      }
      
      public function get decodeTime() : int
      {
         return !!data.hasOwnProperty("_dt") ? int(data._dt) : 0;
      }
   }
}

