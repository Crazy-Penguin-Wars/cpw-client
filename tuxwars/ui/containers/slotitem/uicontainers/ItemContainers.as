package tuxwars.ui.containers.slotitem.uicontainers
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.effects.BuyingAnimation;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.battle.BattleManager;
   import tuxwars.items.ShopItem;
   import tuxwars.net.messages.InventoryUpdatedMessage;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.ui.containers.slotitem.uicontainers.container.ItemContainer;
   
   public class ItemContainers extends UIContainers
   {
      
      public static const SLOT_USABLE:String = "Slot_Usable";
      
      public static const SLOT_USABLE_LOCKED:String = "Slot_Usable_Locked";
      
      public static const SLOT_UNUSABLE:String = "Slot_Unusable";
      
      public static const SLOT_UNUSABLE_LOCKED:String = "Slot_Unusable_Locked";
       
      
      private var _slotElement:SlotElement;
      
      public function ItemContainers(slotElement:SlotElement)
      {
         super();
         _slotElement = slotElement;
         var _loc2_:MovieClip = slotElement.getDesignMovieClip();
         add("Slot_Usable",new ItemContainer(_loc2_.Slot_Usable,this,slotElement));
         if(_loc2_.Slot_Usable_Locked)
         {
            add("Slot_Usable_Locked",new ItemContainer(_loc2_.Slot_Usable_Locked,this,slotElement));
         }
         add("Slot_Unusable",new ItemContainer(_loc2_.Slot_Unusable,this,slotElement));
         add("Slot_Unusable_Locked",new ItemContainer(_loc2_.Slot_Unusable_Locked,this,slotElement));
         showSlotButton(false);
         MessageCenter.addListener("InventoryUpdated",updateItemState);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("InventoryUpdated",updateItemState);
         _slotElement = null;
         super.dispose();
      }
      
      public function set enabled(value:Boolean) : void
      {
         for each(var container in getContainers())
         {
            container.button.setEnabled(value);
         }
      }
      
      private function updateItemState(msg:InventoryUpdatedMessage) : void
      {
         if(msg == null || msg.item.id == shopItem.id && msg.player.id == _slotElement.game.player.id)
         {
            showSlotButton(true);
         }
      }
      
      private function showSlotButton(useTransition:Boolean) : void
      {
         if(_slotElement.game.player.inventory.hasItem(shopItem.id,BattleManager.isPracticeMode()))
         {
            show(isShopItemLocked() ? "Slot_Unusable_Locked" : "Slot_Usable",useTransition);
         }
         else
         {
            show(isShopItemLocked() ? "Slot_Unusable_Locked" : "Slot_Unusable",useTransition);
         }
         if(useTransition)
         {
            BuyingAnimation.startAnimation(_slotElement.getDesignMovieClip(),shopItem.amountPurchased,shopItem.icon);
         }
      }
      
      private function isShopItemLocked() : Boolean
      {
         if(shopItem.type == "Trophy")
         {
            return !_slotElement.game.player.inventory.hasItem(shopItem.id,BattleManager.isPracticeMode());
         }
         return shopItem.isLevelLocked(_slotElement.game.player.level);
      }
      
      protected function get shopItem() : ShopItem
      {
         return _slotElement.shopItem;
      }
   }
}
