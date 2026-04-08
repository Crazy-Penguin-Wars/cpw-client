package org.odefu.flash.display
{
   import flash.display.*;
   import flash.filters.BitmapFilter;
   import flash.geom.Rectangle;
   
   public class BoundsUtil
   {
      public function BoundsUtil()
      {
         super();
         throw new Error("BoundsUtil is a static class!");
      }
      
      public static function getFrameBounds(param1:MovieClip) : flash.geom.Rectangle
      {
         var _loc2_:flash.geom.Rectangle = getBounds(param1);
         addFilterBounds(_loc2_,param1);
         return _loc2_;
      }
      
      public static function getBounds(param1:DisplayObject) : flash.geom.Rectangle
      {
         var _loc2_:flash.geom.Rectangle = param1.getBounds(param1.parent);
         _loc2_.x = Math.floor(_loc2_.x);
         _loc2_.y = Math.floor(_loc2_.y);
         _loc2_.width = Math.ceil(_loc2_.width);
         _loc2_.height = Math.ceil(_loc2_.height);
         return _loc2_;
      }
      
      public static function addFilterBounds(param1:flash.geom.Rectangle, param2:DisplayObject) : void
      {
         var _loc3_:int = 0;
         var _loc4_:flash.geom.Rectangle = null;
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param2.filters.length)
         {
            _loc4_ = getFilterBounds(getBounds(param2),param2.filters[_loc3_]);
            param1.copyFrom(param1.union(_loc4_));
            _loc3_++;
         }
         if(param2 is DisplayObjectContainer)
         {
            _loc5_ = DisplayObjectContainer(param2);
            _loc6_ = 0;
            while(_loc6_ < _loc5_.numChildren)
            {
               addFilterBounds(param1,_loc5_.getChildAt(_loc6_));
               _loc6_++;
            }
         }
      }
      
      private static function getFilterBounds(param1:flash.geom.Rectangle, param2:BitmapFilter) : flash.geom.Rectangle
      {
         var _loc3_:BitmapData = new BitmapData(param1.width,param1.height,false);
         var _loc4_:flash.geom.Rectangle = _loc3_.generateFilterRect(_loc3_.rect,param2);
         _loc3_.dispose();
         return _loc4_;
      }
   }
}

