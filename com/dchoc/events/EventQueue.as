package com.dchoc.events
{
   import flash.events.Event;
   
   public class EventQueue
   {
      private const events:Array = [];
      
      private const _addToQueue:Array = [];
      
      public function EventQueue()
      {
         super();
      }
      
      public function addToQueue(param1:Event) : void
      {
         this._addToQueue.push(param1);
      }
      
      public function hasEvents() : Boolean
      {
         return this.events.length > 0;
      }
      
      public function pop() : Event
      {
         return this.hasEvents() ? this.events.splice(0,1)[0] : null;
      }
      
      public function getEvents() : Array
      {
         return this.events;
      }
      
      public function processNewEvents() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._addToQueue)
         {
            this.events.push(_loc1_);
         }
         this._addToQueue.splice(0,this._addToQueue.length);
      }
   }
}

