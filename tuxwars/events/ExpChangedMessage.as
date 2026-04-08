package tuxwars.events
{
   import com.dchoc.messages.Message;
   
   public class ExpChangedMessage extends Message
   {
      private var _exp:int;
      
      private var _amount:int;
      
      public function ExpChangedMessage(param1:int, param2:int)
      {
         super("ExperienceChanged");
         this._exp = param1;
         this._amount = param2;
      }
      
      public function get exp() : int
      {
         return this._exp;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
   }
}

