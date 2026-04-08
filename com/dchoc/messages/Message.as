package com.dchoc.messages
{
   public class Message
   {
      private var _data:*;
      
      private var _type:String;
      
      public function Message(param1:String, param2:* = null)
      {
         super();
         this._type = param1;
         this._data = param2;
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      public function get type() : String
      {
         return this._type;
      }
   }
}

