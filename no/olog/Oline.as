package no.olog
{
   public class Oline
   {
       
      
      public var msg:String;
      
      public var level:uint;
      
      public var origin:String;
      
      public var timestamp:String;
      
      public var runtime:String;
      
      public var index:int;
      
      public var type:String;
      
      public var supportedType:String;
      
      public var useLineStart:Boolean;
      
      public var repeatCount:int = 1;
      
      public var bypassValidation:Boolean;
      
      public var isTruncated:Boolean;
      
      public var truncationEnabled:Boolean;
      
      public function Oline(msg:String, level:uint, origin:String, timestamp:String, runtime:String, index:int, type:String, supportedType:String, useLineStart:Boolean = true, bypassValidation:Boolean = false)
      {
         super();
         this.msg = msg;
         this.level = level;
         this.origin = origin;
         this.timestamp = timestamp;
         this.runtime = runtime;
         this.index = index;
         this.type = type;
         this.supportedType = supportedType;
         this.useLineStart = useLineStart;
         this.bypassValidation = bypassValidation;
      }
   }
}
