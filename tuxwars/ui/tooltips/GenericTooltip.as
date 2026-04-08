package tuxwars.ui.tooltips
{
   import com.dchoc.projectdata.*;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.data.assets.*;
   
   public class GenericTooltip extends TuxTooltip
   {
      private var tooltipBG:MovieClip;
      
      private var tooltip:TextField;
      
      private var _spaceHorizontal:int;
      
      private var _spaceVertital:int;
      
      public function GenericTooltip(param1:String)
      {
         super(TooltipsData.getGenericTooltipGraphics());
         this.text = ProjectManager.getText(param1);
      }
      
      override protected function createContents() : void
      {
         this.tooltip = getDesignMovieClip().Text;
         this.tooltipBG = getDesignMovieClip().Base;
         this._spaceHorizontal = this.tooltipBG.width - this.tooltip.width;
         this._spaceVertital = this.tooltipBG.height - this.tooltip.height;
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
         this.tooltipBG.height = this.tooltip.height + this._spaceVertital;
         this.tooltipBG.width = this.tooltip.width + this._spaceHorizontal;
         this.tooltip.y = this.tooltipBG.y - this.tooltip.height / 2;
      }
      
      public function set spaceHorizontal(param1:int) : void
      {
         this._spaceHorizontal = param1;
      }
      
      public function set spaceVertital(param1:int) : void
      {
         this._spaceVertital = param1;
      }
   }
}

