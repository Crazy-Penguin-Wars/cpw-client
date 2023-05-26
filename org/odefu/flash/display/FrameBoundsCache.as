package org.odefu.flash.display
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class FrameBoundsCache
   {
       
      
      private const frameBounds:Vector.<Rectangle> = new Vector.<Rectangle>();
      
      public function FrameBoundsCache(mc:MovieClip)
      {
         var i:int = 0;
         super();
         for(i = 0; i < mc.totalFrames; )
         {
            mc.gotoAndStop(i);
            frameBounds.push(BoundsUtil.getFrameBounds(mc));
            i++;
         }
      }
      
      public function get(index:int) : Rectangle
      {
         if(index >= 0 && index < frameBounds.length)
         {
            return frameBounds[index];
         }
         return null;
      }
      
      public function get length() : int
      {
         return frameBounds.length;
      }
   }
}
