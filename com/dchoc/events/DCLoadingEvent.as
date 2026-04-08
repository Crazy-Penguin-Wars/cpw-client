package com.dchoc.events
{
   import flash.events.Event;
   
   public class DCLoadingEvent extends Event
   {
      public static const COMPLETE_SINGLE_FILE:String = "complete";
      
      public static const ERROR:String = "error";
      
      public static const LOAD_OVER:String = "loadOver";
      
      private var _resourceName:String;
      
      public function DCLoadingEvent(param1:String, param2:String = null)
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

