package tuxwars.ui.containers.slotitem.uicontainers
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.effects.*;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.battle.*;
   import tuxwars.items.ShopItem;
   import tuxwars.net.messages.InventoryUpdatedMessage;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.ui.containers.slotitem.uicontainers.container.*;
   
   public class ItemContainers extends UIContainers
   {
      public static const SLOT_USABLE:String = "Slot_Usable";
      
      public static const SLOT_USABLE_LOCKED:String = "Slot_Usable_Locked";
      
      public static const SLOT_UNUSABLE:String = "Slot_Unusable";
      
      public static const SLOT_UNUSABLE_LOCKED:String = "Slot_Unusable_Locked";
      
      private var _slotElement:SlotElement;
      
      public function ItemContainers(param1:SlotElement)
      {
         super();
         this._slotElement = param1;
         var _loc2_:MovieClip = param1.getDesignMovieClip();
         add("Slot_Usable",new ItemContainer(_loc2_.Slot_Usable,this,param1));
         if(_loc2_.Slot_Usable_Locked)
         {
            add("Slot_Usable_Locked",new ItemContainer(_loc2_.Slot_Usable_Locked,this,param1));
         }
         add("Slot_Unusable",new ItemContainer(_loc2_.Slot_Unusable,this,param1));
         add("Slot_Unusable_Locked",new ItemContainer(_loc2_.Slot_Unusable_Locked,this,param1));
         this.showSlotButton(false);
         MessageCenter.addListener("InventoryUpdated",this.updateItemState);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("InventoryUpdated",this.updateItemState);
         this._slotElement = null;
         super.dispose();
      }
      
      public function set enabled(param1:Boolean) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in getContainers())
         {
            _loc2_.button.setEnabled(param1);
         }
      }
      
      private function updateItemState(param1:InventoryUpdatedMessage) : void
      {
         if(param1 == null || param1.item.id == this.shopItem.id && param1.player.id == this._slotElement.game.player.id)
         {
            this.showSlotButton(true);
         }
      }
      
      private function showSlotButton(param1:Boolean) : void
      {
         if(this._slotElement.game.player.inventory.hasItem(this.shopItem.id,BattleManager.isPracticeMode()))
         {
            show(!!this.isShopItemLocked() ? "Slot_Unusable_Locked" : "Slot_Usable",false);
         }
         else
         {
            show(!!this.isShopItemLocked() ? "Slot_Unusable_Locked" : "Slot_Unusable",false);
         }
         if(param1)
         {
            BuyingAnimation.startAnimation(this._slotElement.getDesignMovieClip(),this.shopItem.amountPurchased,this.shopItem.icon);
         }
      }
      
      private function isShopItemLocked() : Boolean
      {
         if(this.shopItem.type == "Trophy")
         {
            return !this._slotElement.game.player.inventory.hasItem(this.shopItem.id,BattleManager.isPracticeMode());
         }
         return this.shopItem.isLevelLocked(this._slotElement.game.player.level);
      }
      
      protected function get shopItem() : ShopItem
      {
         return this._slotElement.shopItem;
      }
   }
}

