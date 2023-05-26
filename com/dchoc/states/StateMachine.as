package com.dchoc.states
{
   import com.dchoc.events.StateChangeEvent;
   import com.dchoc.utils.LogUtils;
   import flash.events.EventDispatcher;
   
   public class StateMachine extends EventDispatcher implements IStateMachine
   {
      
      public static const STATE_CHANGED:String = "StateChanged";
      
      public static const STATE_ENTERED:String = "StateEntered";
      
      public static const STATE_EXITED:String = "StateExited";
       
      
      private const stateQueue:StateQueue = new StateQueue();
      
      internal var currentState:State;
      
      public function StateMachine()
      {
         super();
      }
      
      public function get state() : State
      {
         return currentState;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         var _loc2_:* = null;
         if(stateQueue.hasStates())
         {
            _loc2_ = stateQueue.getNextState();
            if(currentState && currentState.allowStateChange(_loc2_) || !currentState)
            {
               stateQueue.removeCurrentState();
               switchStates(_loc2_);
            }
         }
         if(currentState)
         {
            currentState.logicUpdate(deltaTime);
         }
      }
      
      public function dispose() : void
      {
         exitCurrentState(true);
      }
      
      public function exitCurrentState(clearQueue:Boolean = false) : void
      {
         if(currentState)
         {
            currentState.exit();
         }
         currentState = null;
         if(clearQueue && stateQueue.hasStates())
         {
            stateQueue.dispose();
         }
      }
      
      public function changeState(state:State, immediately:Boolean = false) : void
      {
         if(immediately)
         {
            if(currentState && currentState.allowStateChange(state) || !currentState)
            {
               switchStates(state);
            }
            else
            {
               stateQueue.addState(state);
            }
         }
         else
         {
            stateQueue.addState(state);
         }
      }
      
      private function switchStates(nextState:State) : void
      {
         if(currentState)
         {
            currentState.exit();
            dispatchEvent(new StateChangeEvent("StateExited",currentState,null));
         }
         LogUtils.log("Change state to: " + nextState,this,0);
         var _loc2_:State = currentState;
         currentState = nextState;
         currentState.enter();
         dispatchEvent(new StateChangeEvent("StateChanged",currentState,_loc2_));
      }
   }
}
