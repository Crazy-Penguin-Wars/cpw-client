package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.items.BoosterItem;
   
   public class BoosterActivatedMessage extends Message
   {
       
      
      private var _boosterItem:BoosterItem;
      
      public function BoosterActivatedMessage(playerId:String, boosterItem:BoosterItem)
      {
         super("BoosterActivated",playerId);
         _boosterItem = boosterItem;
      }
      
      public function get playerId() : String
      {
         return data;
      }
      
      public function get boosterItem() : BoosterItem
      {
         return _boosterItem;
      }
   }
}
