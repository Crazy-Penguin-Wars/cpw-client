package tuxwars.home.ui.screen.crafting.itemslot
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.data.assets.TooltipsData;
   import tuxwars.events.IngameMoneyChangedMessage;
   import tuxwars.events.PremiumMoneyChangedMessage;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.Item;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.RecipeData;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.net.messages.InventoryUpdatedMessage;
   import tuxwars.net.messages.ShopItemMessage;
   import tuxwars.player.Player;
   import tuxwars.ui.tooltips.ItemBaseTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function IngredientSlot(design:MovieClip, recipe:RecipeData, item:Item, parent:TuxUIScreen)
      {
         super(design,parent);
         _item = item;
         _shopItem = ShopItemManager.getShopItemWithId(item.id);
         _recipe = recipe;
         _player = parent.tuxGame.player;
         _priceValue = item.priceInfo.priceObject.priceValue;
         _isPremium = item.priceInfo.priceObject.isPremium;
         DCUtils.replaceDisplayObject(getDesignMovieClip().getChildByName("Icon"),item.icon);
         updateAmountText();
         createButton();
         MessageCenter.addListener("InventoryUpdated",inventoryUpdated);
         if(buttonCash && buttonCoins)
         {
            MessageCenter.addListener("IngameMoneyChanged",inGameMoneyChanged);
            MessageCenter.addListener("PremiumMoneyChanged",premiumMoneyChanged);
         }
         design.addEventListener("mouseOver",mouseOver,false,0,true);
         design.addEventListener("mouseOut",mouseOut,false,0,true);
      }
      
      override public function dispose() : void
      {
         this._design.removeEventListener("mouseOver",mouseOver,false);
         this._design.removeEventListener("mouseOut",mouseOut,false);
         super.dispose();
         MessageCenter.removeListener("InventoryUpdated",inventoryUpdated);
         if(buttonCash && buttonCoins)
         {
            buttonCash.dispose();
            buttonCash = null;
            buttonCoins.dispose();
            buttonCoins = null;
            MessageCenter.removeListener("IngameMoneyChanged",inGameMoneyChanged);
            MessageCenter.removeListener("PremiumMoneyChanged",premiumMoneyChanged);
         }
      }
      
      protected function updateAmountText() : void
      {
         if(getDesignMovieClip().getChildByName("Text"))
         {
            TuxUiUtils.createAutoTextFieldWithText(getDesignMovieClip().getChildByName("Text") as TextField,_item.amount.toString());
         }
      }
      
      protected function createButton() : void
      {
         var buttonContainerMC:MovieClip = getDesignMovieClip().getChildByName("Container_Buttons") as MovieClip;
         buttonCash = TuxUiUtils.createButton(UIButton,buttonContainerMC,"Button",buyIngredient,"");
         buttonCash.setText(_priceValue.toString());
         buttonCoins = TuxUiUtils.createButton(UIButton,buttonContainerMC,"Button_Coins",buyIngredient,"");
         buttonCoins.setText(_priceValue.toString());
         buttonCash.setShowTransitions(false);
         buttonCash.setVisible(_isPremium);
         buttonCash.setShowTransitions(true);
         buttonCoins.setShowTransitions(false);
         buttonCoins.setVisible(!_isPremium);
         buttonCoins.setShowTransitions(true);
         updateInGameMoney(_player.ingameMoney);
         updatePremiumMoney(_player.premiumMoney);
      }
      
      private function updatePremiumMoney(money:int) : void
      {
         if(_isPremium && buttonCash)
         {
            buttonCash.setEnabled(money >= _priceValue);
         }
      }
      
      private function updateInGameMoney(money:int) : void
      {
         if(!_isPremium && buttonCoins)
         {
            buttonCoins.setEnabled(money >= _priceValue);
         }
      }
      
      public function buyIngredient(event:MouseEvent) : void
      {
         MessageCenter.sendEvent(new ShopItemMessage(ShopItemManager.getShopItemWithId(_item.id),this.parent as TuxUIScreen));
      }
      
      protected function hasItem() : Boolean
      {
         return _item.amount > 0;
      }
      
      protected function inventoryUpdated(event:InventoryUpdatedMessage) : void
      {
         if(event.item.id == _item.id && event.player.id == _player.id)
         {
            updateAmountText();
         }
      }
      
      private function premiumMoneyChanged(msg:PremiumMoneyChangedMessage) : void
      {
         updatePremiumMoney(msg.premiumMoney);
      }
      
      private function inGameMoneyChanged(msg:IngameMoneyChangedMessage) : void
      {
         updateInGameMoney(msg.ingameMoney);
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         if(_shopItem.itemData.type == "Weapon")
         {
            TooltipManager.showTooltip(new ItemBaseTooltip(_shopItem,TooltipsData.getWeaponTooltipGraphics(),(parent as TuxUIScreen).tuxGame),this._design);
         }
         else if(_shopItem.itemData.type == "Clothing")
         {
            TooltipManager.showTooltip(new ItemBaseTooltip(_shopItem,TooltipsData.getClothingTooltipGraphics(),(parent as TuxUIScreen).tuxGame),this._design);
         }
         else
         {
            TooltipManager.showTooltip(new ItemBaseTooltip(_shopItem,TooltipsData.getBoosterTooltipGraphics(),(parent as TuxUIScreen).tuxGame),this._design);
         }
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
