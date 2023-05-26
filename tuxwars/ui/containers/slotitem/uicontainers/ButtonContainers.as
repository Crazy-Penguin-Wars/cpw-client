package tuxwars.ui.containers.slotitem.uicontainers
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.ui.screen.weaponselection.WeaponSelectionScreen;
   import tuxwars.items.Item;
   import tuxwars.net.messages.InventoryUpdatedMessage;
   import tuxwars.player.Player;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.ui.containers.slotitem.uicontainers.container.ButtonContainer;
   import tuxwars.ui.containers.slotitem.uicontainers.container.BuyButtonContainer;
   import tuxwars.ui.containers.slotitem.uicontainers.container.MembershipButtonContainer;
   import tuxwars.ui.containers.slotitem.uicontainers.container.UnlockButtonContainer;
   
   public class ButtonContainers extends UIContainers
   {
      
      private static const CONTAINER_BUTTONS:String = "Container_Buttons";
      
      public static const BUTTON_CASH:String = "Button";
      
      public static const BUTTON_COINS:String = "Button_Coins";
      
      public static const BUTTON_MEMBERSHIP:String = "Button_Membership";
      
      public static const BUTTON_UNLOCK:String = "Button_Unlock";
       
      
      private var _slotElement:SlotElement;
      
      public function ButtonContainers(slotElement:SlotElement)
      {
         super();
         _slotElement = slotElement;
         var _loc2_:MovieClip = slotElement.getDesignMovieClip().getChildByName("Container_Buttons") as MovieClip;
         add("Button",new BuyButtonContainer(!!_loc2_.Button_Cash ? _loc2_.Button_Cash : _loc2_.Button,slotElement));
         add("Button_Coins",new BuyButtonContainer(_loc2_.Button_Coins,slotElement));
         add("Button_Membership",new MembershipButtonContainer(_loc2_.Button_Membership,slotElement));
         if(_loc2_.Button_Unlock)
         {
            add("Button_Unlock",new UnlockButtonContainer(_loc2_.Button_Unlock,slotElement));
         }
         showSlotItem(false);
         MessageCenter.addListener("InventoryUpdated",updateButtonState);
      }
      
      private function updateButtonState(msg:InventoryUpdatedMessage) : void
      {
         if(msg == null || msg.item.id == _slotElement.shopItem.id && msg.player.id == _slotElement.game.player.id)
         {
            showSlotItem(true);
         }
      }
      
      private function showSlotItem(useTransition:Boolean) : void
      {
         useTransition = false;
         var _loc2_:Player = _slotElement.game.player;
         var _loc3_:Item = _loc2_.inventory.getItem(_slotElement.shopItem.id);
         if(getContainer("Button_Unlock") && _slotElement.shopItem.isLevelLocked(_loc2_.level))
         {
            show("Button_Unlock",useTransition);
         }
         else if(_slotElement.shopItem.isVip && !_loc2_.vipMembership.vip)
         {
            if(!BattleManager.isBattleInProgress())
            {
               show("Button_Membership",useTransition);
            }
         }
         else if(_slotElement.shopItem.priceObject && (_slotElement.parent == null || !(_slotElement.parent is WeaponSelectionScreen) || !_loc3_) && !BattleManager.isPracticeModeButNotTutorial())
         {
            if(_slotElement.shopItem.priceObject.isPremium)
            {
               show("Button",useTransition);
            }
            else
            {
               show("Button_Coins",useTransition);
            }
         }
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("InventoryUpdated",updateButtonState);
         _slotElement = null;
         super.dispose();
      }
      
      public function set enabled(value:Boolean) : void
      {
         for each(var container in getContainers())
         {
            if(container is ButtonContainer)
            {
               ButtonContainer(container).setEnabledByPrice(value);
            }
         }
      }
   }
}
