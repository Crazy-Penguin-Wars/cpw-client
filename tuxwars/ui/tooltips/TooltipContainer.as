package tuxwars.ui.tooltips
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.containers.shop.container.tags.ContainerTags;
   import tuxwars.utils.TuxUiUtils;
   
   public class TooltipContainer extends ContainerTags
   {
       
      
      private var _title:UIAutoTextField;
      
      private var _tooltipType:UIAutoTextField;
      
      private var _description:UIAutoTextField;
      
      private var _amount:UIAutoTextField;
      
      private var _cash:UIAutoTextField;
      
      private var _coins:UIAutoTextField;
      
      public function TooltipContainer(design:MovieClip, data:*, game:TuxWarsGame, parent:UIComponent = null)
      {
         super(design,data,game,parent);
         _title = TuxUiUtils.createAutoTextFieldWithText(design.Content.Text_Name,shopItem.name);
         _tooltipType = TuxUiUtils.createAutoTextFieldWithText(design.Content.Text_Type,shopItem.tooltipType);
         _description = TuxUiUtils.createAutoTextFieldWithText(design.Content.Text_Tip,shopItem.description);
         _amount = TuxUiUtils.createAutoTextFieldWithText(design.Content.Text_Number,"x" + shopItem.itemData.amountPurchased);
         if(shopItem.priceObject && shopItem.priceObject.priceValue != 0)
         {
            _cash = TuxUiUtils.createAutoTextFieldWithText(design.Content.Container_Prices.Price_Cash.Text,"" + shopItem.priceObject.priceValue);
            _coins = TuxUiUtils.createAutoTextFieldWithText(design.Content.Container_Prices.Price_Coins.Text,"" + shopItem.priceObject.priceValue);
            design.Content.Container_Prices.Price_Cash.visible = shopItem.priceObject.isPremium;
            design.Content.Container_Prices.Price_Coins.visible = !shopItem.priceObject.isPremium;
         }
         else
         {
            design.Content.Container_Prices.Price_Cash.visible = false;
            design.Content.Container_Prices.Price_Coins.visible = false;
         }
         design.Content.Container_Icon.addChild(shopItem.icon);
      }
      
      public function get amountTextField() : UIAutoTextField
      {
         return _amount;
      }
      
      override public function dispose() : void
      {
         _title = null;
         _tooltipType = null;
         _description = null;
         _amount = null;
         _cash = null;
         _coins = null;
         super.dispose();
      }
      
      protected function get shopItem() : ShopItem
      {
         return data[0] as ShopItem;
      }
   }
}
