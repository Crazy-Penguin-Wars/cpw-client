package com.dchoc.messages
{
   public class MessageTypes
   {
      
      public static const CONFIG_LOADED:String = "ConfigLoaded";
      
      public static const VIDEO_STARTED:String = "VideoStarted";
      
      public static const VIDEO_STOPPED:String = "VideoStopped";
       
      
      public function MessageTypes()
      {
         super();
         throw new Error("MessageTypes is a static class!");
      }
   }
}
