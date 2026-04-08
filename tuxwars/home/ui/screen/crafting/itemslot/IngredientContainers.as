package tuxwars.home.ui.screen.crafting.itemslot
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.*;
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
      
      public function IngredientContainers(param1:Class, param2:MovieClip, param3:ItemData, param4:ItemData, param5:TuxUIScreen)
      {
         super();
         this.player = param5.tuxGame.player;
         this.item = this.player.inventory.getItem(param4.id,true);
         add("Slot_Default",new param1(param2.getChildByName("Slot_Default") as MovieClip,param3,this.item,param5));
         add("Slot_Disabled",new param1(param2.getChildByName("Slot_Disabled") as MovieClip,param3,this.item,param5));
         this.setState();
         MessageCenter.addListener("InventoryUpdated",this.inventoryUpdated);
      }
      
      private function setState() : void
      {
         if(this.item.amount > 0)
         {
            show("Slot_Default");
         }
         else
         {
            show("Slot_Disabled");
         }
      }
      
      private function inventoryUpdated(param1:InventoryUpdatedMessage) : void
      {
         if(param1.item.id == this.item.id && param1.player.id == this.player.id)
         {
            this.setState();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("InventoryUpdated",this.inventoryUpdated);
      }
   }
}

