package com.dchoc.messages
{
   import com.dchoc.net.ServerResponse;
   
   public class ServerResponseReceivedMessage extends Message
   {
      public function ServerResponseReceivedMessage(param1:String, param2:ServerResponse)
      {
         super(param1,param2);
      }
      
      public function get response() : ServerResponse
      {
         return data;
      }
   }
}

