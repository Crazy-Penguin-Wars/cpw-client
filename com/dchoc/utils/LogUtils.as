package com.dchoc.utils
{
   import avmplus.*;
   import com.dchoc.game.*;
   import tuxwars.*;
   
   public class LogUtils
   {
      public static const CATEGORY_ALL:String = "All";
      
      private static const PERMANENT_DEBUG_LOG:Vector.<String> = new Vector.<String>();
      
      private static const DEBUG_LOG:Object = {};
      
      DEBUG_LOG[CATEGORY_ALL] = new Vector.<String>();
      
      public function LogUtils()
      {
         super();
         throw new Error("LogUtils is a static class!");
      }
      
      public static function clearCategory(param1:String) : void
      {
         if(DEBUG_LOG.hasOwnProperty(param1))
         {
            DEBUG_LOG[param1] = new Vector.<String>();
            if(param1 == CATEGORY_ALL)
            {
               createAllCategory();
            }
         }
      }
      
      public static function clearAll() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in DEBUG_LOG)
         {
            delete DEBUG_LOG[_loc1_];
         }
         createAllCategory();
      }
      
      private static function createAllCategory() : void
      {
         if(!DEBUG_LOG.hasOwnProperty(CATEGORY_ALL))
         {
            DEBUG_LOG[CATEGORY_ALL] = PERMANENT_DEBUG_LOG.slice(0,PERMANENT_DEBUG_LOG.length);
         }
      }
      
      public static function addDebugLine(param1:String, param2:String, param3:* = null) : void
      {
         var _loc4_:String = null;
         if(Boolean(DebugCategories.PROD_LOG[param1]) || Config.debugMode)
         {
            _loc4_ = param1 + " (" + DCGame.getTime() + "): " + param2 + (param3 != null ? " <Src:" + param3 + ">" : "");
            if(DebugCategories.PERMANENT_LOG[param1])
            {
               PERMANENT_DEBUG_LOG.push(_loc4_);
            }
            DEBUG_LOG[CATEGORY_ALL].push(_loc4_);
         }
      }
      
      public static function getLogCategory(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc2_:String = "";
         if(DEBUG_LOG.hasOwnProperty(param1))
         {
            for each(_loc3_ in DEBUG_LOG[param1])
            {
               _loc2_ += _loc3_ + "\n";
            }
         }
         return _loc2_;
      }
      
      public static function log(param1:*, param2:* = null, param3:int = 1, param4:String = "All", param5:Boolean = true, param6:Boolean = false, param7:Boolean = true) : void
      {
         if(param1 == null)
         {
            return;
         }
         param5 &&= param3 > 0;
         param6 &&= param3 > 0;
         if(param1.toString() == "[object Object]")
         {
            param1 = JSON.stringify(param1);
         }
         if(Boolean(DebugCategories.PROD_LOG[param4]) || Config.debugMode)
         {
            addDebugLine(param4,param1,param2);
            if(Config.debugMode)
            {
               doLog(param1,param2,param3,param5,param6,param7);
            }
         }
      }
      
      private static function doLog(param1:*, param2:* = null, param3:int = 1, param4:Boolean = true, param5:Boolean = false, param6:Boolean = true) : void
      {
         if(!Config.debugMode)
         {
            return;
         }
         if(param5)
         {
         }
         if(param4)
         {
         }
         if(Config.isDev() && param6)
         {
            trace(param2 != null ? param1 + " Source: " + param2 : param1);
         }
      }
      
      public static function getKeyNames(param1:Object) : String
      {
         var _loc3_:String = null;
         if(!param1)
         {
            return null;
         }
         var _loc2_:String = "";
         for(_loc3_ in param1)
         {
            _loc2_ += "<" + _loc3_ + ">\n";
         }
         return _loc2_;
      }
      
      public static function getValueNames(param1:Object) : String
      {
         var _loc3_:* = undefined;
         var _loc2_:String = "";
         for each(_loc3_ in param1)
         {
            _loc2_ += "<" + _loc3_ + ">\n";
         }
         return _loc2_;
      }
      
      public static function getObjectContent(param1:Object) : String
      {
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc2_:String = "";
         for(_loc3_ in param1)
         {
            _loc4_ = param1[_loc3_];
            if(getQualifiedClassName(_loc4_) == getQualifiedClassName(Object))
            {
               _loc2_ += "<" + _loc3_ + ": " + getObjectContent(_loc4_) + ">";
            }
            else if(_loc4_ is String)
            {
               _loc2_ += "<" + _loc3_ + ": " + _loc4_ + ">";
            }
            else
            {
               _loc2_ += "<" + _loc3_ + ": " + getQualifiedClassName(_loc4_) + ">";
            }
         }
         return _loc2_;
      }
   }
}

