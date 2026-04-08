package com.dchoc.ui.events
{
   public class UITransitionEvent extends UIEvent
   {
      public static const TRANSITION_ENDED:String = "transition_end";
      
      public function UITransitionEvent(param1:String, param2:Object = null)
      {
         super(param1,param2);
      }
   }
}

