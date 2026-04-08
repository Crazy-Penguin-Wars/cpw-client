package com.dchoc.states
{
   import com.dchoc.game.DCGame;
   
   public class State extends StateMachine
   {
      protected var _params:*;
      
      protected var _game:DCGame;
      
      private var _parent:State;
      
      public function State(param1:DCGame, param2:* = null)
      {
         super();
         this._game = param1;
         this._params = param2;
      }
      
      public function get parent() : State
      {
         return this._parent;
      }
      
      public function allowStateChange(param1:State) : Boolean
      {
         return true;
      }
      
      public function enter() : void
      {
      }
      
      public function exit() : void
      {
         dispose();
         this._params = null;
         this._parent = null;
         this._game = null;
         currentState = null;
      }
      
      public function get game() : DCGame
      {
         return this._game;
      }
      
      public function get params() : *
      {
         return this._params;
      }
      
      override public function changeState(param1:State, param2:Boolean = false) : void
      {
         param1._parent = this;
         super.changeState(param1,param2);
      }
   }
}

