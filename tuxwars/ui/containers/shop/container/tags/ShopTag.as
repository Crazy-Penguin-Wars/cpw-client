package tuxwars.ui.containers.shop.container.tags
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.containers.shop.container.Container;
   import tuxwars.utils.TuxUiUtils;
   
   public class ShopTag extends Container
   {
       
      
      private var _uiTextField:UIAutoTextField;
      
      public function ShopTag(design:MovieClip, data:*, game:TuxWarsGame, tid:String, parent:UIComponent = null, useTidAsText:Boolean = false)
      {
         super(design,data,game,parent);
         design.mouseEnabled = false;
         design.mouseChildren = false;
         if(design.Text)
         {
            if(!useTidAsText)
            {
               _uiTextField = TuxUiUtils.createAutoTextField(design.Text,tid);
            }
            else
            {
               _uiTextField = TuxUiUtils.createAutoTextFieldWithText(design.Text,tid);
            }
            _uiTextField.setHorizontalAlignment(3);
         }
      }
      
      override public function dispose() : void
      {
         if(_uiTextField)
         {
            _uiTextField = null;
         }
         super.dispose();
      }
   }
}
