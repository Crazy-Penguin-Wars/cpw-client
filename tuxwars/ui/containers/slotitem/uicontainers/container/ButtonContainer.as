package tuxwars.ui.containers.slotitem.uicontainers.container
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.battle.BattleManager;
   import tuxwars.events.IngameMoneyChangedMessage;
   import tuxwars.events.PremiumMoneyChangedMessage;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.ui.containers.slotitem.uicontainers.container.buttons.SoldOutButton;
   
   public class ButtonContainer extends UIContainer
   {
       
      
      private var _button:SoldOutButton;
      
      public function ButtonContainer(design:MovieClip, parent:UIComponent = null)
      {
         super(design,parent);
         _button = new SoldOutButton(design,parent as SlotElement);
         _button.setMouseOverFunction(mouseOver);
         _button.setMouseOutFunction(mouseOut);
         _button.setMouseClickFunction(buttonPressed);
         MessageCenter.addListener("IngameMoneyChanged",inGameMoneyUpdated);
         MessageCenter.addListener("PremiumMoneyChanged",premiumMoneyUpdated);
         setEnabledByPrice(true);
      }
      
      override public function shown() : void
      {
         _button.setVisible(true);
         setEnabledByPrice(true);
      }
      
      override public function setVisible(value:Boolean) : void
      {
         super.setVisible(value);
         _button.setVisible(value);
         setEnabledByPrice(true);
      }
      
      private function inGameMoneyUpdated(event:IngameMoneyChangedMessage) : void
      {
         if(!shopItem.priceObject.isPremium)
         {
            setEnabledByPrice(true);
         }
      }
      
      private function premiumMoneyUpdated(event:PremiumMoneyChangedMessage) : void
      {
         if(shopItem.priceObject.isPremium)
         {
            setEnabledByPrice(true);
         }
      }
      
      public function setEnabledByPrice(value:Boolean) : void
      {
         if(value)
         {
            if(shopItem.priceObject)
            {
               if(slotElement.game.isInBattle() && BattleManager.isBattleInProgress())
               {
                  button.setEnabled(canAffordItem());
               }
               else
               {
                  button.setEnabled(value);
               }
            }
         }
         else
         {
            button.setEnabled(value);
         }
      }
      
      public function canAffordItem() : Boolean
      {
         if(shopItem.priceObject.isPremium)
         {
            return shopItem.priceObject.priceValue <= slotElement.game.player.premiumMoney;
         }
         return shopItem.priceObject.priceValue <= slotElement.game.player.ingameMoney;
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("IngameMoneyChanged",inGameMoneyUpdated);
         MessageCenter.removeListener("PremiumMoneyChanged",premiumMoneyUpdated);
         _button.dispose();
         _button = null;
         super.dispose();
      }
      
      protected function mouseOver(event:MouseEvent) : void
      {
         mouseOverExtraFunction();
         MessageCenter.sendMessage("ItemDetails",shopItem);
      }
      
      protected function mouseOut(event:MouseEvent) : void
      {
         mouseOutExtraFunction();
         MessageCenter.sendMessage("ItemDetails",null);
      }
      
      protected function mouseOverExtraFunction() : void
      {
      }
      
      protected function mouseOutExtraFunction() : void
      {
      }
      
      protected function set buttonText(value:String) : void
      {
         _button.setText(value);
      }
      
      public function get button() : UIButton
      {
         return _button;
      }
      
      protected function get slotElement() : SlotElement
      {
         return parent as SlotElement;
      }
      
      protected function get shopItem() : ShopItem
      {
         return slotElement.shopItem;
      }
      
      protected function buttonPressed(event:MouseEvent) : void
      {
         LogUtils.log("please override this!",this,2,"Warning");
      }
   }
}
