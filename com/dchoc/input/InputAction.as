package com.dchoc.input
{
   import flash.events.Event;
   
   public interface InputAction
   {
       
      
      function execute(param1:Event) : void;
      
      function getType() : String;
   }
}
