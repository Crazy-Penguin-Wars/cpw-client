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
      
      public function UITooltip(design:DisplayObject)
      {
         super(design);
         tooltip = getDesignMovieClip().Text;
         tooltipBG = getDesignMovieClip().Base;
         spaceHorizontal = Number(tooltipBG.getWidth()) - tooltip.width;
         spaceVertital = Number(tooltipBG.getHeight()) - tooltip.height;
         setMouseEnabled(false);
         setMouseChildren(false);
         tooltip.autoSize = "center";
      }
      
      public function get text() : String
      {
         return tooltip.text;
      }
      
      public function set text(t:String) : void
      {
         tooltip.text = t;
         pack();
      }
      
      public function pack() : void
      {
         tooltipBG.height = tooltip.height + spaceVertital;
         tooltipBG.width = tooltip.width + spaceHorizontal;
         tooltip.y = tooltipBG.y - tooltip.height / 2;
      }
      
      public function setSpaceHorizontal(s:int) : void
      {
         spaceHorizontal = s;
      }
      
      public function setSpaceVertital(s:int) : void
      {
         spaceVertital = s;
      }
   }
}
