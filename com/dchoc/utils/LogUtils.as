package com.dchoc.utils
{
   import avmplus.getQualifiedClassName;
   import com.dchoc.game.DCGame;
   import no.olog.Olog;
   import tuxwars.DebugCategories;
   
   public class LogUtils
   {
      
      public static const CATEGORY_ALL:String = "All";
      
      private static const PERMANENT_DEBUG_LOG:Vector.<String> = new Vector.<String>();
      
      private static const DEBUG_LOG:Object = {};
      
      {
         DEBUG_LOG["All"] = new Vector.<String>();
      }
      
      public function LogUtils()
      {
         super();
         throw new Error("LogUtils is a static class!");
      }
      
      public static function clearCategory(category:String) : void
      {
         if(DEBUG_LOG.hasOwnProperty(category))
         {
            DEBUG_LOG[category] = new Vector.<String>();
            if(category == "All")
            {
               createAllCategory();
            }
         }
      }
      
      public static function clearAll() : void
      {
         for(var key in DEBUG_LOG)
         {
            delete DEBUG_LOG[key];
         }
         createAllCategory();
      }
      
      private static function createAllCategory() : void
      {
         if(!DEBUG_LOG.hasOwnProperty("All"))
         {
            DEBUG_LOG["All"] = PERMANENT_DEBUG_LOG.slice(0,PERMANENT_DEBUG_LOG.length);
         }
      }
      
      public static function addDebugLine(category:String, line:String, sourceObj:* = null) : void
      {
         var _loc4_:* = null;
         if(DebugCategories.PROD_LOG[category] || Config.debugMode)
         {
            _loc4_ = category + " (" + DCGame.getTime() + "): " + line + (sourceObj != null ? " <Src:" + sourceObj + ">" : "");
            if(DebugCategories.PERMANENT_LOG[category])
            {
               PERMANENT_DEBUG_LOG.push(_loc4_);
            }
            DEBUG_LOG["All"].push(_loc4_);
         }
      }
      
      public static function getLogCategory(category:String) : String
      {
         var _loc3_:* = undefined;
         var log:String = "";
         if(DEBUG_LOG.hasOwnProperty(category))
         {
            _loc3_ = DEBUG_LOG[category];
            for each(var line in _loc3_)
            {
               log += line + "\n";
            }
         }
         return log;
      }
      
      public static function log(message:*, sourceObj:* = null, level:int = 1, category:String = "All", toOlog:Boolean = true, openLogWindow:Boolean = false, traceConsole:Boolean = true) : void
      {
         if(message == null)
         {
            return;
         }
         toOlog = toOlog && level > 1;
         if(!toOlog && openLogWindow)
         {
            openLogWindow = false;
         }
         openLogWindow = openLogWindow && level > 2;
         if(message.toString() == "[object Object]")
         {
            message = JSON.stringify(message);
         }
         if(DebugCategories.PROD_LOG[category] || Config.debugMode)
         {
            addDebugLine(category,message,sourceObj);
            if(Config.debugMode)
            {
               doLog(message,sourceObj,level,toOlog,openLogWindow,traceConsole);
            }
         }
      }
      
      private static function doLog(message:*, sourceObj:String = "", level:int = 1, toOlog:Boolean = true, openLogWindow:Boolean = false, traceConsole:Boolean = true) : void
      {
         if(Config.debugMode)
         {
            if(openLogWindow)
            {
               Olog.open();
            }
            if(toOlog)
            {
               Olog.trace(message,level,sourceObj);
            }
            if(Config.isDev() && traceConsole)
            {
               if(sourceObj != null)
               {
                  trace(message + " Source: " + sourceObj);
               }
               else
               {
                  trace(message);
               }
            }
         }
      }
      
      public static function getKeyNames(obj:Object) : String
      {
         var s:* = null;
         if(obj)
         {
            s = "";
            for(var key in obj)
            {
               s += "<" + key + ">/n";
            }
         }
         return s;
      }
      
      public static function getValueNames(obj:Object) : String
      {
         var s:String = "";
         for each(var value in obj)
         {
            s += "<" + value + ">\n";
         }
         return s;
      }
      
      public static function getObjectContent(obj:Object) : String
      {
         var s:String = "";
         for(var key in obj)
         {
            if(getQualifiedClassName(obj[key]) == getQualifiedClassName(Object))
            {
               var _loc9_:* = obj[key];
               var _loc8_:String = "";
               var _loc5_:int = 0;
               var _loc4_:* = _loc9_;
               §§push(s);
               §§push("<" + key + ": ");
               for(var _loc10_ in _loc4_)
               {
                  if(avmplus.getQualifiedClassName(_loc9_[_loc10_]) == avmplus.getQualifiedClassName(Object))
                  {
                     _loc8_ += "<" + _loc10_ + ": " + com.dchoc.utils.LogUtils.getObjectContent(_loc9_[_loc10_]) + ">";
                  }
                  else if(_loc9_[_loc10_] is String)
                  {
                     _loc8_ += "<" + _loc10_ + ": " + _loc9_[_loc10_].toString() + ">";
                  }
                  else
                  {
                     _loc8_ += "<" + _loc10_ + ": " + avmplus.getQualifiedClassName(_loc9_[_loc10_]) + ">";
                  }
               }
               s = §§pop() + (§§pop() + _loc8_ + ">");
            }
            else if(obj[key] is String)
            {
               s += "<" + key + ": " + obj[key].toString() + ">";
            }
            else
            {
               s += "<" + key + ": " + getQualifiedClassName(obj[key]) + ">";
            }
         }
         return s;
      }
   }
}
