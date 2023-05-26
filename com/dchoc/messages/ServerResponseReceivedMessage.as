package com.dchoc.messages
{
   import com.dchoc.net.ServerResponse;
   
   public class ServerResponseReceivedMessage extends Message
   {
       
      
      public function ServerResponseReceivedMessage(type:String, response:ServerResponse)
      {
         super(type,response);
      }
      
      public function get response() : ServerResponse
      {
         return data;
      }
   }
}
