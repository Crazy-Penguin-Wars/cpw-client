package com.dchoc.states
{
   public class StateQueue
   {
      private const states:Array = [];
      
      public function StateQueue()
      {
         super();
      }
      
      public function addState(param1:State) : void
      {
         this.states.push(param1);
      }
      
      public function getNextState() : State
      {
         if(this.states.length > 0)
         {
            return this.states[0];
         }
         return null;
      }
      
      public function removeCurrentState() : void
      {
         if(this.states.length > 0)
         {
            this.states.splice(0,1);
         }
      }
      
      public function hasStates() : Boolean
      {
         return this.states.length > 0;
      }
      
      public function dispose() : void
      {
         this.states.splice(0,this.states.length);
      }
   }
}

