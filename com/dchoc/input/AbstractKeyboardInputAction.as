package com.dchoc.input
{
   public class AbstractKeyboardInputAction extends AbstractInputAction implements KeyboardInputAction
   {
      
      public static const ANY_KEY:int = -1;
       
      
      private var _keyCode:int;
      
      public function AbstractKeyboardInputAction(type:String, keyCode:int)
      {
         super(type);
         _keyCode = keyCode;
      }
      
      public function get keyCode() : int
      {
         return _keyCode;
      }
   }
}
