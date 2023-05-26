package tuxwars.battle.net.messages
{
   import com.dchoc.messages.Message;
   
   public class SocketMessage extends Message
   {
      
      public static const MESSAGE:String = "SocketMessage";
       
      
      private var _message:String;
      
      private var _messageType:int;
      
      private var _id:String;
      
      public function SocketMessage(data:Object)
      {
         super("SocketMessage",data);
         _id = data.id;
         _messageType = data.t;
      }
      
      public function encode() : void
      {
         _message = JSON.stringify(data);
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function allowsOtherMessage(other:SocketMessage) : Boolean
      {
         return true;
      }
      
      public function sendLocally() : Boolean
      {
         return false;
      }
      
      public function get messageType() : int
      {
         return _messageType;
      }
      
      public function get message() : String
      {
         return _message;
      }
   }
}
