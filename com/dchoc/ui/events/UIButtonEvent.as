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
      
      public function UIButtonEvent(button:UIButton, type:String, parameter:Object = null)
      {
         super(type,parameter);
         this.button = button;
      }
      
      public function getButton() : UIButton
      {
         return button;
      }
   }
}
