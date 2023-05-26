package tuxwars.events
{
   import com.dchoc.messages.Message;
   
   public class TextIDMessage extends Message
   {
       
      
      public function TextIDMessage(tid:String)
      {
         super("TextID",tid);
      }
      
      public function get tid() : String
      {
         return data;
      }
   }
}
