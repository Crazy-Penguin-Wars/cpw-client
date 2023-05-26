package com.dchoc.input
{
   import com.dchoc.events.InputEventHandler;
   import com.dchoc.game.GameWorld;
   import com.dchoc.utils.LogUtils;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import no.olog.utilfunctions.assert;
   
   public class InputSystem implements InputEventHandler
   {
       
      
      private const newActions:Vector.<InputAction> = new Vector.<InputAction>();
      
      private const actions:Object = {};
      
      private var world:GameWorld;
      
      public function InputSystem()
      {
         super();
      }
      
      public function setGameWorld(world:GameWorld) : void
      {
         assert("GameWorld is null.",true,world != null);
         this.world = world;
         this.world.addInputEventHandler(this);
      }
      
      public function dispose() : void
      {
         world.removeInputEventHandler(this);
         world = null;
         for(var action in actions)
         {
            actions[action] = null;
         }
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         while(newActions.length > 0)
         {
            activateInputAction(newActions.pop());
         }
      }
      
      public function addInputAction(action:InputAction) : void
      {
         if(action)
         {
            newActions.push(action);
         }
         else
         {
            LogUtils.log("Trying to add null action!","InputSystem",3,"ErrorLogging",true,false,true);
         }
      }
      
      private function activateInputAction(action:InputAction) : void
      {
         var _loc2_:* = null;
         if(action)
         {
            _loc2_ = actions.hasOwnProperty(action.getType()) && actions[action.getType()] != null ? actions[action.getType()] : [];
            if(_loc2_.indexOf(action) == -1)
            {
               _loc2_.push(action);
               actions[action.getType()] = _loc2_;
               LogUtils.log("Added action " + action,"InputSystem",1,"Input",false,false,true);
            }
         }
      }
      
      public function removeInputAction(action:InputAction) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         if(action)
         {
            _loc3_ = actions.hasOwnProperty(action.getType()) && actions[action.getType()] != null ? actions[action.getType()] : [];
            _loc2_ = _loc3_.indexOf(action);
            if(_loc2_ != -1)
            {
               _loc3_.splice(_loc2_,1);
               actions[action.getType()] = _loc3_;
               LogUtils.log("Removed action " + action,"InputSystem",1,"Input",false,false,true);
            }
         }
      }
      
      public function handleInputEvent(event:Event) : void
      {
         if(event is MouseEvent)
         {
            handleMouseEvent(event as MouseEvent);
         }
         else if(event is KeyboardEvent)
         {
            handleKeyboardEvent(event as KeyboardEvent);
         }
         else
         {
            handleEvent(event);
         }
      }
      
      private function handleMouseEvent(event:MouseEvent) : void
      {
         var _loc3_:Array = actions.hasOwnProperty(event.type) ? actions[event.type] : [];
         for each(var action in _loc3_)
         {
            action.execute(event);
         }
      }
      
      private function handleKeyboardEvent(event:KeyboardEvent) : void
      {
         var _loc3_:Array = actions.hasOwnProperty(event.type) ? actions[event.type] : [];
         for each(var action in _loc3_)
         {
            if(action.keyCode == event.keyCode || action.keyCode == -1)
            {
               action.execute(event);
            }
         }
      }
      
      private function handleEvent(event:Event) : void
      {
         var _loc3_:Array = actions.hasOwnProperty(event.type) ? actions[event.type] : [];
         for each(var action in _loc3_)
         {
            action.execute(event);
         }
      }
   }
}
