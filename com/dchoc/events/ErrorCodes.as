package com.dchoc.events
{
   public class ErrorCodes
   {
      
      public static const UNSPECIFIED_ERROR:String = "Error Unspecified";
      
      public static const LOGIC_UPDATER_EXCEPTION:String = "LogicUpdater Exception";
      
      public static const PHYSICS_UPDATER_EXCEPTION:String = "PhysicsUpdater Exception";
      
      public static const HTTP_SERVICE_ERROR:String = "HTTP Service Error";
      
      public static const MESSACE_CENTER_EXCEPTION:String = "Message Center Exception";
      
      public static const REQUEST_NOT_FOUND_ERROR:String = "Request Not Found";
       
      
      public function ErrorCodes()
      {
         super();
         throw new Error("ErrorCodes is a static class!");
      }
   }
}
