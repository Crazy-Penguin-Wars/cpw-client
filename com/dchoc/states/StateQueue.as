package com.dchoc.states
{
   public class StateQueue
   {
       
      
      private const states:Array = [];
      
      public function StateQueue()
      {
         super();
      }
      
      public function addState(state:State) : void
      {
         states.push(state);
      }
      
      public function getNextState() : State
      {
         if(states.length > 0)
         {
            return states[0];
         }
         return null;
      }
      
      public function removeCurrentState() : void
      {
         if(states.length > 0)
         {
            states.splice(0,1);
         }
      }
      
      public function hasStates() : Boolean
      {
         return states.length > 0;
      }
      
      public function dispose() : void
      {
         states.splice(0,states.length);
      }
   }
}
