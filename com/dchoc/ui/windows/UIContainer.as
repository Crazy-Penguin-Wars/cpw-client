package com.dchoc.ui.windows
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.base.UIStateComponent;
   import flash.display.MovieClip;
   
   public class UIContainer extends UIStateComponent
   {
      protected var parent:UIComponent;
      
      public function UIContainer(param1:MovieClip, param2:UIComponent = null)
      {
         super(param1);
         this.parent = param2;
         state = "Visible";
      }
      
      public function shown() : void
      {
      }
   }
}

