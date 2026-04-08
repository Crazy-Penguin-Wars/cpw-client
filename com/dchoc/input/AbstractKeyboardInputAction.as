package com.dchoc.input
{
   public class AbstractKeyboardInputAction extends AbstractInputAction implements KeyboardInputAction
   {
      public static const ANY_KEY:int = -1;
      
      private var _keyCode:int;
      
      public function AbstractKeyboardInputAction(param1:String, param2:int)
      {
         super(param1);
         this._keyCode = param2;
      }
      
      public function get keyCode() : int
      {
         return this._keyCode;
      }
   }
}

