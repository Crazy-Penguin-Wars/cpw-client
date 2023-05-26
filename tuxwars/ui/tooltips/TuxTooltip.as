package tuxwars.ui.tooltips
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.base.UIStateComponent;
   
   public class TuxTooltip extends UIStateComponent
   {
       
      
      public function TuxTooltip(graphics:GraphicsReference)
      {
         super(DCResourceManager.instance.getFromSWF(graphics.swf,graphics.export));
         createContents();
         setMouseEnabled(false);
         setMouseChildren(false);
      }
      
      protected function createContents() : void
      {
      }
      
      public function checkTooltipLocation() : void
      {
      }
   }
}
