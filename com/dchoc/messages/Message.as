package com.dchoc.messages
{
   public class Message
   {
       
      
      private var _data;
      
      private var _type:String;
      
      public function Message(type:String, data:* = null)
      {
         super();
         _type = type;
         _data = data;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      public function get type() : String
      {
         return _type;
      }
   }
}
