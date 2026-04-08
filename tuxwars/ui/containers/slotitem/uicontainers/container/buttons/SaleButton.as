package tuxwars.ui.containers.slotitem.uicontainers.container.buttons
{
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.*;
   import tuxwars.utils.*;
   
   public class SaleButton extends ShopItemButton
   {
      private var _saleIcon:MovieClip;
      
      private var _saleText:UIAutoTextField;
      
      public function SaleButton(param1:MovieClip, param2:Object = null, param3:Boolean = true, param4:Object = null, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
         var _loc6_:MovieClip = param1.getChildByName("Icon_Sale") as MovieClip;
         if(_loc6_)
         {
            this._saleText = TuxUiUtils.createAutoTextFieldWithText(_loc6_.Text,"");
            this._saleIcon = _loc6_;
         }
      }
      
      override protected function setItemText() : void
      {
         super.setItemText();
         if(this._saleIcon)
         {
            if(slotElement && shopItem && shopItem.priceObject && shopItem.priceObject.isSale)
            {
               this._saleText.setText("-" + shopItem.priceObject.salePercentage + "%");
               this._saleIcon.visible = true;
            }
            else
            {
               this._saleIcon.visible = false;
            }
         }
      }
      
      override public function dispose() : void
      {
         this._saleIcon = null;
         this._saleText = null;
         super.dispose();
      }
   }
}

