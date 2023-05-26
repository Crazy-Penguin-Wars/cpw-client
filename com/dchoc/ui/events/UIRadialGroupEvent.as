package com.dchoc.ui.events
{
   public class UIRadialGroupEvent extends UIEvent
   {
      
      public static const SELECTION_CHANGED:String = "selection_changed";
       
      
      public function UIRadialGroupEvent(type:String, parameter:Object = null)
      {
         super(type,parameter);
      }
   }
}
