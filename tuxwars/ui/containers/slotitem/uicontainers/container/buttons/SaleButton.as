package tuxwars.ui.containers.slotitem.uicontainers.container.buttons
{
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.utils.TuxUiUtils;
   
   public class SaleButton extends ShopItemButton
   {
       
      
      private var _saleIcon:MovieClip;
      
      private var _saleText:UIAutoTextField;
      
      public function SaleButton(design:MovieClip, parameter:Object = null, useDefaultSound:Boolean = true, sounds:Object = null, customSoundStatus:Boolean = false)
      {
         super(design,parameter,useDefaultSound,sounds,customSoundStatus);
         var _loc6_:MovieClip = design.getChildByName("Icon_Sale") as MovieClip;
         if(_loc6_)
         {
            _saleText = TuxUiUtils.createAutoTextFieldWithText(_loc6_.Text,"");
            _saleIcon = _loc6_;
         }
      }
      
      override protected function setItemText() : void
      {
         super.setItemText();
         if(_saleIcon)
         {
            if(slotElement && shopItem && shopItem.priceObject && shopItem.priceObject.isSale)
            {
               _saleText.setText("-" + shopItem.priceObject.salePercentage + "%");
               _saleIcon.visible = true;
            }
            else
            {
               _saleIcon.visible = false;
            }
         }
      }
      
      override public function dispose() : void
      {
         _saleIcon = null;
         _saleText = null;
         super.dispose();
      }
   }
}
