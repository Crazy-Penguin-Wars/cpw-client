package com.dchoc.ui.events
{
   import com.dchoc.ui.buttons.UIButton;
   
   public class UIButtonEvent extends UIEvent
   {
      public static const CLICKED_POST_CALLBACK:String = "clicked_post_callback";
      
      public static const CLICKED:String = "clicked";
      
      public static const DOWN:String = "down";
      
      public static const OUT:String = "out";
      
      public static const OVER:String = "over";
      
      private var button:UIButton;
      
      public function UIButtonEvent(param1:UIButton, param2:String, param3:Object = null)
      {
         super(param2,param3);
         this.button = param1;
      }
      
      public function getButton() : UIButton
      {
         return this.button;
      }
   }
}

