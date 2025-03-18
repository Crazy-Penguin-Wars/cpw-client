package com.dchoc.events
{
   import flash.events.Event;
   import flash.external.ExternalInterface;
   
   public class DCLoadingEvent extends Event
   {
      public static const COMPLETE_SINGLE_FILE:String = "complete";
      
      public static const ERROR:String = "error";
      
      public static const LOAD_OVER:String = "loadOver";
      
      private var _resourceName:String;
      
      public function DCLoadingEvent(type:String, resourceName:String = null)
      {
         ExternalInterface.call("console.log","com.dchoc.events DCLoadingEvent: arguments in order:");
         ExternalInterface.call("console.log",type);
         ExternalInterface.call("console.log",resourceName);
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

