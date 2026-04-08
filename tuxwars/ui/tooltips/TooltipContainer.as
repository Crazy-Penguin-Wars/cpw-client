package tuxwars.ui.tooltips
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.*;
   import tuxwars.ui.containers.shop.container.tags.ContainerTags;
   import tuxwars.utils.*;
   
   public class TooltipContainer extends ContainerTags
   {
      private var _title:UIAutoTextField;
      
      private var _tooltipType:UIAutoTextField;
      
      private var _description:UIAutoTextField;
      
      private var _amount:UIAutoTextField;
      
      private var _cash:UIAutoTextField;
      
      private var _coins:UIAutoTextField;
      
      public function TooltipContainer(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:UIComponent = null)
      {
         super(param1,param2,param3,param4);
         this._title = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Text_Name,this.shopItem.name);
         this._tooltipType = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Text_Type,this.shopItem.tooltipType);
         this._description = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Text_Tip,this.shopItem.description);
         this._amount = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Text_Number,"x" + this.shopItem.itemData.amountPurchased);
         if(Boolean(this.shopItem.priceObject) && this.shopItem.priceObject.priceValue != 0)
         {
            this._cash = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Container_Prices.Price_Cash.Text,"" + this.shopItem.priceObject.priceValue);
            this._coins = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Container_Prices.Price_Coins.Text,"" + this.shopItem.priceObject.priceValue);
            param1.Content.Container_Prices.Price_Cash.visible = this.shopItem.priceObject.isPremium;
            param1.Content.Container_Prices.Price_Coins.visible = !this.shopItem.priceObject.isPremium;
         }
         else
         {
            param1.Content.Container_Prices.Price_Cash.visible = false;
            param1.Content.Container_Prices.Price_Coins.visible = false;
         }
         param1.Content.Container_Icon.addChild(this.shopItem.icon);
      }
      
      public function get amountTextField() : UIAutoTextField
      {
         return this._amount;
      }
      
      override public function dispose() : void
      {
         this._title = null;
         this._tooltipType = null;
         this._description = null;
         this._amount = null;
         this._cash = null;
         this._coins = null;
         super.dispose();
      }
      
      protected function get shopItem() : ShopItem
      {
         return data[0] as ShopItem;
      }
   }
}

