package org.odefu.flash.display
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.filters.BitmapFilter;
   import flash.geom.Rectangle;
   
   public class BoundsUtil
   {
       
      
      public function BoundsUtil()
      {
         super();
         throw new Error("BoundsUtil is a static class!");
      }
      
      public static function getFrameBounds(mc:MovieClip) : Rectangle
      {
         var _loc2_:Rectangle = getBounds(mc);
         addFilterBounds(_loc2_,mc);
         return _loc2_;
      }
      
      public static function getBounds(mc:DisplayObject) : Rectangle
      {
         var _loc2_:Rectangle = mc.getBounds(mc.parent);
         _loc2_.x = Math.floor(_loc2_.x);
         _loc2_.y = Math.floor(_loc2_.y);
         _loc2_.width = Math.ceil(_loc2_.width);
         _loc2_.height = Math.ceil(_loc2_.height);
         return _loc2_;
      }
      
      public static function addFilterBounds(bounds:Rectangle, mc:DisplayObject) : void
      {
         var i:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var j:int = 0;
         for(i = 0; i < mc.filters.length; )
         {
            _loc5_ = getFilterBounds(getBounds(mc),mc.filters[i]);
            bounds.copyFrom(bounds.union(_loc5_));
            i++;
         }
         if(mc is DisplayObjectContainer)
         {
            _loc3_ = DisplayObjectContainer(mc);
            for(j = 0; j < _loc3_.numChildren; )
            {
               addFilterBounds(bounds,_loc3_.getChildAt(j));
               j++;
            }
         }
      }
      
      private static function getFilterBounds(bounds:Rectangle, filter:BitmapFilter) : Rectangle
      {
         var _loc3_:BitmapData = new BitmapData(bounds.width,bounds.height,false);
         var _loc4_:Rectangle = _loc3_.generateFilterRect(_loc3_.rect,filter);
         _loc3_.dispose();
         return _loc4_;
      }
   }
}
