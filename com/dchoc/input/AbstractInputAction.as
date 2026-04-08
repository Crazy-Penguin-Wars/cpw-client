package com.dchoc.input
{
   import flash.events.Event;
   
   public class AbstractInputAction implements InputAction
   {
      private var type:String;
      
      public function AbstractInputAction(param1:String)
      {
         super();
         this.type = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function execute(param1:Event) : void
      {
      }
      
      public function getType() : String
      {
         return this.type;
      }
   }
}

