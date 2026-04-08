package com.dchoc.avatar
{
   import flash.geom.*;
   
   public class AvatarColor implements IAvatarColor
   {
      private var _colorTransform:ColorTransform;
      
      public function AvatarColor(param1:int, param2:int, param3:int)
      {
         super();
         this._colorTransform = new ColorTransform(1,1,1,1,param1,param2,param3,0);
      }
      
      public function get colorTransform() : ColorTransform
      {
         return this._colorTransform;
      }
   }
}

