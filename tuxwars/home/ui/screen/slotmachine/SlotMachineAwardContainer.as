package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import flash.text.*;
   import tuxwars.utils.*;
   
   public class SlotMachineAwardContainer extends UIContainer
   {
      private var _textField:UIAutoTextField;
      
      private var _text:String;
      
      public function SlotMachineAwardContainer(param1:MovieClip, param2:UIComponent = null)
      {
         super(param1,param2);
         this._textField = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text") as TextField,"");
      }
      
      public function setText(param1:String) : void
      {
         this._text = param1;
         this._textField.setText(param1);
      }
   }
}

