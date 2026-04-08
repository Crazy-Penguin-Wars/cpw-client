package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.ui.base.UIComponent;
   import flash.display.*;
   
   public class SlotMachineAwardItemContainer extends SlotMachineAwardContainer
   {
      private var _icon:MovieClip;
      
      public function SlotMachineAwardItemContainer(param1:MovieClip, param2:UIComponent = null)
      {
         super(param1,param2);
      }
      
      public function setItem(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = getDesignMovieClip().getChildByName("Container_Icon") as MovieClip;
         if(this._icon != null && _loc2_.contains(this._icon))
         {
            _loc2_.removeChild(this._icon);
         }
         this._icon = param1;
         _loc2_.addChild(this._icon);
      }
   }
}

