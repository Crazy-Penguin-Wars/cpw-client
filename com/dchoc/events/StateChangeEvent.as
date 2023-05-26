package com.dchoc.events
{
   import com.dchoc.states.State;
   import flash.events.Event;
   
   public class StateChangeEvent extends Event
   {
       
      
      private var _state:State;
      
      private var _prevState:State;
      
      public function StateChangeEvent(type:String, state:State, prevState:State)
      {
         super(type);
         _state = state;
         _prevState = prevState;
      }
      
      public function get state() : State
      {
         return _state;
      }
      
      public function get prevState() : State
      {
         return _prevState;
      }
   }
}
