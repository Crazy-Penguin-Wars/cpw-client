package com.dchoc.states
{
   public interface IStateMachine
   {
       
      
      function get state() : State;
      
      function changeState(param1:State, param2:Boolean = false) : void;
      
      function exitCurrentState(param1:Boolean = false) : void;
   }
}
