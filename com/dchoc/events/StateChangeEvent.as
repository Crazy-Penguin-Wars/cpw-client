package com.dchoc.events
{
   import com.dchoc.states.State;
   import flash.events.Event;
   
   public class StateChangeEvent extends Event
   {
      private var _state:State;
      
      private var _prevState:State;
      
      public function StateChangeEvent(param1:String, param2:State, param3:State)
      {
         super(param1);
         this._state = param2;
         this._prevState = param3;
      }
      
      public function get state() : State
      {
         return this._state;
      }
      
      public function get prevState() : State
      {
         return this._prevState;
      }
   }
}

