package tuxwars.home.ui.screen.crafting.itemslot
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.Item;
   import tuxwars.items.data.ItemData;
   import tuxwars.net.messages.InventoryUpdatedMessage;
   import tuxwars.player.Player;
   
   public class IngredientContainers extends UIContainers
   {
      
      protected static const SHOW:String = "Slot_Default";
      
      protected static const DISABLED:String = "Slot_Disabled";
       
      
      private var player:Player;
      
      private var item:Item;
      
      public function IngredientContainers(slotClass:Class, design:MovieClip, recipe:ItemData, itemData:ItemData, parent:TuxUIScreen)
      {
         super();
         player = parent.tuxGame.player;
         item = player.inventory.getItem(itemData.id,true);
         add("Slot_Default",new slotClass(design.getChildByName("Slot_Default") as MovieClip,recipe,item,parent));
         add("Slot_Disabled",new slotClass(design.getChildByName("Slot_Disabled") as MovieClip,recipe,item,parent));
         setState();
         MessageCenter.addListener("InventoryUpdated",inventoryUpdated);
      }
      
      private function setState() : void
      {
         if(item.amount > 0)
         {
            show("Slot_Default");
         }
         else
         {
            show("Slot_Disabled");
         }
      }
      
      private function inventoryUpdated(event:InventoryUpdatedMessage) : void
      {
         if(event.item.id == item.id && event.player.id == player.id)
         {
            setState();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("InventoryUpdated",inventoryUpdated);
      }
   }
}
