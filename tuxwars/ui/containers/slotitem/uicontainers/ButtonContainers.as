package tuxwars.ui.containers.slotitem.uicontainers
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.*;
   import tuxwars.battle.*;
   import tuxwars.battle.ui.screen.weaponselection.*;
   import tuxwars.items.Item;
   import tuxwars.net.messages.InventoryUpdatedMessage;
   import tuxwars.player.Player;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.ui.containers.slotitem.uicontainers.container.*;
   
   public class ButtonContainers extends UIContainers
   {
      private static const CONTAINER_BUTTONS:String = "Container_Buttons";
      
      public static const BUTTON_CASH:String = "Button";
      
      public static const BUTTON_COINS:String = "Button_Coins";
      
      public static const BUTTON_MEMBERSHIP:String = "Button_Membership";
      
      public static const BUTTON_UNLOCK:String = "Button_Unlock";
      
      private var _slotElement:SlotElement;
      
      public function ButtonContainers(param1:SlotElement)
      {
         super();
         this._slotElement = param1;
         var _loc2_:MovieClip = param1.getDesignMovieClip().getChildByName("Container_Buttons") as MovieClip;
         add("Button",new BuyButtonContainer(!!_loc2_.Button_Cash ? _loc2_.Button_Cash : _loc2_.Button,param1));
         add("Button_Coins",new BuyButtonContainer(_loc2_.Button_Coins,param1));
         add("Button_Membership",new MembershipButtonContainer(_loc2_.Button_Membership,param1));
         if(_loc2_.Button_Unlock)
         {
            add("Button_Unlock",new UnlockButtonContainer(_loc2_.Button_Unlock,param1));
         }
         this.showSlotItem(false);
         MessageCenter.addListener("InventoryUpdated",this.updateButtonState);
      }
      
      private function updateButtonState(param1:InventoryUpdatedMessage) : void
      {
         if(param1 == null || param1.item.id == this._slotElement.shopItem.id && param1.player.id == this._slotElement.game.player.id)
         {
            this.showSlotItem(true);
         }
      }
      
      private function showSlotItem(param1:Boolean) : void
      {
         param1 = false;
         var _loc2_:Player = this._slotElement.game.player;
         var _loc3_:Item = _loc2_.inventory.getItem(this._slotElement.shopItem.id);
         if(Boolean(getContainer("Button_Unlock")) && Boolean(this._slotElement.shopItem.isLevelLocked(_loc2_.level)))
         {
            show("Button_Unlock",false);
         }
         else if(Boolean(this._slotElement.shopItem.isVip) && !_loc2_.vipMembership.vip)
         {
            if(!BattleManager.isBattleInProgress())
            {
               show("Button_Membership",false);
            }
         }
         else if(this._slotElement.shopItem.priceObject && (this._slotElement.parent == null || !(this._slotElement.parent is WeaponSelectionScreen) || !_loc3_) && !BattleManager.isPracticeModeButNotTutorial())
         {
            if(this._slotElement.shopItem.priceObject.isPremium)
            {
               show("Button",false);
            }
            else
            {
               show("Button_Coins",false);
            }
         }
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("InventoryUpdated",this.updateButtonState);
         this._slotElement = null;
         super.dispose();
      }
      
      public function set enabled(param1:Boolean) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in getContainers())
         {
            if(_loc2_ is ButtonContainer)
            {
               ButtonContainer(_loc2_).setEnabledByPrice(param1);
            }
         }
      }
   }
}

