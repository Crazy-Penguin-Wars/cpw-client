package tuxwars.ui.containers.slotitem.uicontainers.container
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.battle.*;
   import tuxwars.events.IngameMoneyChangedMessage;
   import tuxwars.events.PremiumMoneyChangedMessage;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.containers.slotitem.*;
   import tuxwars.ui.containers.slotitem.uicontainers.container.buttons.*;
   
   public class ButtonContainer extends UIContainer
   {
      private var _button:SoldOutButton;
      
      public function ButtonContainer(param1:MovieClip, param2:UIComponent = null)
      {
         super(param1,param2);
         this._button = new SoldOutButton(param1,param2 as SlotElement);
         this._button.setMouseOverFunction(this.mouseOver);
         this._button.setMouseOutFunction(this.mouseOut);
         this._button.setMouseClickFunction(this.buttonPressed);
         MessageCenter.addListener("IngameMoneyChanged",this.inGameMoneyUpdated);
         MessageCenter.addListener("PremiumMoneyChanged",this.premiumMoneyUpdated);
         this.setEnabledByPrice(true);
      }
      
      override public function shown() : void
      {
         this._button.setVisible(true);
         this.setEnabledByPrice(true);
      }
      
      override public function setVisible(param1:Boolean) : void
      {
         super.setVisible(param1);
         this._button.setVisible(param1);
         this.setEnabledByPrice(true);
      }
      
      private function inGameMoneyUpdated(param1:IngameMoneyChangedMessage) : void
      {
         if(!this.shopItem.priceObject.isPremium)
         {
            this.setEnabledByPrice(true);
         }
      }
      
      private function premiumMoneyUpdated(param1:PremiumMoneyChangedMessage) : void
      {
         if(this.shopItem.priceObject.isPremium)
         {
            this.setEnabledByPrice(true);
         }
      }
      
      public function setEnabledByPrice(param1:Boolean) : void
      {
         if(param1)
         {
            if(this.shopItem.priceObject)
            {
               if(Boolean(this.slotElement.game.isInBattle()) && Boolean(BattleManager.isBattleInProgress()))
               {
                  this.button.setEnabled(this.canAffordItem());
               }
               else
               {
                  this.button.setEnabled(param1);
               }
            }
         }
         else
         {
            this.button.setEnabled(param1);
         }
      }
      
      public function canAffordItem() : Boolean
      {
         if(this.shopItem.priceObject.isPremium)
         {
            return this.shopItem.priceObject.priceValue <= this.slotElement.game.player.premiumMoney;
         }
         return this.shopItem.priceObject.priceValue <= this.slotElement.game.player.ingameMoney;
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("IngameMoneyChanged",this.inGameMoneyUpdated);
         MessageCenter.removeListener("PremiumMoneyChanged",this.premiumMoneyUpdated);
         this._button.dispose();
         this._button = null;
         super.dispose();
      }
      
      protected function mouseOver(param1:MouseEvent) : void
      {
         this.mouseOverExtraFunction();
         MessageCenter.sendMessage("ItemDetails",this.shopItem);
      }
      
      protected function mouseOut(param1:MouseEvent) : void
      {
         this.mouseOutExtraFunction();
         MessageCenter.sendMessage("ItemDetails",null);
      }
      
      protected function mouseOverExtraFunction() : void
      {
      }
      
      protected function mouseOutExtraFunction() : void
      {
      }
      
      protected function set buttonText(param1:String) : void
      {
         this._button.setText(param1);
      }
      
      public function get button() : UIButton
      {
         return this._button;
      }
      
      protected function get slotElement() : SlotElement
      {
         return parent as SlotElement;
      }
      
      protected function get shopItem() : ShopItem
      {
         return this.slotElement.shopItem;
      }
      
      protected function buttonPressed(param1:MouseEvent) : void
      {
         LogUtils.log("please override this!",this,2,"Warning");
      }
   }
}

