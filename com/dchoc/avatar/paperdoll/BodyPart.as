package com.dchoc.avatar.paperdoll
{
   public class BodyPart
   {
      private var clipName:String;
      
      private var className:String;
      
      public function BodyPart(param1:String, param2:String)
      {
         super();
         this.clipName = param1;
         this.className = param2;
      }
      
      public function getClipName() : String
      {
         return this.clipName;
      }
      
      public function getClassName() : String
      {
         return this.className;
      }
      
      public function equals(param1:BodyPart) : Boolean
      {
         return Boolean(param1) && param1.className == this.className && param1.clipName == this.clipName;
      }
      
      public function toString() : String
      {
         return "BodyPart: " + this.clipName + " / " + this.className;
      }
   }
}

