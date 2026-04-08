package tuxwars.home.ui.screen.crafting.itemslot
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.data.assets.*;
   import tuxwars.events.IngameMoneyChangedMessage;
   import tuxwars.events.PremiumMoneyChangedMessage;
   import tuxwars.home.ui.screen.*;
   import tuxwars.items.Item;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.RecipeData;
   import tuxwars.items.managers.*;
   import tuxwars.net.messages.*;
   import tuxwars.player.Player;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class IngredientSlot extends UIContainer
   {
      protected static const TEXT:String = "Text";
      
      protected static const ICON:String = "Icon";
      
      protected static const BUTTON_CONTAINER:String = "Container_Buttons";
      
      protected static const BUTTON_CASH:String = "Button";
      
      protected static const BUTTON_COINS:String = "Button_Coins";
      
      protected var _item:Item;
      
      protected var _shopItem:ShopItem;
      
      private var buttonCash:UIButton;
      
      private var buttonCoins:UIButton;
      
      protected var _player:Player;
      
      private var _priceValue:int;
      
      private var _isPremium:Boolean;
      
      protected var _recipe:RecipeData;
      
      public function IngredientSlot(param1:MovieClip, param2:RecipeData, param3:Item, param4:TuxUIScreen)
      {
         super(param1,param4);
         this._item = param3;
         this._shopItem = ShopItemManager.getShopItemWithId(param3.id);
         this._recipe = param2;
         this._player = param4.tuxGame.player;
         this._priceValue = param3.priceInfo.priceObject.priceValue;
         this._isPremium = param3.priceInfo.priceObject.isPremium;
         DCUtils.replaceDisplayObject(getDesignMovieClip().getChildByName("Icon"),param3.icon);
         this.updateAmountText();
         this.createButton();
         MessageCenter.addListener("InventoryUpdated",this.inventoryUpdated);
         if(Boolean(this.buttonCash) && Boolean(this.buttonCoins))
         {
            MessageCenter.addListener("IngameMoneyChanged",this.inGameMoneyChanged);
            MessageCenter.addListener("PremiumMoneyChanged",this.premiumMoneyChanged);
         }
         param1.addEventListener("mouseOver",this.mouseOver,false,0,true);
         param1.addEventListener("mouseOut",this.mouseOut,false,0,true);
      }
      
      override public function dispose() : void
      {
         this._design.removeEventListener("mouseOver",this.mouseOver,false);
         this._design.removeEventListener("mouseOut",this.mouseOut,false);
         super.dispose();
         MessageCenter.removeListener("InventoryUpdated",this.inventoryUpdated);
         if(Boolean(this.buttonCash) && Boolean(this.buttonCoins))
         {
            this.buttonCash.dispose();
            this.buttonCash = null;
            this.buttonCoins.dispose();
            this.buttonCoins = null;
            MessageCenter.removeListener("IngameMoneyChanged",this.inGameMoneyChanged);
            MessageCenter.removeListener("PremiumMoneyChanged",this.premiumMoneyChanged);
         }
      }
      
      protected function updateAmountText() : void
      {
         if(getDesignMovieClip().getChildByName("Text"))
         {
            TuxUiUtils.createAutoTextFieldWithText(getDesignMovieClip().getChildByName("Text") as TextField,this._item.amount.toString());
         }
      }
      
      protected function createButton() : void
      {
         var _loc1_:MovieClip = getDesignMovieClip().getChildByName("Container_Buttons") as MovieClip;
         this.buttonCash = TuxUiUtils.createButton(UIButton,_loc1_,"Button",this.buyIngredient,"");
         this.buttonCash.setText(this._priceValue.toString());
         this.buttonCoins = TuxUiUtils.createButton(UIButton,_loc1_,"Button_Coins",this.buyIngredient,"");
         this.buttonCoins.setText(this._priceValue.toString());
         this.buttonCash.setShowTransitions(false);
         this.buttonCash.setVisible(this._isPremium);
         this.buttonCash.setShowTransitions(true);
         this.buttonCoins.setShowTransitions(false);
         this.buttonCoins.setVisible(!this._isPremium);
         this.buttonCoins.setShowTransitions(true);
         this.updateInGameMoney(this._player.ingameMoney);
         this.updatePremiumMoney(this._player.premiumMoney);
      }
      
      private function updatePremiumMoney(param1:int) : void
      {
         if(Boolean(this._isPremium) && Boolean(this.buttonCash))
         {
            this.buttonCash.setEnabled(param1 >= this._priceValue);
         }
      }
      
      private function updateInGameMoney(param1:int) : void
      {
         if(!this._isPremium && Boolean(this.buttonCoins))
         {
            this.buttonCoins.setEnabled(param1 >= this._priceValue);
         }
      }
      
      public function buyIngredient(param1:MouseEvent) : void
      {
         MessageCenter.sendEvent(new ShopItemMessage(ShopItemManager.getShopItemWithId(this._item.id),this.parent as TuxUIScreen));
      }
      
      protected function hasItem() : Boolean
      {
         return this._item.amount > 0;
      }
      
      protected function inventoryUpdated(param1:InventoryUpdatedMessage) : void
      {
         if(param1.item.id == this._item.id && param1.player.id == this._player.id)
         {
            this.updateAmountText();
         }
      }
      
      private function premiumMoneyChanged(param1:PremiumMoneyChangedMessage) : void
      {
         this.updatePremiumMoney(param1.premiumMoney);
      }
      
      private function inGameMoneyChanged(param1:IngameMoneyChangedMessage) : void
      {
         this.updateInGameMoney(param1.ingameMoney);
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         if(this._shopItem.itemData.type == "Weapon")
         {
            TooltipManager.showTooltip(new ItemBaseTooltip(this._shopItem,TooltipsData.getWeaponTooltipGraphics(),(parent as TuxUIScreen).tuxGame),this._design);
         }
         else if(this._shopItem.itemData.type == "Clothing")
         {
            TooltipManager.showTooltip(new ItemBaseTooltip(this._shopItem,TooltipsData.getClothingTooltipGraphics(),(parent as TuxUIScreen).tuxGame),this._design);
         }
         else
         {
            TooltipManager.showTooltip(new ItemBaseTooltip(this._shopItem,TooltipsData.getBoosterTooltipGraphics(),(parent as TuxUIScreen).tuxGame),this._design);
         }
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

