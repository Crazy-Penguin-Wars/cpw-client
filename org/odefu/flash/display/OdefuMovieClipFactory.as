package org.odefu.flash.display
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.textures.Texture;
   
   public final class OdefuMovieClipFactory
   {
       
      
      public function OdefuMovieClipFactory()
      {
         super();
         throw new Error("OdefuMovieClipFactory is a static class!");
      }
      
      public static function create(mc:MovieClip, fps:int = 12) : OdefuMovieClip
      {
         var _loc7_:FrameBoundsCache = new FrameBoundsCache(mc);
         var _loc6_:Rectangle = calculateFrameSize(_loc7_);
         var _loc3_:Point = getPivot(_loc6_,mc);
         var _loc5_:Vector.<Texture> = new Vector.<Texture>();
         var _loc8_:Array = [];
         drawFrames(mc,_loc5_,_loc8_,_loc6_,_loc3_);
         var _loc4_:OdefuMovieClip = new OdefuMovieClip(_loc5_,_loc8_,fps);
         _loc4_.name = mc.name;
         _loc4_.pivotX = Math.abs(_loc3_.x);
         _loc4_.pivotY = Math.abs(_loc3_.y);
         return _loc4_;
      }
      
      private static function getPivot(frameSize:Rectangle, mc:MovieClip) : Point
      {
         mc.gotoAndStop(0);
         var _loc3_:Rectangle = new Rectangle();
         BoundsUtil.addFilterBounds(_loc3_,mc);
         return new Point(-frameSize.x - _loc3_.x,-frameSize.y - _loc3_.y);
      }
      
      private static function drawFrames(clip:MovieClip, textures:Vector.<Texture>, frameLabels:Array, frameSize:Rectangle, pivot:Point) : void
      {
         var i:int = 0;
         var _loc6_:BitmapData = new BitmapData(frameSize.width,frameSize.height,true,16777215);
         for(i = 1; i <= clip.totalFrames; )
         {
            clip.gotoAndStop(i);
            textures.push(drawFrame(clip,frameSize,pivot,_loc6_));
            frameLabels.push(clip.currentFrameLabel);
            i++;
         }
         _loc6_.dispose();
      }
      
      private static function drawFrame(clip:MovieClip, frameSize:Rectangle, pivot:Point, bitmapData:BitmapData) : Texture
      {
         bitmapData.fillRect(bitmapData.rect,16777215);
         var _loc5_:Matrix = clip.transform.matrix.clone();
         _loc5_.translate(pivot.x,pivot.y);
         bitmapData.draw(clip,_loc5_,clip.transform.colorTransform,null,null,true);
         return Texture.fromBitmapData(bitmapData,true,true);
      }
      
      private static function calculateFrameSize(cache:FrameBoundsCache) : Rectangle
      {
         var i:int = 0;
         var _loc3_:Rectangle = new Rectangle();
         for(i = 0; i < cache.length; )
         {
            _loc3_.copyFrom(_loc3_.union(cache.get(i)));
            i++;
         }
         return _loc3_;
      }
   }
}
