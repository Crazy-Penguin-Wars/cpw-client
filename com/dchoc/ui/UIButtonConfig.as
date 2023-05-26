package com.dchoc.ui
{
   public class UIButtonConfig
   {
      
      private static var soundStatus:Boolean = true;
      
      private static var sounds:Object = {};
       
      
      public function UIButtonConfig()
      {
         super();
         throw new Error("UIButtonConfig is a static class!");
      }
      
      public static function setSoundStatus(value:Boolean) : void
      {
         soundStatus = value;
      }
      
      public static function setSounds(obj:Object) : void
      {
         if(obj)
         {
            sounds = obj;
         }
         else
         {
            sounds = {};
         }
      }
      
      public static function getSounds() : Object
      {
         return sounds;
      }
      
      public static function getSoundStatus() : Boolean
      {
         return soundStatus;
      }
   }
}
