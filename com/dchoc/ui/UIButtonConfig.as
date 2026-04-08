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
      
      public static function setSoundStatus(param1:Boolean) : void
      {
         soundStatus = param1;
      }
      
      public static function setSounds(param1:Object) : void
      {
         if(param1)
         {
            sounds = param1;
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

