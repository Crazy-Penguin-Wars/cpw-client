package tuxwars.ui.containers.slotitem.uicontainers.container
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.battle.BattleManager;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.items.ClothingItem;
   import tuxwars.items.ShopItem;
   import tuxwars.net.messages.InventoryUpdatedMessage;
   import tuxwars.net.messages.WornItemsUpdatedMessage;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.ui.containers.slotitem.uicontainers.ItemContainers;
   import tuxwars.ui.containers.slotitem.uicontainers.container.buttons.LockButton;
   
   public class ItemContainer extends UIContainer
   {
       
      
      private var _lockButton:LockButton;
      
      private var _itemContainers:ItemContainers;
      
      public function ItemContainer(design:MovieClip, itemContainers:ItemContainers, parent:UIComponent = null)
      {
         super(design,parent);
         _itemContainers = itemContainers;
         _lockButton = new LockButton(design);
         _lockButton.setSlotElement(slotElement);
         _lockButton.setMouseOverFunction(mouseOver);
         _lockButton.setMouseOutFunction(mouseOut);
         _lockButton.setMouseClickFunction(mouseClick);
         updateAmount(null);
         updateEquipped(null);
         MessageCenter.addListener("InventoryUpdated",updateAmount);
         MessageCenter.addListener("WornItemsUpdated",updateEquipped);
      }
      
      override public function dispose() : void
      {
         _lockButton.dispose();
         _lockButton = null;
         MessageCenter.removeListener("InventoryUpdated",updateAmount);
         MessageCenter.removeListener("WornItemsUpdated",updateEquipped);
         MessageCenter.removeListener("ItemEquipped",enableButton);
         MessageCenter.removeListener("ItemUnEquipped",enableButton);
         _itemContainers = null;
         super.dispose();
      }
      
      public function get button() : LockButton
      {
         return _lockButton;
      }
      
      override public function shown() : void
      {
         _lockButton.setEnabled(true);
         updateEquipped(null);
      }
      
      override public function setVisible(value:Boolean) : void
      {
         super.setVisible(value);
         if(!_itemContainers.isLoop())
         {
            _lockButton.setVisible(value);
            updateEquipped(null);
         }
      }
      
      protected function mouseClick(event:MouseEvent) : void
      {
         var clothingItemData:* = null;
         var _loc2_:* = null;
         if(slotElement.game.player.inventory.hasItem(shopItem.id,BattleManager.isPracticeMode()))
         {
            clothingItemData = slotElement.game.player.inventory.getItem(shopItem.id,true) as ClothingItem;
            if(clothingItemData is ClothingItem)
            {
               _loc2_ = Sounds.getSoundReference("Clothes_2");
               if(_loc2_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
               }
               setButtonDisabled();
               MessageCenter.addListener("ItemEquipped",enableButton);
               MessageCenter.addListener("ItemUnEquipped",enableButton);
            }
            MessageCenter.sendMessage("ItemSelected",shopItem);
         }
      }
      
      protected function mouseOver(event:MouseEvent) : void
      {
         var currentWornItem:* = null;
         MessageCenter.sendMessage("ItemDetails",shopItem);
         var previewItemData:ClothingItem = slotElement.game.player.inventory.getItem(shopItem.id,true) as ClothingItem;
         if(previewItemData is ClothingItem)
         {
            currentWornItem = slotElement.game.player.wornItemsContainer.getWornItemInSlot(previewItemData.slot);
            if(currentWornItem)
            {
               MessageCenter.sendEvent(new WornItemsUpdatedMessage(slotElement.game.player,currentWornItem,"ItemUnWearPreview"));
            }
            MessageCenter.sendEvent(new WornItemsUpdatedMessage(slotElement.game.player,previewItemData,"ItemWearPreview","over"));
         }
      }
      
      protected function mouseOut(event:MouseEvent) : void
      {
         var _loc3_:* = null;
         MessageCenter.sendMessage("ItemDetails",null);
         updateEquipped(null);
         var previewItemData:ClothingItem = slotElement.game.player.inventory.getItem(shopItem.id,true) as ClothingItem;
         if(previewItemData is ClothingItem)
         {
            MessageCenter.sendEvent(new WornItemsUpdatedMessage(slotElement.game.player,previewItemData,"ItemUnWearPreview","out"));
            _loc3_ = slotElement.game.player.wornItemsContainer.getWornItemInSlot(previewItemData.slot);
            if(_loc3_)
            {
               MessageCenter.sendEvent(new WornItemsUpdatedMessage(slotElement.game.player,_loc3_,"ItemWearPreview"));
            }
         }
      }
      
      private function updateEquipped(msg:WornItemsUpdatedMessage) : void
      {
         if(msg && (msg.wearEvent == "ItemUnWearPreview" || msg.wearEvent == "ItemWearPreview") && msg.mouseEvent == null)
         {
            return;
         }
         if(msg == null || msg.shopItem.id == shopItem.id || _lockButton.getCurrentAnimation() != "Visible")
         {
            if(slotElement.game.player.wornItemsContainer.isWearingItem(shopItem.id))
            {
               if(msg != null && msg.shopItem.id == shopItem.id && msg.mouseEvent == "over")
               {
                  _lockButton.setState("Selecteddown");
               }
               else
               {
                  _lockButton.setState("Selected");
               }
            }
            else if(_lockButton.isState("Selected") || _lockButton.isState("Selecteddown"))
            {
               _lockButton.setState("Visible");
            }
         }
      }
      
      private function updateAmount(msg:InventoryUpdatedMessage) : void
      {
         if(msg == null || msg.item.id == shopItem.id && msg.player.id == slotElement.game.player.id)
         {
            if(shopItem.showAmount && slotElement.game.player.inventory.hasItem(shopItem.id,BattleManager.isPracticeModeButNotTutorial()))
            {
               if(!BattleManager.isPracticeModeButNotTutorial())
               {
                  _lockButton.setText(slotElement.game.player.inventory.getItem(shopItem.id,BattleManager.isPracticeModeButNotTutorial()).amount.toString());
               }
               else
               {
                  _lockButton.setText(ProjectManager.getText("DEFAULT_WEAPON_COUNT"));
               }
               if(_itemContainers.getCurrentContainerId())
               {
                  _itemContainers.show(_itemContainers.getCurrentContainerId(),true,true);
               }
            }
            else
            {
               _lockButton.setText("");
            }
         }
      }
      
      protected function get slotElement() : SlotElement
      {
         return parent as SlotElement;
      }
      
      protected function get shopItem() : ShopItem
      {
         return slotElement.shopItem;
      }
      
      private function enableButton(msg:Message) : void
      {
         setButtonEnabled();
         MessageCenter.removeListener("ItemEquipped",enableButton);
         MessageCenter.removeListener("ItemUnEquipped",enableButton);
         updateEquipped(null);
      }
      
      private function setButtonDisabled() : void
      {
         _lockButton.setEnabled(false);
      }
      
      private function setButtonEnabled() : void
      {
         _lockButton.setEnabled(true);
      }
   }
}
