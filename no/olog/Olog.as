package no.olog
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.errors.*;
   
   public class Olog extends Sprite
   {
      public static const LOCAL_CONNECTION_ID:String = "no.olog#localConnection";
      
      public function Olog()
      {
         super();
         throw new IllegalOperationError("Use static methods");
      }
      
      public static function set loggingEnabled(param1:Boolean) : void
      {
         Oplist.loggingEnabled = param1;
      }
      
      public static function get loggingEnabled() : Boolean
      {
         return Oplist.loggingEnabled;
      }
      
      public static function trace(param1:*, param2:uint = 1, param3:* = null) : void
      {
         if(Oplist.loggingEnabled)
         {
            Ocore.trace(param1,param2,param3);
         }
      }
      
      public static function describe(param1:*, param2:uint = 1, param3:* = null) : void
      {
         if(Oplist.loggingEnabled)
         {
            Ocore.describe(param1,param2,param3);
         }
      }
      
      public static function header(param1:String, param2:uint = 1) : void
      {
         if(Oplist.loggingEnabled)
         {
            Ocore.writeHeader(param1,param2);
         }
      }
      
      public static function cr(param1:int = 1) : void
      {
         if(Oplist.loggingEnabled)
         {
            Ocore.writeNewline(param1);
         }
      }
      
      public static function traceRuntimeInfo() : void
      {
         if(Oplist.loggingEnabled)
         {
            Ocore.traceRuntimeInfo();
         }
      }
      
      public static function addKeyBinding(param1:String, param2:Function) : void
      {
         Ocore.addKeyBinding(param1,param2);
      }
      
      public static function traceDisplayList(param1:DisplayObjectContainer = null, param2:uint = 10, param3:String = null) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         param1 = !!param1 ? param1 : Owindow.instance.stage;
         if(param1)
         {
            _loc4_ = "DISPLAY LIST:\n" + ODisplayListCrawler.getTree(param1,0,param2,param3) + "\n";
            _loc5_ = "--------------------------\n" + ODisplayListCrawler.numInstances + " instances total\n\n";
            Ocore.trace(_loc4_ + _loc5_);
            return;
         }
         throw new IllegalOperationError("Unreachable root for Olog.traceDisplayList");
      }
      
      public static function setTruncation(param1:Object = null, param2:Object = null) : void
      {
         if(param1 is Boolean)
         {
            Oplist.truncateMultiline = param1 as Boolean;
         }
         else
         {
            Oplist.truncateMultiline = false;
         }
         if(param2 is int)
         {
            Oplist.maxUntruncatedLength = int(param2);
         }
         else
         {
            Oplist.maxUntruncatedLength = -1;
         }
      }
      
      public static function checkForUpdates() : void
      {
         if(Oplist.loggingEnabled)
         {
            Ocore.checkForUpdates();
         }
      }
      
      public static function newTimeMarker(param1:String = null, param2:Object = null, param3:uint = 0) : int
      {
         if(Oplist.loggingEnabled)
         {
            return Ocore.newTimeMarker(param1,param2,param3);
         }
         return -1;
      }
      
      public static function completeTimeMarker(param1:int) : void
      {
         if(Oplist.loggingEnabled)
         {
            Ocore.completeTimeMarker(param1);
         }
      }
      
      public static function get window() : Owindow
      {
         return Owindow.instance;
      }
      
      public static function clear() : void
      {
         if(Oplist.loggingEnabled)
         {
            Owindow.clear();
         }
      }
      
      public static function open() : void
      {
         Owindow.open();
      }
      
      public static function close() : void
      {
         Owindow.close();
      }
      
      public static function maximize() : void
      {
         Owindow.maximize();
      }
      
      public static function minimize() : void
      {
         Owindow.minimize();
      }
      
      public static function set password(param1:String) : void
      {
         Ocore.setPassword(param1);
      }
      
      public static function get password() : String
      {
         return Ocore.getPassword();
      }
      
      public static function set showMemoryUsage(param1:Boolean) : void
      {
         Oplist.showMemoryUsage = param1;
      }
      
      public static function get showMemoryUsage() : Boolean
      {
         return Oplist.showMemoryUsage;
      }
      
      public static function set memoryUsageLimitMB(param1:uint) : void
      {
         Oplist.memoryUsageLimitMB = param1;
         Ocore.trace("Memory usage limit is now " + param1 + " megabytes",1,"Olog");
      }
      
      public static function get memoryUsageLimitMB() : uint
      {
         return Oplist.memoryUsageLimitMB;
      }
      
      public static function set stackRepeatedMessages(param1:Boolean) : void
      {
         Oplist.stackRepeatedMessages = param1;
      }
      
      public static function get stackRepeatedMessages() : Boolean
      {
         return Oplist.stackRepeatedMessages;
      }
      
      public static function set scrollOnNewLine(param1:Boolean) : void
      {
         Oplist.scrollOnNewLine = param1;
      }
      
      public static function get scrollOnNewLine() : Boolean
      {
         return Oplist.scrollOnNewLine;
      }
      
      public static function set wrapLines(param1:Boolean) : void
      {
         Owindow.setLineWrapping(param1);
      }
      
      public static function get wrapLines() : Boolean
      {
         return Oplist.wrapLines;
      }
      
      public static function set keyboardEnabled(param1:Boolean) : void
      {
         Ocore.setKeyboardEnabled(param1);
      }
      
      public static function get keyboardEnabled() : Boolean
      {
         return Oplist.keyBoardEnabled;
      }
      
      public static function set contextMenuItem(param1:Boolean) : void
      {
         Ocore.setCMI(param1);
      }
      
      public static function get contextMenuItem() : Boolean
      {
         return Ocore.hasCMI;
      }
      
      public static function set rememberWindowState(param1:Boolean) : void
      {
         Oplist.rememberWindowState = param1;
      }
      
      public static function get rememberWindowState() : Boolean
      {
         return Oplist.rememberWindowState;
      }
      
      public static function set alwaysOnTop(param1:Boolean) : void
      {
         Oplist.alwaysOnTop = param1;
         Ocore.evalAlwaysOnTop();
      }
      
      public static function get alwaysOnTop() : Boolean
      {
         return Oplist.alwaysOnTop;
      }
      
      public static function resize(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         Oplist.x = param1;
         Oplist.y = param2;
         Oplist.width = param3;
         Oplist.height = param4;
         Owindow.resizeToDefault();
      }
      
      public static function set timeStamp(param1:Boolean) : void
      {
         Oplist.enableTimeStamp = param1;
         Ocore.refreshLog();
      }
      
      public static function get timeStamp() : Boolean
      {
         return Oplist.enableTimeStamp;
      }
      
      public static function set runTime(param1:Boolean) : void
      {
         Oplist.enableRunTime = param1;
         Ocore.refreshLog();
      }
      
      public static function get runTime() : Boolean
      {
         return Oplist.enableRunTime;
      }
      
      public static function set lineNumbers(param1:Boolean) : void
      {
         Oplist.enableLineNumbers = param1;
         Ocore.refreshLog();
      }
      
      public static function get lineNumbers() : Boolean
      {
         return Oplist.enableLineNumbers;
      }
      
      public static function set colorizeColorStrings(param1:Boolean) : void
      {
         Oplist.colorizeColorStrings = param1;
         Ocore.refreshLog();
      }
      
      public static function get colorizeColorStrings() : Boolean
      {
         return Oplist.colorizeColorStrings;
      }
      
      public static function set expandArrayItems(param1:Boolean) : void
      {
         Oplist.expandArrayItems = param1;
      }
      
      public static function get expandArrayItems() : Boolean
      {
         return Oplist.expandArrayItems;
      }
      
      public static function breakPoint(... rest) : void
      {
         Otils.breakPoint.apply(null,rest);
      }
      
      public static function activateTargets(param1:Array) : void
      {
         Ocore.activateLogTargets(param1);
      }
   }
}

