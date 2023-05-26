package no.olog
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.errors.IllegalOperationError;
   
   public class Olog extends Sprite
   {
      
      public static const LOCAL_CONNECTION_ID:String = "no.olog#localConnection";
       
      
      public function Olog()
      {
         super();
         throw new IllegalOperationError("Use static methods");
      }
      
      public static function set loggingEnabled(val:Boolean) : void
      {
         Oplist.loggingEnabled = val;
      }
      
      public static function get loggingEnabled() : Boolean
      {
         return Oplist.loggingEnabled;
      }
      
      public static function trace(message:*, level:uint = 1, origin:* = null) : void
      {
         if(Oplist.loggingEnabled)
         {
            Ocore.trace(message,level,origin);
         }
      }
      
      public static function describe(object:*, level:uint = 1, origin:* = null) : void
      {
         if(Oplist.loggingEnabled)
         {
            Ocore.describe(object,level,origin);
         }
      }
      
      public static function header(headerText:String, level:uint = 1) : void
      {
         if(Oplist.loggingEnabled)
         {
            Ocore.writeHeader(headerText,level);
         }
      }
      
      public static function cr(numLines:int = 1) : void
      {
         if(Oplist.loggingEnabled)
         {
            Ocore.writeNewline(numLines);
         }
      }
      
      public static function traceRuntimeInfo() : void
      {
         if(Oplist.loggingEnabled)
         {
            Ocore.traceRuntimeInfo();
         }
      }
      
      public static function addKeyBinding(keySequence:String, callback:Function) : void
      {
         Ocore.addKeyBinding(keySequence,callback);
      }
      
      public static function traceDisplayList(root:DisplayObjectContainer = null, maxDepth:uint = 10, property:String = null) : void
      {
         var msg:* = null;
         var footer:* = null;
         if(root)
         {
            §§push(root);
         }
         else
         {
            var _loc6_:Owindow = Owindow;
            if(!no.olog.Owindow._i)
            {
               no.olog.Owindow._i = new no.olog.Owindow();
            }
            §§push(no.olog.Owindow._i.stage);
         }
         root = §§pop();
         if(root)
         {
            msg = "DISPLAY LIST:\n" + ODisplayListCrawler.getTree(root,0,maxDepth,property) + "\n";
            var _loc7_:ODisplayListCrawler = ODisplayListCrawler;
            footer = "--------------------------\n" + no.olog.ODisplayListCrawler._numInstances + " instances total\n\n";
            Ocore.trace(msg + footer);
            return;
         }
         throw new IllegalOperationError("Unreachable root for Olog.traceDisplayList");
      }
      
      public static function setTruncation(truncateMultiline:Object = null, maxChars:Object = null) : void
      {
         if(truncateMultiline is Boolean)
         {
            Oplist.truncateMultiline = truncateMultiline as Boolean;
         }
         else
         {
            Oplist.truncateMultiline = false;
         }
         if(maxChars is int)
         {
            Oplist.maxUntruncatedLength = int(maxChars);
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
      
      public static function newTimeMarker(name:String = null, origin:Object = null, maxDurationMS:uint = 0) : int
      {
         if(Oplist.loggingEnabled)
         {
            return Ocore.newTimeMarker(name,origin,maxDurationMS);
         }
         return -1;
      }
      
      public static function completeTimeMarker(id:int) : void
      {
         if(Oplist.loggingEnabled)
         {
            Ocore.completeTimeMarker(id);
         }
      }
      
      public static function get window() : Owindow
      {
         var _loc1_:Owindow = Owindow;
         if(!no.olog.Owindow._i)
         {
            no.olog.Owindow._i = new no.olog.Owindow();
         }
         return no.olog.Owindow._i;
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
      
      public static function set password(val:String) : void
      {
         Ocore.setPassword(val);
      }
      
      public static function get password() : String
      {
         return Ocore.getPassword();
      }
      
      public static function set showMemoryUsage(val:Boolean) : void
      {
         Oplist.showMemoryUsage = val;
      }
      
      public static function get showMemoryUsage() : Boolean
      {
         return Oplist.showMemoryUsage;
      }
      
      public static function set memoryUsageLimitMB(val:uint) : void
      {
         Oplist.memoryUsageLimitMB = val;
         Ocore.trace("Memory usage limit is now " + val + " megabytes",1,"Olog");
      }
      
      public static function get memoryUsageLimitMB() : uint
      {
         return Oplist.memoryUsageLimitMB;
      }
      
      public static function set stackRepeatedMessages(val:Boolean) : void
      {
         Oplist.stackRepeatedMessages = val;
      }
      
      public static function get stackRepeatedMessages() : Boolean
      {
         return Oplist.stackRepeatedMessages;
      }
      
      public static function set scrollOnNewLine(val:Boolean) : void
      {
         Oplist.scrollOnNewLine = val;
      }
      
      public static function get scrollOnNewLine() : Boolean
      {
         return Oplist.scrollOnNewLine;
      }
      
      public static function set wrapLines(val:Boolean) : void
      {
         Owindow.setLineWrapping(val);
      }
      
      public static function get wrapLines() : Boolean
      {
         return Oplist.wrapLines;
      }
      
      public static function set keyboardEnabled(val:Boolean) : void
      {
         Ocore.setKeyboardEnabled(val);
      }
      
      public static function get keyboardEnabled() : Boolean
      {
         return Oplist.keyBoardEnabled;
      }
      
      public static function set contextMenuItem(val:Boolean) : void
      {
         Ocore.setCMI(val);
      }
      
      public static function get contextMenuItem() : Boolean
      {
         var _loc1_:Ocore = Ocore;
         return no.olog.Ocore._enableCMI;
      }
      
      public static function set rememberWindowState(val:Boolean) : void
      {
         Oplist.rememberWindowState = val;
      }
      
      public static function get rememberWindowState() : Boolean
      {
         return Oplist.rememberWindowState;
      }
      
      public static function set alwaysOnTop(val:Boolean) : void
      {
         Oplist.alwaysOnTop = val;
         Ocore.evalAlwaysOnTop();
      }
      
      public static function get alwaysOnTop() : Boolean
      {
         return Oplist.alwaysOnTop;
      }
      
      public static function resize(x:int = 0, y:int = 0, width:int = 0, height:int = 0) : void
      {
         Oplist.x = x;
         Oplist.y = y;
         Oplist.width = width;
         Oplist.height = height;
         Owindow.resizeToDefault();
      }
      
      public static function set timeStamp(val:Boolean) : void
      {
         Oplist.enableTimeStamp = val;
         Ocore.refreshLog();
      }
      
      public static function get timeStamp() : Boolean
      {
         return Oplist.enableTimeStamp;
      }
      
      public static function set runTime(val:Boolean) : void
      {
         Oplist.enableRunTime = val;
         Ocore.refreshLog();
      }
      
      public static function get runTime() : Boolean
      {
         return Oplist.enableRunTime;
      }
      
      public static function set lineNumbers(val:Boolean) : void
      {
         Oplist.enableLineNumbers = val;
         Ocore.refreshLog();
      }
      
      public static function get lineNumbers() : Boolean
      {
         return Oplist.enableLineNumbers;
      }
      
      public static function set colorizeColorStrings(val:Boolean) : void
      {
         Oplist.colorizeColorStrings = val;
         Ocore.refreshLog();
      }
      
      public static function get colorizeColorStrings() : Boolean
      {
         return Oplist.colorizeColorStrings;
      }
      
      public static function set expandArrayItems(val:Boolean) : void
      {
         Oplist.expandArrayItems = val;
      }
      
      public static function get expandArrayItems() : Boolean
      {
         return Oplist.expandArrayItems;
      }
      
      public static function breakPoint(... args) : void
      {
         Otils.breakPoint.apply(null,args);
      }
      
      public static function activateTargets(targets:Array) : void
      {
         Ocore.activateLogTargets(targets);
      }
   }
}
