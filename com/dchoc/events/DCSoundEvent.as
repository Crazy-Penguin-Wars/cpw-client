package com.dchoc.events
{
   import flash.events.Event;
   
   public class DCSoundEvent extends Event
   {
      
      public static const COMPLETE_ONE_PLAY:String = "soundComplete";
      
      public static const PLAY_ERROR:String = "soundPLayError";
       
      
      private var _resourceName:String;
      
      public function DCSoundEvent(type:String = null, resourceName:String = null)
      {
         if(resourceName != null)
         {
            type += "@" + resourceName;
         }
         super(type);
         _resourceName = resourceName;
      }
      
      public function get resourceName() : String
      {
         return _resourceName;
      }
   }
}
