package com.dchoc.input
{
   import com.dchoc.events.*;
   import com.dchoc.game.GameWorld;
   import com.dchoc.utils.*;
   import flash.events.*;
   import no.olog.utilfunctions.*;
   
   public class InputSystem implements InputEventHandler
   {
      private const newActions:Vector.<InputAction> = new Vector.<InputAction>();
      
      private const actions:Object = {};
      
      private var world:GameWorld;
      
      public function InputSystem()
      {
         super();
      }
      
      public function setGameWorld(param1:GameWorld) : void
      {
         assert("GameWorld is null.",true,param1 != null);
         this.world = param1;
         this.world.addInputEventHandler(this);
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         this.world.removeInputEventHandler(this);
         this.world = null;
         for(_loc1_ in this.actions)
         {
            this.actions[_loc1_] = null;
         }
      }
      
      public function logicUpdate(param1:int) : void
      {
         while(this.newActions.length > 0)
         {
            this.activateInputAction(this.newActions.pop());
         }
      }
      
      public function addInputAction(param1:InputAction) : void
      {
         if(param1)
         {
            this.newActions.push(param1);
         }
         else
         {
            LogUtils.log("Trying to add null action!","InputSystem",3,"ErrorLogging",true,false,true);
         }
      }
      
      private function activateInputAction(param1:InputAction) : void
      {
         var _loc2_:Array = null;
         if(param1)
         {
            _loc2_ = Boolean(this.actions.hasOwnProperty(param1.getType())) && this.actions[param1.getType()] != null ? this.actions[param1.getType()] : [];
            if(_loc2_.indexOf(param1) == -1)
            {
               _loc2_.push(param1);
               this.actions[param1.getType()] = _loc2_;
               LogUtils.log("Added action " + param1,"InputSystem",1,"Input",false,false,true);
            }
         }
      }
      
      public function removeInputAction(param1:InputAction) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = Boolean(this.actions.hasOwnProperty(param1.getType())) && this.actions[param1.getType()] != null ? this.actions[param1.getType()] : [];
            _loc3_ = int(_loc2_.indexOf(param1));
            if(_loc3_ != -1)
            {
               _loc2_.splice(_loc3_,1);
               this.actions[param1.getType()] = _loc2_;
               LogUtils.log("Removed action " + param1,"InputSystem",1,"Input",false,false,true);
            }
         }
      }
      
      public function handleInputEvent(param1:Event) : void
      {
         if(param1 is MouseEvent)
         {
            this.handleMouseEvent(param1 as MouseEvent);
         }
         else if(param1 is KeyboardEvent)
         {
            this.handleKeyboardEvent(param1 as KeyboardEvent);
         }
         else
         {
            this.handleEvent(param1);
         }
      }
      
      private function handleMouseEvent(param1:MouseEvent) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = !!this.actions.hasOwnProperty(param1.type) ? this.actions[param1.type] : [];
         for each(_loc3_ in _loc2_)
         {
            _loc3_.execute(param1);
         }
      }
      
      private function handleKeyboardEvent(param1:KeyboardEvent) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = !!this.actions.hasOwnProperty(param1.type) ? this.actions[param1.type] : [];
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.keyCode == param1.keyCode || _loc3_.keyCode == -1)
            {
               _loc3_.execute(param1);
            }
         }
      }
      
      private function handleEvent(param1:Event) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = !!this.actions.hasOwnProperty(param1.type) ? this.actions[param1.type] : [];
         for each(_loc3_ in _loc2_)
         {
            _loc3_.execute(param1);
         }
      }
   }
}

