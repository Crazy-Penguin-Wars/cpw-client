package com.dchoc.ui.windows
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.base.UIStateComponent;
   import flash.display.MovieClip;
   
   public class UIContainer extends UIStateComponent
   {
       
      
      protected var parent:UIComponent;
      
      public function UIContainer(design:MovieClip, parent:UIComponent = null)
      {
         super(design);
         this.parent = parent;
         state = "Visible";
      }
      
      public function shown() : void
      {
      }
   }
}
