package com.dchoc.ui.events
{
   public class UIWindowEvent extends UIEvent
   {
      
      public static const WINDOW_CLOSED:String = "event_window_closed";
       
      
      public function UIWindowEvent(type:String, parameter:Object = null)
      {
         super(type,parameter);
      }
   }
}
