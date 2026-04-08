package com.dchoc.ui.tooltips
{
   import com.dchoc.ui.base.UIStateComponent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class UITooltip extends UIStateComponent
   {
      private var tooltipBG:MovieClip;
      
      private var tooltip:TextField;
      
      private var spaceHorizontal:int;
      
      private var spaceVertital:int;
      
      public function UITooltip(param1:DisplayObject)
      {
         super(param1);
         this.tooltip = getDesignMovieClip().Text;
         this.tooltipBG = getDesignMovieClip().Base;
         this.spaceHorizontal = this.tooltipBG.getWidth() - this.tooltip.width;
         this.spaceVertital = this.tooltipBG.getHeight() - this.tooltip.height;
         setMouseEnabled(false);
         setMouseChildren(false);
         this.tooltip.autoSize = "center";
      }
      
      public function get text() : String
      {
         return this.tooltip.text;
      }
      
      public function set text(param1:String) : void
      {
         this.tooltip.text = param1;
         this.pack();
      }
      
      public function pack() : void
      {
         this.tooltipBG.height = this.tooltip.height + this.spaceVertital;
         this.tooltipBG.width = this.tooltip.width + this.spaceHorizontal;
         this.tooltip.y = this.tooltipBG.y - this.tooltip.height / 2;
      }
      
      public function setSpaceHorizontal(param1:int) : void
      {
         this.spaceHorizontal = param1;
      }
      
      public function setSpaceVertital(param1:int) : void
      {
         this.spaceVertital = param1;
      }
   }
}

