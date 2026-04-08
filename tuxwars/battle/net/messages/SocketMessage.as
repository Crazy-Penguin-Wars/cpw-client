package tuxwars.battle.net.messages
{
   import com.dchoc.messages.Message;
   
   public class SocketMessage extends Message
   {
      public static const MESSAGE:String = "SocketMessage";
      
      private var _message:String;
      
      private var _messageType:int;
      
      private var _id:String;
      
      public function SocketMessage(param1:Object)
      {
         super("SocketMessage",param1);
         this._id = param1.id;
         this._messageType = param1.t;
      }
      
      public function encode() : void
      {
         this._message = JSON.stringify(data);
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function allowsOtherMessage(param1:SocketMessage) : Boolean
      {
         return true;
      }
      
      public function sendLocally() : Boolean
      {
         return false;
      }
      
      public function get messageType() : int
      {
         return this._messageType;
      }
      
      public function get message() : String
      {
         return this._message;
      }
   }
}

