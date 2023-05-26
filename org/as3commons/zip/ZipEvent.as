package org.as3commons.zip
{
   import flash.events.Event;
   
   public class ZipEvent extends Event
   {
      
      public static const FILE_LOADED:String = "fileLoaded";
       
      
      public var file:ZipFile;
      
      public function ZipEvent(type:String, file:ZipFile = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this.file = file;
      }
      
      override public function clone() : Event
      {
         return new ZipEvent(type,this.file,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return "[ZipEvent type=\"" + type + "\" filename=\"" + this.file.filename + "\" bubbles=" + bubbles + " cancelable=" + cancelable + " eventPhase=" + eventPhase + "]";
      }
   }
}
