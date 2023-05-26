package tuxwars.ui.components
{
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   
   public class IconButton extends UIButton
   {
      
      private static const CONTAINER_ICON:String = "Container_Icon";
       
      
      private var _icon:MovieClip;
      
      public function IconButton(design:MovieClip, parameter:Object = null, useDefaultSound:Boolean = true, sounds:Object = null, customSoundStatus:Boolean = false)
      {
         super(design,parameter,useDefaultSound,sounds,customSoundStatus);
      }
      
      override public function dispose() : void
      {
         removeIcon();
         super.dispose();
      }
      
      private function removeIcon() : void
      {
         var _loc2_:* = null;
         var i:int = 0;
         var displayable:* = undefined;
         if(getIconContainer())
         {
            _loc2_ = getIconContainer();
            for(i = 0; i < _loc2_.numChildren; )
            {
               displayable = _loc2_.getChildAt(i);
               if(!(displayable is Shape))
               {
                  _loc2_.removeChildAt(i);
               }
               i++;
            }
         }
         _icon = null;
      }
      
      public function setIcon(icon:MovieClip) : void
      {
         removeIcon();
         _icon = icon;
         if(icon && getIconContainer())
         {
            if(icon.numChildren > 0 && icon.getChildAt(0) is Bitmap)
            {
               Bitmap(icon.getChildAt(0)).smoothing = true;
            }
            getIconContainer().addChild(icon);
         }
         updateTextField();
      }
      
      private function getIconContainer() : MovieClip
      {
         var _loc3_:* = null;
         var _loc2_:MovieClip = getDesignMovieClip();
         var clip:MovieClip = _loc2_.getChildByName("Container_Icon") as MovieClip;
         if(clip == null)
         {
            _loc3_ = _loc2_.getChildByName("Reward_Item") as MovieClip;
            if(_loc3_ != null)
            {
               clip = _loc3_.getChildByName("Container_Icon") as MovieClip;
            }
         }
         if(getDesignMovieClip() && clip != null)
         {
            clip.mouseChildren = false;
            clip.mouseEnabled = false;
            return clip;
         }
         return null;
      }
   }
}
