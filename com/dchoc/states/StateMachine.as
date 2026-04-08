package com.dchoc.states
{
   import com.dchoc.events.*;
   import com.dchoc.utils.*;
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
         return this.currentState;
      }
      
      public function logicUpdate(param1:int) : void
      {
         var _loc2_:State = null;
         if(this.stateQueue.hasStates())
         {
            _loc2_ = this.stateQueue.getNextState();
            if(this.currentState && this.currentState.allowStateChange(_loc2_) || !this.currentState)
            {
               this.stateQueue.removeCurrentState();
               this.switchStates(_loc2_);
            }
         }
         if(this.currentState)
         {
            this.currentState.logicUpdate(param1);
         }
      }
      
      public function dispose() : void
      {
         this.exitCurrentState(true);
      }
      
      public function exitCurrentState(param1:Boolean = false) : void
      {
         if(this.currentState)
         {
            this.currentState.exit();
         }
         this.currentState = null;
         if(param1 && Boolean(this.stateQueue.hasStates()))
         {
            this.stateQueue.dispose();
         }
      }
      
      public function changeState(param1:State, param2:Boolean = false) : void
      {
         if(param2)
         {
            if(this.currentState && this.currentState.allowStateChange(param1) || !this.currentState)
            {
               this.switchStates(param1);
            }
            else
            {
               this.stateQueue.addState(param1);
            }
         }
         else
         {
            this.stateQueue.addState(param1);
         }
      }
      
      private function switchStates(param1:State) : void
      {
         if(this.currentState)
         {
            this.currentState.exit();
            dispatchEvent(new StateChangeEvent("StateExited",this.currentState,null));
         }
         LogUtils.log("Change state to: " + param1,this,0);
         var _loc2_:State = this.currentState;
         this.currentState = param1;
         this.currentState.enter();
         dispatchEvent(new StateChangeEvent("StateChanged",this.currentState,_loc2_));
      }
   }
}

