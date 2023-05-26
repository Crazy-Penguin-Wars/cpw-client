package com.dchoc.ui.events
{
   import flash.events.Event;
   
   public class UIEvent extends Event
   {
       
      
      private var parameter:Object;
      
      public function UIEvent(type:String, parameter:Object = null)
      {
         super(type);
         this.parameter = parameter;
      }
      
      public function getParameter() : Object
      {
         return parameter;
      }
   }
}
