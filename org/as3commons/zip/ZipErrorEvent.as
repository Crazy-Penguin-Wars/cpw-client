package org.as3commons.zip
{
   import flash.events.Event;
   
   public class ZipErrorEvent extends Event
   {
      
      public static const PARSE_ERROR:String = "parseError";
       
      
      public var text:String;
      
      public function ZipErrorEvent(type:String, text:String = "", bubbles:Boolean = false, cancelable:Boolean = false)
      {
         this.text = text;
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new ZipErrorEvent(type,this.text,bubbles,cancelable);
      }
   }
}
