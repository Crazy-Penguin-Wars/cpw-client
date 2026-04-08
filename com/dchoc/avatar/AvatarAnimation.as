package com.dchoc.avatar
{
   public class AvatarAnimation
   {
      private var _classDefinitionName:String;
      
      private var _looping:Boolean;
      
      private var _callback:Function;
      
      public function AvatarAnimation(param1:String, param2:Boolean = true, param3:Function = null)
      {
         super();
         this._classDefinitionName = param1;
         this._looping = param2;
         this._callback = param3;
      }
      
      public function isLooping() : Boolean
      {
         return this._looping;
      }
      
      public function get callback() : Function
      {
         return this._callback;
      }
      
      public function get classDefinitionName() : String
      {
         return this._classDefinitionName;
      }
      
      public function toString() : String
      {
         return "AvatarAnimation - " + this._classDefinitionName;
      }
      
      public function equals(param1:AvatarAnimation) : Boolean
      {
         return this._classDefinitionName == param1._classDefinitionName && this._looping == param1._looping && this._callback == param1._callback;
      }
   }
}

