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
      
      public function addToQueue(event:Event) : void
      {
         _addToQueue.push(event);
      }
      
      public function hasEvents() : Boolean
      {
         return events.length > 0;
      }
      
      public function pop() : Event
      {
         return hasEvents() ? events.splice(0,1)[0] : null;
      }
      
      public function getEvents() : Array
      {
         return events;
      }
      
      public function processNewEvents() : void
      {
         for each(var event in _addToQueue)
         {
            events.push(event);
         }
         _addToQueue.splice(0,_addToQueue.length);
      }
   }
}
