package com.dchoc.events
{
   import flash.events.Event;
   
   public class DCSoundEvent extends Event
   {
      public static const COMPLETE_ONE_PLAY:String = "soundComplete";
      
      public static const PLAY_ERROR:String = "soundPLayError";
      
      private var _resourceName:String;
      
      public function DCSoundEvent(param1:String = null, param2:String = null)
      {
         if(param2 != null)
         {
            param1 += "@" + param2;
         }
         super(param1);
         this._resourceName = param2;
      }
      
      public function get resourceName() : String
      {
         return this._resourceName;
      }
   }
}

