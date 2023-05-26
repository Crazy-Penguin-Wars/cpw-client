package tuxwars.events
{
   import com.dchoc.messages.Message;
   
   public class ExpChangedMessage extends Message
   {
       
      
      private var _exp:int;
      
      private var _amount:int;
      
      public function ExpChangedMessage(exp:int, amount:int)
      {
         super("ExperienceChanged");
         _exp = exp;
         _amount = amount;
      }
      
      public function get exp() : int
      {
         return _exp;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
   }
}
