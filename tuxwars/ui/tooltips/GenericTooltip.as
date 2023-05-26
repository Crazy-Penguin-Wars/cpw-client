package tuxwars.ui.tooltips
{
   import com.dchoc.projectdata.ProjectManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.data.assets.TooltipsData;
   
   public class GenericTooltip extends TuxTooltip
   {
       
      
      private var tooltipBG:MovieClip;
      
      private var tooltip:TextField;
      
      private var _spaceHorizontal:int;
      
      private var _spaceVertital:int;
      
      public function GenericTooltip(tid:String)
      {
         super(TooltipsData.getGenericTooltipGraphics());
         text = ProjectManager.getText(tid);
      }
      
      override protected function createContents() : void
      {
         tooltip = getDesignMovieClip().Text;
         tooltipBG = getDesignMovieClip().Base;
         _spaceHorizontal = tooltipBG.width - tooltip.width;
         _spaceVertital = tooltipBG.height - tooltip.height;
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
         tooltipBG.height = tooltip.height + _spaceVertital;
         tooltipBG.width = tooltip.width + _spaceHorizontal;
         tooltip.y = tooltipBG.y - tooltip.height / 2;
      }
      
      public function set spaceHorizontal(space:int) : void
      {
         _spaceHorizontal = space;
      }
      
      public function set spaceVertital(space:int) : void
      {
         _spaceVertital = space;
      }
   }
}
