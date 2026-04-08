package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.items.BoosterItem;
   
   public class BoosterActivatedMessage extends Message
   {
      private var _boosterItem:BoosterItem;
      
      public function BoosterActivatedMessage(param1:String, param2:BoosterItem)
      {
         super("BoosterActivated",param1);
         this._boosterItem = param2;
      }
      
      public function get playerId() : String
      {
         return data;
      }
      
      public function get boosterItem() : BoosterItem
      {
         return this._boosterItem;
      }
   }
}

