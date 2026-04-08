package org.odefu.flash.display
{
   import flash.display.MovieClip;
   import flash.geom.*;
   
   public class FrameBoundsCache
   {
      private const frameBounds:Vector.<flash.geom.Rectangle>;
      
      public function FrameBoundsCache(param1:MovieClip)
      {
         var _loc2_:int = 0;
         this.frameBounds = new Vector.<Rectangle>();
         super();
         _loc2_ = 0;
         while(_loc2_ < param1.totalFrames)
         {
            param1.gotoAndStop(_loc2_);
            this.frameBounds.push(BoundsUtil.getFrameBounds(param1));
            _loc2_++;
         }
      }
      
      public function get(param1:int) : flash.geom.Rectangle
      {
         if(param1 >= 0 && param1 < this.frameBounds.length)
         {
            return this.frameBounds[param1];
         }
         return null;
      }
      
      public function get length() : int
      {
         return this.frameBounds.length;
      }
   }
}

