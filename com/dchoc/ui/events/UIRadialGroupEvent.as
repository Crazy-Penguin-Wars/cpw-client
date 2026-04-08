package com.dchoc.ui.events
{
   public class UIRadialGroupEvent extends UIEvent
   {
      public static const SELECTION_CHANGED:String = "selection_changed";
      
      public function UIRadialGroupEvent(param1:String, param2:Object = null)
      {
         super(param1,param2);
      }
   }
}

