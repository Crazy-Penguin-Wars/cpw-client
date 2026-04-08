package tuxwars.ui.containers.shop.container.tags
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.containers.shop.container.Container;
   import tuxwars.utils.*;
   
   public class ShopTag extends Container
   {
      private var _uiTextField:UIAutoTextField;
      
      public function ShopTag(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:String, param5:UIComponent = null, param6:Boolean = false)
      {
         super(param1,param2,param3,param5);
         param1.mouseEnabled = false;
         param1.mouseChildren = false;
         if(param1.Text)
         {
            if(!param6)
            {
               this._uiTextField = TuxUiUtils.createAutoTextField(param1.Text,param4);
            }
            else
            {
               this._uiTextField = TuxUiUtils.createAutoTextFieldWithText(param1.Text,param4);
            }
            this._uiTextField.setHorizontalAlignment(3);
         }
      }
      
      override public function dispose() : void
      {
         if(this._uiTextField)
         {
            this._uiTextField = null;
         }
         super.dispose();
      }
   }
}

