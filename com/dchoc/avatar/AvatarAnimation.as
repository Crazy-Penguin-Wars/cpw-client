package com.dchoc.avatar
{
   public class AvatarAnimation
   {
       
      
      private var _classDefinitionName:String;
      
      private var _looping:Boolean;
      
      private var _callback:Function;
      
      public function AvatarAnimation(classDefinitionName:String, looping:Boolean = true, callback:Function = null)
      {
         super();
         _classDefinitionName = classDefinitionName;
         _looping = looping;
         _callback = callback;
      }
      
      public function isLooping() : Boolean
      {
         return _looping;
      }
      
      public function get callback() : Function
      {
         return _callback;
      }
      
      public function get classDefinitionName() : String
      {
         return _classDefinitionName;
      }
      
      public function toString() : String
      {
         return "AvatarAnimation - " + _classDefinitionName;
      }
      
      public function equals(other:AvatarAnimation) : Boolean
      {
         return _classDefinitionName == other._classDefinitionName && _looping == other._looping && _callback == other._callback;
      }
   }
}
