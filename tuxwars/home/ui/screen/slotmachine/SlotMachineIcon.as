package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   
   public class SlotMachineIcon
   {
      private var _design:MovieClip;
      
      private var _slotNumber:int;
      
      private var _graphicsReference:GraphicsReference;
      
      private var _icon:MovieClip;
      
      public function SlotMachineIcon(param1:MovieClip, param2:int)
      {
         super();
         this._design = param1;
         this._slotNumber = param2;
         param1.gotoAndStop("Default");
      }
      
      public function get slotNumber() : int
      {
         return this._slotNumber;
      }
      
      public function setIcon(param1:GraphicsReference) : void
      {
         if(this._icon != null && Boolean((this._design.getChildByName("Container_Icon") as MovieClip).contains(this._icon)))
         {
            (this._design.getChildByName("Container_Icon") as MovieClip).removeChild(this._icon);
         }
         this._icon = this.getIcon(param1);
         (this._design.getChildByName("Container_Icon") as MovieClip).addChild(this._icon);
         this._graphicsReference = param1;
      }
      
      private function getIcon(param1:GraphicsReference) : MovieClip
      {
         var _loc2_:MovieClip = DCResourceManager.instance.getFromSWF(param1.swf,param1.export);
         _loc2_.name = param1.export;
         return _loc2_;
      }
      
      public function playIconAnim() : void
      {
         var _loc1_:int = int(DCUtils.indexOfLabel(this._design,"Stop"));
         this._design.addFrameScript(_loc1_,this.stopIconAnim);
         this._design.gotoAndPlay("Win");
      }
      
      public function stopIconAnim() : void
      {
         var _loc1_:int = int(DCUtils.indexOfLabel(this._design,"Default"));
         this._design.addFrameScript(_loc1_,null);
         this._design.gotoAndStop("Default");
      }
      
      public function dispose() : void
      {
         var _loc1_:int = int(DCUtils.indexOfLabel(this._design,"Default"));
         this._design.addFrameScript(_loc1_,null);
         _loc1_ = int(DCUtils.indexOfLabel(this._design,"Stop"));
         this._design.addFrameScript(_loc1_,null);
         this._design = null;
         this._icon = null;
      }
      
      public function get graphicsReference() : GraphicsReference
      {
         return this._graphicsReference;
      }
   }
}

