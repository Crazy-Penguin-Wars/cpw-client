package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class SecondTextFieldButton extends UIButton
   {
       
      
      private var _spinButtonText:UIAutoTextField;
      
      private var _textSecond:String;
      
      private var _textSecondFieldLabel:String;
      
      public function SecondTextFieldButton(design:MovieClip, parameter:Object = null, useDefaultSound:Boolean = true, sounds:Object = null, customSoundStatus:Boolean = false)
      {
         super(design,parameter,useDefaultSound,sounds,customSoundStatus);
      }
      
      public function setTextSecond(text:String, textFieldLabel:String) : void
      {
         _textSecond = text;
         _textSecondFieldLabel = textFieldLabel;
         _spinButtonText = new UIAutoTextField(getDesignMovieClip().getChildByName(textFieldLabel) as TextField);
         _spinButtonText.setText(_textSecond);
      }
      
      override protected function updateTextField() : void
      {
         super.updateTextField();
         if(_spinButtonText != null)
         {
            _spinButtonText.setTextField(getDesignMovieClip().getChildByName(_textSecondFieldLabel) as TextField);
            _spinButtonText.setText(_textSecond);
         }
      }
   }
}
