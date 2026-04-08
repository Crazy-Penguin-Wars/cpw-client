package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.*;
   import flash.display.MovieClip;
   import flash.text.*;
   
   public class SecondTextFieldButton extends UIButton
   {
      private var _spinButtonText:UIAutoTextField;
      
      private var _textSecond:String;
      
      private var _textSecondFieldLabel:String;
      
      public function SecondTextFieldButton(param1:MovieClip, param2:Object = null, param3:Boolean = true, param4:Object = null, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public function setTextSecond(param1:String, param2:String) : void
      {
         this._textSecond = param1;
         this._textSecondFieldLabel = param2;
         this._spinButtonText = new UIAutoTextField(getDesignMovieClip().getChildByName(param2) as TextField);
         this._spinButtonText.setText(this._textSecond);
      }
      
      override protected function updateTextField() : void
      {
         super.updateTextField();
         if(this._spinButtonText != null)
         {
            this._spinButtonText.setTextField(getDesignMovieClip().getChildByName(this._textSecondFieldLabel) as TextField);
            this._spinButtonText.setText(this._textSecond);
         }
      }
   }
}

