package com.dchoc.ui.events
{
   public class UITransitionEvent extends UIEvent
   {
      
      public static const TRANSITION_ENDED:String = "transition_end";
       
      
      public function UITransitionEvent(type:String, parameter:Object = null)
      {
         super(type,parameter);
      }
   }
}
