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
      
      public function Oline(param1:String, param2:uint, param3:String, param4:String, param5:String, param6:int, param7:String, param8:String, param9:Boolean = true, param10:Boolean = false)
      {
         super();
         this.msg = param1;
         this.level = param2;
         this.origin = param3;
         this.timestamp = param4;
         this.runtime = param5;
         this.index = param6;
         this.type = param7;
         this.supportedType = param8;
         this.useLineStart = param9;
         this.bypassValidation = param10;
      }
   }
}

