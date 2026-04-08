package org.odefu.flash.display
{
   import flash.display.*;
   import flash.geom.*;
   import starling.textures.*;
   
   public final class OdefuMovieClipFactory
   {
      public function OdefuMovieClipFactory()
      {
         super();
         throw new Error("OdefuMovieClipFactory is a static class!");
      }
      
      public static function create(param1:MovieClip, param2:int = 12) : OdefuMovieClip
      {
         var _loc5_:Point = null;
         var _loc3_:FrameBoundsCache = new FrameBoundsCache(param1);
         var _loc4_:flash.geom.Rectangle = calculateFrameSize(_loc3_);
         _loc5_ = getPivot(_loc4_,param1);
         var _loc6_:Vector.<Texture> = new Vector.<Texture>();
         var _loc7_:Array = [];
         drawFrames(param1,_loc6_,_loc7_,_loc4_,_loc5_);
         var _loc8_:OdefuMovieClip = new OdefuMovieClip(_loc6_,_loc7_,param2);
         _loc8_.name = param1.name;
         _loc8_.pivotX = Math.abs(_loc5_.x);
         _loc8_.pivotY = Math.abs(_loc5_.y);
         return _loc8_;
      }
      
      private static function getPivot(param1:flash.geom.Rectangle, param2:MovieClip) : Point
      {
         param2.gotoAndStop(0);
         var _loc3_:flash.geom.Rectangle = new Rectangle();
         BoundsUtil.addFilterBounds(_loc3_,param2);
         return new Point(-param1.x - _loc3_.x,-param1.y - _loc3_.y);
      }
      
      private static function drawFrames(param1:MovieClip, param2:Vector.<Texture>, param3:Array, param4:flash.geom.Rectangle, param5:Point) : void
      {
         var _loc6_:int = 0;
         var _loc7_:BitmapData = new BitmapData(param4.width,param4.height,true,16777215);
         _loc6_ = 1;
         while(_loc6_ <= param1.totalFrames)
         {
            param1.gotoAndStop(_loc6_);
            param2.push(drawFrame(param1,param4,param5,_loc7_));
            param3.push(param1.currentFrameLabel);
            _loc6_++;
         }
         _loc7_.dispose();
      }
      
      private static function drawFrame(param1:MovieClip, param2:flash.geom.Rectangle, param3:Point, param4:BitmapData) : Texture
      {
         param4.fillRect(param4.rect,16777215);
         var _loc5_:Matrix = param1.transform.matrix.clone();
         _loc5_.translate(param3.x,param3.y);
         param4.draw(param1,_loc5_,param1.transform.colorTransform,null,null,true);
         return Texture.fromBitmapData(param4,true,true);
      }
      
      private static function calculateFrameSize(param1:FrameBoundsCache) : flash.geom.Rectangle
      {
         var _loc2_:int = 0;
         var _loc3_:flash.geom.Rectangle = new Rectangle();
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_.copyFrom(_loc3_.union(param1.get(_loc2_)));
            _loc2_++;
         }
         return _loc3_;
      }
   }
}

