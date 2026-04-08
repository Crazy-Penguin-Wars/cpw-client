package tuxwars.ui.components
{
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.*;
   
   public class IconButton extends UIButton
   {
      private static const CONTAINER_ICON:String = "Container_Icon";
      
      private var _icon:MovieClip;
      
      public function IconButton(param1:MovieClip, param2:Object = null, param3:Boolean = true, param4:Object = null, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function dispose() : void
      {
         this.removeIcon();
         super.dispose();
      }
      
      private function removeIcon() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         if(this.getIconContainer())
         {
            _loc1_ = this.getIconContainer();
            _loc2_ = 0;
            while(_loc2_ < _loc1_.numChildren)
            {
               _loc3_ = _loc1_.getChildAt(_loc2_);
               if(!(_loc3_ is Shape))
               {
                  _loc1_.removeChildAt(_loc2_);
               }
               _loc2_++;
            }
         }
         this._icon = null;
      }
      
      public function setIcon(param1:MovieClip) : void
      {
         this.removeIcon();
         this._icon = param1;
         if(Boolean(param1) && Boolean(this.getIconContainer()))
         {
            if(param1.numChildren > 0 && param1.getChildAt(0) is Bitmap)
            {
               Bitmap(param1.getChildAt(0)).smoothing = true;
            }
            this.getIconContainer().addChild(param1);
         }
         updateTextField();
      }
      
      private function getIconContainer() : MovieClip
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = getDesignMovieClip();
         var _loc3_:MovieClip = _loc2_.getChildByName("Container_Icon") as MovieClip;
         if(_loc3_ == null)
         {
            _loc1_ = _loc2_.getChildByName("Reward_Item") as MovieClip;
            if(_loc1_ != null)
            {
               _loc3_ = _loc1_.getChildByName("Container_Icon") as MovieClip;
            }
         }
         if(Boolean(getDesignMovieClip()) && _loc3_ != null)
         {
            _loc3_.mouseChildren = false;
            _loc3_.mouseEnabled = false;
            return _loc3_;
         }
         return null;
      }
   }
}

