package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   
   public class SlotMachineAwardItemContainer extends SlotMachineAwardContainer
   {
       
      
      private var _icon:MovieClip;
      
      public function SlotMachineAwardItemContainer(design:MovieClip, parent:UIComponent = null)
      {
         super(design,parent);
      }
      
      public function setItem(value:MovieClip) : void
      {
         var mc:MovieClip = getDesignMovieClip().getChildByName("Container_Icon") as MovieClip;
         if(_icon != null && mc.contains(_icon))
         {
            mc.removeChild(_icon);
         }
         _icon = value;
         mc.addChild(_icon);
      }
   }
}
