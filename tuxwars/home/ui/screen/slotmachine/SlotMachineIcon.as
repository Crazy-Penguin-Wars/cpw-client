package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   
   public class SlotMachineIcon
   {
       
      
      private var _design:MovieClip;
      
      private var _slotNumber:int;
      
      private var _graphicsReference:GraphicsReference;
      
      private var _icon:MovieClip;
      
      public function SlotMachineIcon(design:MovieClip, slotNumber:int)
      {
         super();
         _design = design;
         _slotNumber = slotNumber;
         design.gotoAndStop("Default");
      }
      
      public function get slotNumber() : int
      {
         return _slotNumber;
      }
      
      public function setIcon(picture:GraphicsReference) : void
      {
         if(_icon != null && (_design.getChildByName("Container_Icon") as MovieClip).contains(_icon))
         {
            (_design.getChildByName("Container_Icon") as MovieClip).removeChild(_icon);
         }
         _icon = getIcon(picture);
         (_design.getChildByName("Container_Icon") as MovieClip).addChild(_icon);
         _graphicsReference = picture;
      }
      
      private function getIcon(picture:GraphicsReference) : MovieClip
      {
         var _loc2_:MovieClip = DCResourceManager.instance.getFromSWF(picture.swf,picture.export);
         _loc2_.name = picture.export;
         return _loc2_;
      }
      
      public function playIconAnim() : void
      {
         var index:int = DCUtils.indexOfLabel(_design,"Stop");
         _design.addFrameScript(index,stopIconAnim);
         _design.gotoAndPlay("Win");
      }
      
      public function stopIconAnim() : void
      {
         var _loc1_:int = DCUtils.indexOfLabel(_design,"Default");
         _design.addFrameScript(_loc1_,null);
         _design.gotoAndStop("Default");
      }
      
      public function dispose() : void
      {
         var index:int = DCUtils.indexOfLabel(_design,"Default");
         _design.addFrameScript(index,null);
         index = DCUtils.indexOfLabel(_design,"Stop");
         _design.addFrameScript(index,null);
         _design = null;
         _icon = null;
      }
      
      public function get graphicsReference() : GraphicsReference
      {
         return _graphicsReference;
      }
   }
}
