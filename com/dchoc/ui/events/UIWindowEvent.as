package com.dchoc.ui.events
{
   public class UIWindowEvent extends UIEvent
   {
      public static const WINDOW_CLOSED:String = "event_window_closed";
      
      public function UIWindowEvent(param1:String, param2:Object = null)
      {
         super(param1,param2);
      }
   }
}

