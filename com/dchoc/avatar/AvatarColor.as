package com.dchoc.avatar
{
   import flash.geom.ColorTransform;
   
   public class AvatarColor implements IAvatarColor
   {
       
      
      private var _colorTransform:ColorTransform;
      
      public function AvatarColor(redMultiplier:int, greenMultiplier:int, blueMultiplier:int)
      {
         super();
         _colorTransform = new ColorTransform(1,1,1,1,redMultiplier,greenMultiplier,blueMultiplier,0);
      }
      
      public function get colorTransform() : ColorTransform
      {
         return _colorTransform;
      }
   }
}
