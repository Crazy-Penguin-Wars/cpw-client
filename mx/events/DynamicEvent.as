package mx.events
{
   import flash.events.Event;
   import mx.core.mx_internal;
   
   public dynamic class DynamicEvent extends Event
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
       
      
      public function DynamicEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         var p:* = null;
         var event:DynamicEvent = new DynamicEvent(type,bubbles,cancelable);
         for(p in this)
         {
            event[p] = this[p];
         }
         return event;
      }
   }
}
