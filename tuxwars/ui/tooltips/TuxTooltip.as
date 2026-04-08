package tuxwars.ui.tooltips
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.resources.*;
   import com.dchoc.ui.base.UIStateComponent;
   
   public class TuxTooltip extends UIStateComponent
   {
      public function TuxTooltip(param1:GraphicsReference)
      {
         super(DCResourceManager.instance.getFromSWF(param1.swf,param1.export));
         this.createContents();
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

