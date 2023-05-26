package com.dchoc.avatar.paperdoll
{
   public class BodyPart
   {
       
      
      private var clipName:String;
      
      private var className:String;
      
      public function BodyPart(clipName:String, className:String)
      {
         super();
         this.clipName = clipName;
         this.className = className;
      }
      
      public function getClipName() : String
      {
         return clipName;
      }
      
      public function getClassName() : String
      {
         return className;
      }
      
      public function equals(other:BodyPart) : Boolean
      {
         return other && other.className == className && other.clipName == clipName;
      }
      
      public function toString() : String
      {
         return "BodyPart: " + clipName + " / " + className;
      }
   }
}
