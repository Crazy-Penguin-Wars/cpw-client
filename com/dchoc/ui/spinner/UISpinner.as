package com.dchoc.ui.spinner
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class UISpinner extends UIComponent
   {
      private const textField:UIAutoTextField = new UIAutoTextField();
      
      private var _minValue:int;
      
      private var _maxValue:int;
      
      private var _increment:int;
      
      private var _currentValue:int;
      
      private var _scrollLeftButton:UIButton;
      
      private var _scrollRightButton:UIButton;
      
      public function UISpinner(param1:MovieClip, param2:int = 0, param3:int = 1, param4:int = 1)
      {
         super(param1);
         this._minValue = param2;
         this._maxValue = param3;
         this._increment = param4;
         this.textField.setTextField(param1.Text);
         this._scrollLeftButton = new UIButton(param1.Button_Scroll_Left);
         this._scrollLeftButton.setMouseClickFunction(this.leftClickCallback);
         this._scrollRightButton = new UIButton(param1.Button_Scroll_Right);
         this._scrollRightButton.setMouseClickFunction(this.rightClickCallback);
      }
      
      override public function dispose() : void
      {
         this._scrollLeftButton.dispose();
         this._scrollLeftButton = null;
         this._scrollRightButton.dispose();
         this._scrollRightButton = null;
         super.dispose();
      }
      
      public function get currentValue() : int
      {
         return this._currentValue;
      }
      
      public function set currentValue(param1:int) : void
      {
         if(param1 < this.minValue)
         {
            param1 = this.minValue;
         }
         if(param1 > this.maxValue)
         {
            param1 = this.maxValue;
         }
         this._currentValue = param1;
         this.textField.setText(this._currentValue.toString());
      }
      
      public function get minValue() : int
      {
         return this._minValue;
      }
      
      public function set minValue(param1:int) : void
      {
         this._minValue = param1;
         this.currentValue = this.currentValue;
      }
      
      public function get maxValue() : int
      {
         return this._maxValue;
      }
      
      public function set maxValue(param1:int) : void
      {
         this._maxValue = param1;
         this.currentValue = this.currentValue;
      }
      
      public function get increment() : int
      {
         return this._increment;
      }
      
      public function set increment(param1:int) : void
      {
         this._increment = param1;
      }
      
      private function rightClickCallback(param1:MouseEvent) : void
      {
         this.currentValue += this.increment;
      }
      
      private function leftClickCallback(param1:MouseEvent) : void
      {
         this.currentValue -= this.increment;
      }
   }
}

