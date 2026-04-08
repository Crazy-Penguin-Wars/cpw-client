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
         this._inventory = new Inventory(this);
         this._wornItemsContainer = new WornItems(this);
      }
      
      public function dispose() : void
      {
         this._inventory.dispose();
         this._inventory = null;
         this._wornItemsContainer.dispose();
         this._wornItemsContainer = null;
      }
      
      public function get inventory() : Inventory
      {
         return this._inventory;
      }
      
      public function get wornItemsContainer() : WornItems
      {
         return this._wornItemsContainer;
      }
   }
}

