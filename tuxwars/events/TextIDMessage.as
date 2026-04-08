package tuxwars.events
{
   import com.dchoc.messages.Message;
   
   public class TextIDMessage extends Message
   {
      public function TextIDMessage(param1:String)
      {
         super("TextID",param1);
      }
      
      public function get tid() : String
      {
         return data;
      }
   }
}

