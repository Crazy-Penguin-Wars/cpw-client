package com.dchoc.net
{
   public class HTTPMessageTypes
   {
      
      public static const SEND_REQUEST:String = "SendRequest";
      
      public static const DATA_RECEIVED:String = "DataReceived";
      
      public static const RESPONSE_RECEIVED:String = "ResponseReceived_";
      
      public static const RESPONSE_ERROR:String = "ResponseError";
       
      
      public function HTTPMessageTypes()
      {
         super();
         throw new Error("HTTPMessageTypes is a static class!");
      }
   }
}
