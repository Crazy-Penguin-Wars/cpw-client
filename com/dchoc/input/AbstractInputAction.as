package com.dchoc.input
{
   import flash.events.Event;
   
   public class AbstractInputAction implements InputAction
   {
       
      
      private var type:String;
      
      public function AbstractInputAction(type:String)
      {
         super();
         this.type = type;
      }
      
      public function dispose() : void
      {
      }
      
      public function execute(event:Event) : void
      {
      }
      
      public function getType() : String
      {
         return type;
      }
   }
}
