package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.utils.TuxUiUtils;
   
   public class SlotMachineAwardContainer extends UIContainer
   {
       
      
      private var _textField:UIAutoTextField;
      
      private var _text:String;
      
      public function SlotMachineAwardContainer(design:MovieClip, parent:UIComponent = null)
      {
         super(design,parent);
         _textField = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text") as TextField,"");
      }
      
      public function setText(value:String) : void
      {
         _text = value;
         _textField.setText(value);
      }
   }
}
