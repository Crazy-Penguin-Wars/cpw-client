package com.dchoc.ui.spinner
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
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
      
      public function UISpinner(design:MovieClip, minValue:int = 0, maxValue:int = 1, increment:int = 1)
      {
         super(design);
         _minValue = minValue;
         _maxValue = maxValue;
         _increment = increment;
         textField.setTextField(design.Text);
         _scrollLeftButton = new UIButton(design.Button_Scroll_Left);
         _scrollLeftButton.setMouseClickFunction(leftClickCallback);
         _scrollRightButton = new UIButton(design.Button_Scroll_Right);
         _scrollRightButton.setMouseClickFunction(rightClickCallback);
      }
      
      override public function dispose() : void
      {
         _scrollLeftButton.dispose();
         _scrollLeftButton = null;
         _scrollRightButton.dispose();
         _scrollRightButton = null;
         super.dispose();
      }
      
      public function get currentValue() : int
      {
         return _currentValue;
      }
      
      public function set currentValue(value:int) : void
      {
         if(value < minValue)
         {
            value = minValue;
         }
         if(value > maxValue)
         {
            value = maxValue;
         }
         _currentValue = value;
         textField.setText(_currentValue.toString());
      }
      
      public function get minValue() : int
      {
         return _minValue;
      }
      
      public function set minValue(value:int) : void
      {
         _minValue = value;
         currentValue = currentValue;
      }
      
      public function get maxValue() : int
      {
         return _maxValue;
      }
      
      public function set maxValue(value:int) : void
      {
         _maxValue = value;
         currentValue = currentValue;
      }
      
      public function get increment() : int
      {
         return _increment;
      }
      
      public function set increment(value:int) : void
      {
         _increment = value;
      }
      
      private function rightClickCallback(event:MouseEvent) : void
      {
         currentValue += increment;
      }
      
      private function leftClickCallback(event:MouseEvent) : void
      {
         currentValue -= increment;
      }
   }
}
