package tuxwars.player
{
   import com.dchoc.friends.Friend;
   
   public class TuxFriend extends Friend
   {
       
      
      private var _wornItemsContainer:WornItems;
      
      private var _inventory:Inventory;
      
      public function TuxFriend()
      {
         super();
         _inventory = new Inventory(this);
         _wornItemsContainer = new WornItems(this);
      }
      
      public function dispose() : void
      {
         _inventory.dispose();
         _inventory = null;
         _wornItemsContainer.dispose();
         _wornItemsContainer = null;
      }
      
      public function get inventory() : Inventory
      {
         return _inventory;
      }
      
      public function get wornItemsContainer() : WornItems
      {
         return _wornItemsContainer;
      }
   }
}
