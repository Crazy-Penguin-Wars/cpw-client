package com.dchoc.ui.events
{
   import flash.events.Event;
   
   public class UIEvent extends Event
   {
      private var parameter:Object;
      
      public function UIEvent(param1:String, param2:Object = null)
      {
         super(param1);
         this.parameter = param2;
      }
      
      public function getParameter() : Object
      {
         return this.parameter;
      }
   }
}

