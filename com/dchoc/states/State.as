package com.dchoc.states
{
   import com.dchoc.game.DCGame;
   
   public class State extends StateMachine
   {
       
      
      protected var _params;
      
      protected var _game:DCGame;
      
      private var _parent:State;
      
      public function State(game:DCGame, params:* = null)
      {
         super();
         _game = game;
         _params = params;
      }
      
      public function get parent() : State
      {
         return _parent;
      }
      
      public function allowStateChange(nextState:State) : Boolean
      {
         return true;
      }
      
      public function enter() : void
      {
      }
      
      public function exit() : void
      {
         dispose();
         _params = null;
         _parent = null;
         _game = null;
         currentState = null;
      }
      
      public function get game() : DCGame
      {
         return _game;
      }
      
      public function get params() : *
      {
         return _params;
      }
      
      override public function changeState(state:State, force:Boolean = false) : void
      {
         state._parent = this;
         super.changeState(state,force);
      }
   }
}
