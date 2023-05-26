package tuxwars.battle.net.responses
{
   import com.dchoc.messages.Message;
   
   public class ActionResponse extends Message
   {
       
      
      private var _sendTime:int;
      
      private var _senderId:String;
      
      public function ActionResponse(data:Object)
      {
         var _loc2_:* = null;
         super("ActionResponse",data);
         if(data.hasOwnProperty("_t"))
         {
            _loc2_ = data._t.split("_");
            _sendTime = parseInt(_loc2_[0]);
            _senderId = _loc2_[1];
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
         return _senderId;
      }
      
      public function get sendTime() : int
      {
         return _sendTime;
      }
      
      public function get receivedTime() : int
      {
         return !!data.hasOwnProperty("_rt") ? data._rt : 0;
      }
      
      public function get handlingTime() : int
      {
         return !!data.hasOwnProperty("_ht") ? data._ht : 0;
      }
      
      public function get queueTime() : int
      {
         return !!data.hasOwnProperty("_qt") ? data._qt : 0;
      }
      
      public function get decodeTime() : int
      {
         return !!data.hasOwnProperty("_dt") ? data._dt : 0;
      }
   }
}
