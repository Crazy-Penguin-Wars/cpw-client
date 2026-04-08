package tuxwars.ui.containers.slotitem.uicontainers.container
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.battle.*;
   import tuxwars.data.*;
   import tuxwars.items.*;
   import tuxwars.net.messages.*;
   import tuxwars.ui.containers.slotitem.*;
   import tuxwars.ui.containers.slotitem.uicontainers.ItemContainers;
   import tuxwars.ui.containers.slotitem.uicontainers.container.buttons.*;
   
   public class ItemContainer extends UIContainer
   {
      private var _lockButton:LockButton;
      
      private var _itemContainers:ItemContainers;
      
      public function ItemContainer(param1:MovieClip, param2:ItemContainers, param3:UIComponent = null)
      {
         super(param1,param3);
         this._itemContainers = param2;
         this._lockButton = new LockButton(param1);
         this._lockButton.setSlotElement(this.slotElement);
         this._lockButton.setMouseOverFunction(this.mouseOver);
         this._lockButton.setMouseOutFunction(this.mouseOut);
         this._lockButton.setMouseClickFunction(this.mouseClick);
         this.updateAmount(null);
         this.updateEquipped(null);
         MessageCenter.addListener("InventoryUpdated",this.updateAmount);
         MessageCenter.addListener("WornItemsUpdated",this.updateEquipped);
      }
      
      override public function dispose() : void
      {
         this._lockButton.dispose();
         this._lockButton = null;
         MessageCenter.removeListener("InventoryUpdated",this.updateAmount);
         MessageCenter.removeListener("WornItemsUpdated",this.updateEquipped);
         MessageCenter.removeListener("ItemEquipped",this.enableButton);
         MessageCenter.removeListener("ItemUnEquipped",this.enableButton);
         this._itemContainers = null;
         super.dispose();
      }
      
      public function get button() : LockButton
      {
         return this._lockButton;
      }
      
      override public function shown() : void
      {
         this._lockButton.setEnabled(true);
         this.updateEquipped(null);
      }
      
      override public function setVisible(param1:Boolean) : void
      {
         super.setVisible(param1);
         if(!this._itemContainers.isLoop())
         {
            this._lockButton.setVisible(param1);
            this.updateEquipped(null);
         }
      }
      
      protected function mouseClick(param1:MouseEvent) : void
      {
         var _loc2_:ClothingItem = null;
         var _loc3_:SoundReference = null;
         if(this.slotElement.game.player.inventory.hasItem(this.shopItem.id,BattleManager.isPracticeMode()))
         {
            _loc2_ = this.slotElement.game.player.inventory.getItem(this.shopItem.id,true) as ClothingItem;
            if(_loc2_ is ClothingItem)
            {
               _loc3_ = Sounds.getSoundReference("Clothes_2");
               if(_loc3_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType(),"PlaySound"));
               }
               this.setButtonDisabled();
               MessageCenter.addListener("ItemEquipped",this.enableButton);
               MessageCenter.addListener("ItemUnEquipped",this.enableButton);
            }
            MessageCenter.sendMessage("ItemSelected",this.shopItem);
         }
      }
      
      protected function mouseOver(param1:MouseEvent) : void
      {
         var _loc2_:ClothingItem = null;
         MessageCenter.sendMessage("ItemDetails",this.shopItem);
         var _loc3_:ClothingItem = this.slotElement.game.player.inventory.getItem(this.shopItem.id,true) as ClothingItem;
         if(_loc3_ is ClothingItem)
         {
            _loc2_ = this.slotElement.game.player.wornItemsContainer.getWornItemInSlot(_loc3_.slot);
            if(_loc2_)
            {
               MessageCenter.sendEvent(new WornItemsUpdatedMessage(this.slotElement.game.player,_loc2_,"ItemUnWearPreview"));
            }
            MessageCenter.sendEvent(new WornItemsUpdatedMessage(this.slotElement.game.player,_loc3_,"ItemWearPreview","over"));
         }
      }
      
      protected function mouseOut(param1:MouseEvent) : void
      {
         var _loc2_:ClothingItem = null;
         MessageCenter.sendMessage("ItemDetails",null);
         this.updateEquipped(null);
         var _loc3_:ClothingItem = this.slotElement.game.player.inventory.getItem(this.shopItem.id,true) as ClothingItem;
         if(_loc3_ is ClothingItem)
         {
            MessageCenter.sendEvent(new WornItemsUpdatedMessage(this.slotElement.game.player,_loc3_,"ItemUnWearPreview","out"));
            _loc2_ = this.slotElement.game.player.wornItemsContainer.getWornItemInSlot(_loc3_.slot);
            if(_loc2_)
            {
               MessageCenter.sendEvent(new WornItemsUpdatedMessage(this.slotElement.game.player,_loc2_,"ItemWearPreview"));
            }
         }
      }
      
      private function updateEquipped(param1:WornItemsUpdatedMessage) : void
      {
         if(param1 && (param1.wearEvent == "ItemUnWearPreview" || param1.wearEvent == "ItemWearPreview") && param1.mouseEvent == null)
         {
            return;
         }
         if(param1 == null || param1.shopItem.id == this.shopItem.id || this._lockButton.getCurrentAnimation() != "Visible")
         {
            if(this.slotElement.game.player.wornItemsContainer.isWearingItem(this.shopItem.id))
            {
               if(param1 != null && param1.shopItem.id == this.shopItem.id && param1.mouseEvent == "over")
               {
                  this._lockButton.setState("Selecteddown");
               }
               else
               {
                  this._lockButton.setState("Selected");
               }
            }
            else if(Boolean(this._lockButton.isState("Selected")) || Boolean(this._lockButton.isState("Selecteddown")))
            {
               this._lockButton.setState("Visible");
            }
         }
      }
      
      private function updateAmount(param1:InventoryUpdatedMessage) : void
      {
         if(param1 == null || param1.item.id == this.shopItem.id && param1.player.id == this.slotElement.game.player.id)
         {
            if(Boolean(this.shopItem.showAmount) && Boolean(this.slotElement.game.player.inventory.hasItem(this.shopItem.id,BattleManager.isPracticeModeButNotTutorial())))
            {
               if(!BattleManager.isPracticeModeButNotTutorial())
               {
                  this._lockButton.setText(this.slotElement.game.player.inventory.getItem(this.shopItem.id,BattleManager.isPracticeModeButNotTutorial()).amount.toString());
               }
               else
               {
                  this._lockButton.setText(ProjectManager.getText("DEFAULT_WEAPON_COUNT"));
               }
               if(this._itemContainers.getCurrentContainerId())
               {
                  this._itemContainers.show(this._itemContainers.getCurrentContainerId(),true,true);
               }
            }
            else
            {
               this._lockButton.setText("");
            }
         }
      }
      
      protected function get slotElement() : SlotElement
      {
         return parent as SlotElement;
      }
      
      protected function get shopItem() : ShopItem
      {
         return this.slotElement.shopItem;
      }
      
      private function enableButton(param1:Message) : void
      {
         this.setButtonEnabled();
         MessageCenter.removeListener("ItemEquipped",this.enableButton);
         MessageCenter.removeListener("ItemUnEquipped",this.enableButton);
         this.updateEquipped(null);
      }
      
      private function setButtonDisabled() : void
      {
         this._lockButton.setEnabled(false);
      }
      
      private function setButtonEnabled() : void
      {
         this._lockButton.setEnabled(true);
      }
   }
}

