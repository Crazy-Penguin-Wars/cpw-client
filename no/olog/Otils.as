package no.olog
{
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.system.*;
   import flash.utils.*;
   import no.olog.utilfunctions.*;
   
   internal class Otils
   {
      private static var _so:SharedObject;
      
      private static var _memUsageUpdater:Timer;
      
      public function Otils()
      {
         super();
      }
      
      internal static function parseMsgType(param1:Object) : String
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:String = getClassName(param1);
         var _loc3_:String = getClassName(param1,true);
         switch(_loc3_)
         {
            case "String":
               _loc4_ = param1 != "" ? String(param1) : Oplist.EMPTY_MSG_STRING;
               break;
            case "null":
               _loc4_ = "null";
               break;
            case "Number":
            case "int":
               _loc4_ = _parseNumberMessage(param1);
               break;
            case "XML":
            case "XMLList":
               _loc4_ = parseMsgType(param1.toXMLString());
               break;
            case "Array":
            case "Vector":
               _loc4_ = _parseArrayType(param1);
               break;
            case "Sprite":
               _loc4_ = _loc3_ + " (type:" + _loc2_ + ", name:" + param1.name + ")";
               break;
            case "MovieClip":
               _loc4_ = _loc3_ + " (type:" + _loc2_ + ", name:" + param1.name + ", frames:" + param1.totalFrames + ")";
               break;
            case "UncaughtErrorEvent":
               _loc4_ = "[UNCAUHGT] " + parseMsgType(param1.error);
               break;
            case "ErrorEvent":
               _loc4_ = "";
               _loc5_ = int(param1.text.indexOf("URL:"));
               if(_loc5_ != -1)
               {
                  _loc4_ += "File not found: " + param1.text.substr(_loc5_ + 5);
               }
               else
               {
                  _loc4_ += param1.text;
               }
               _loc4_ += " (" + _styleEventType(param1.type) + ")";
               if(param1.target)
               {
                  _loc4_ += Oplist.ORIGIN_DELIMITER + getClassName(param1.target);
               }
               if(param1.target != param1.currentTarget)
               {
                  _loc4_ += " (via " + getClassName(param1.currentTarget) + ")";
               }
               break;
            case "Event":
               _loc4_ = _loc2_ + "." + _styleEventType(param1.type);
               if(param1.target)
               {
                  _loc4_ += " from " + param1.target;
               }
               if(param1.target != param1.currentTarget)
               {
                  _loc4_ += " (via " + param1.currentTarget + "): ";
               }
               else
               {
                  _loc4_ += ": ";
               }
               _loc4_ += _parseProperties(param1);
               break;
            case "Error":
               _loc4_ = _loc2_ + _getClosestStackMethod(param1) + ": " + param1.message + " (id=" + param1.errorID + ")";
               break;
            default:
               _loc4_ = String(param1);
         }
         return _loc4_.replace(/</g,"&lt;").replace(/\>/g,"&gt;") || _loc4_;
      }
      
      private static function _parseArrayType(param1:Object) : String
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!Oplist.expandArrayItems)
         {
            return param1.join(", ") + " (" + param1.length + " items)";
         }
         _loc2_ = "[";
         _loc3_ = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1[_loc4_])
            {
               _loc2_ += parseMsgType(param1[_loc4_]);
               if(_loc4_ < _loc3_ - 1)
               {
                  _loc2_ += ", ";
               }
            }
            _loc4_++;
         }
         return _loc2_ + "]";
      }
      
      private static function _parseNumberMessage(param1:Object) : String
      {
         if(!isNaN(uint(param1)) && uint(param1).toString(16).length == 6)
         {
            return "0x" + uint(param1).toString(16);
         }
         return String(param1);
      }
      
      private static function _getClosestStackMethod(param1:Object) : String
      {
         return param1.getStackTrace().split("\n")[1].replace("\t"," ");
      }
      
      private static function _styleEventType(param1:String) : String
      {
         return param1.replace(/[A-Z]/,"_$&").toUpperCase();
      }
      
      private static function _parseProperties(param1:Object, param2:Boolean = false) : String
      {
         var _loc7_:XML = null;
         var _loc3_:* = "";
         var _loc4_:XMLList = describeType(param1).accessor;
         var _loc5_:int = int(_loc4_.length());
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = _loc4_[_loc6_];
            _loc3_ += _loc7_.@name;
            if(param2)
            {
               _loc3_ += ":" + _loc7_.@type;
            }
            _loc3_ += "=" + param1[_loc7_.@name];
            if(_loc6_ < _loc5_ - 1)
            {
               _loc3_ += ", ";
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      internal static function parseOrigin(param1:Object = null) : String
      {
         var _loc2_:String = param1 is String ? String(param1) : getClassName(param1);
         return _loc2_ != "null" ? _loc2_ : "";
      }
      
      internal static function getClassName(param1:Object, param2:Boolean = false) : String
      {
         var _loc3_:String = null;
         var _loc6_:XMLList = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(param1 == null)
         {
            return "null";
         }
         var _loc4_:XML = describeType(param1);
         var _loc5_:String = _extractClassOnly(_loc4_.@name);
         if(!param2 || Boolean(_isSupportedClass(_loc5_)))
         {
            _loc3_ = _loc5_;
         }
         else
         {
            _loc6_ = _loc4_.extendsClass;
            _loc7_ = int(_loc6_.length());
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc3_ = extractClassNameFromPackage(_loc6_[_loc8_].@type);
               if(_isSupportedClass(_loc3_))
               {
                  break;
               }
               _loc8_++;
            }
         }
         return _loc3_;
      }
      
      private static function extractClassNameFromPackage(param1:String) : String
      {
         if(param1.indexOf("::") != -1)
         {
            return param1.split("::")[1];
         }
         return param1;
      }
      
      private static function _isSupportedClass(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = int(Oplist.SUPPORTED_TYPES.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(Oplist.SUPPORTED_TYPES[_loc4_] == param1)
            {
               _loc2_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private static function _extractClassOnly(param1:String) : String
      {
         if(param1.indexOf(":") != -1)
         {
            return param1.split("::")[1];
         }
         return param1;
      }
      
      internal static function validateLevel(param1:int) : int
      {
         return Math.min(Math.max(param1,0),Oplist.TEXT_COLOR_LAST_INDEX);
      }
      
      internal static function getDefaultWindowBounds() : flash.geom.Rectangle
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:int = int(Oplist.PADDING);
         var _loc2_:int = _loc1_ * 2;
         var _loc3_:flash.geom.Rectangle = new Rectangle();
         _so = SharedObject.getLocal("OlogSettings");
         if(_so)
         {
            _loc4_ = Owindow.instance.stage.stageWidth - _loc2_;
            _loc5_ = Owindow.instance.stage.stageHeight - _loc2_;
            _loc6_ = int(uint(_so.data.width));
            _loc7_ = int(uint(_so.data.height));
            _loc3_.x = Math.max(uint(_so.data.x),_loc1_);
            _loc3_.y = Math.max(uint(_so.data.y),_loc1_);
            _loc3_.width = Math.min(_loc6_,_loc4_);
            _loc3_.height = Math.min(_loc7_,_loc5_);
         }
         else
         {
            _loc3_.x = Math.max(Oplist.x,_loc1_);
            _loc3_.y = Math.max(Oplist.y,_loc1_);
            _loc3_.width = Oplist.width != -1 ? Number(Oplist.width) : Number(Oplist.DEFAULT_WIDTH);
            _loc3_.height = Oplist.height != -1 ? Number(Oplist.height) : Number(Oplist.DEFAULT_HEIGHT);
         }
         return _loc3_;
      }
      
      internal static function getDaysSinceVersionCheck() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _so = SharedObject.getLocal("OlogSettings");
         if(_so)
         {
            _loc1_ = int(new Date().getTime());
            _loc2_ = int(_so.data.lastVersionCheck);
            return _loc2_ > 0 ? int(Math.floor((_loc1_ - _loc2_) / Oplist.DAY_IN_MS)) : int(Oplist.VERSION_CHECK_INTERVAL_DAYS);
         }
         return Oplist.VERSION_CHECK_INTERVAL_DAYS;
      }
      
      internal static function getSavedMinimizedState() : Boolean
      {
         _so = SharedObject.getLocal("OlogSettings");
         return !!_so ? Boolean(_so.data.isMinimized) : false;
      }
      
      internal static function getSavedOpenState() : Boolean
      {
         _so = SharedObject.getLocal("OlogSettings");
         return !!_so ? Boolean(_so.data.isOpen) : true;
      }
      
      internal static function recordWindowState() : void
      {
         if(!Oplist.rememberWindowState)
         {
            return;
         }
         if(!_so)
         {
            _so = SharedObject.getLocal("OlogSettings");
         }
         _so.data.x = Math.min(Math.max(0,Owindow.instance.x),Owindow.instance.stage.stageWidth);
         _so.data.y = Math.min(Math.max(0,Owindow.instance.y),Owindow.instance.stage.stageHeight);
         _so.data.width = Owindow.instance.width;
         _so.data.height = Owindow.instance.height;
         _so.data.isMinimized = Owindow.isMinimized;
         _so.data.isOpen = Owindow.isOpen;
         _so.data.showMemoryUsage = Oplist.showMemoryUsage;
         _savePersistentData();
      }
      
      internal static function recordVersionCheckTime() : void
      {
         if(!_so)
         {
            _so = SharedObject.getLocal("OlogSettings");
         }
         _so.data.lastVersionCheck = new Date().getTime();
         _savePersistentData();
      }
      
      private static function _savePersistentData() : void
      {
         var flushStatus:String = null;
         try
         {
            flushStatus = _so.flush();
         }
         catch(e:Error)
         {
            Olog.trace(e);
         }
      }
      
      internal static function formatTime(param1:int) : String
      {
         var _loc2_:Date = new Date(param1);
         var _loc3_:String = addLeadingZeroes(String(_loc2_.getMilliseconds()),3);
         var _loc4_:String = addLeadingZeroes(String(_loc2_.getSeconds()),2);
         var _loc5_:String = addLeadingZeroes(String(_loc2_.getMinutes()),2);
         var _loc6_:String = String(_loc2_.getHours() - 1);
         return _loc6_ + ":" + _loc5_ + ":" + _loc4_ + "\'" + _loc3_;
      }
      
      internal static function addLeadingZeroes(param1:String, param2:int = 2) : String
      {
         while(param1.length < param2)
         {
            param1 = "0" + param1;
         }
         return param1;
      }
      
      internal static function parseTypeAndLevel(param1:String, param2:uint) : int
      {
         switch(param1)
         {
            case "Error":
            case "ErrorEvent":
               return 3;
            case "Event":
               return 5;
            default:
               return validateLevel(param2);
         }
      }
      
      internal static function getLevelColorAsUint(param1:uint) : uint
      {
         return uint("0x" + String(Oplist.TEXT_COLORS_HEX[param1]).substr(1));
      }
      
      internal static function getDescriptionOf(param1:Object, param2:Array = null) : String
      {
         var baseList:XMLList;
         var heritage:String;
         var numClasses:int;
         var curClass:int;
         var parsedVars:Dictionary;
         var accessorList:XMLList;
         var newLine:String = null;
         var separator:String = null;
         var result:String = null;
         var d:XML = null;
         var type:String = null;
         var propsArr:Array = null;
         var objectName:String = null;
         var varList:XMLList = null;
         var variables:String = null;
         var numParsedVars:int = 0;
         var varsTotal:int = 0;
         var varName:String = null;
         var curVar:int = 0;
         var p:String = null;
         var item:Object = null;
         var constList:XMLList = null;
         var constants:String = null;
         var numConst:int = 0;
         var curConst:int = 0;
         var v:XML = null;
         var className:String = null;
         var c:XML = null;
         var o:Object = param1;
         var limitProperties:Array = param2;
         newLine = "\n" + Oplist.LINE_START_TABS;
         separator = newLine + Ocore.colorTextLevel("-",0);
         result = "";
         d = describeType(o);
         type = getClassName(o);
         propsArr = new Array();
         if(d.@isDynamic)
         {
            propsArr.push("dynamic");
         }
         if(d.@isStatic)
         {
            propsArr.push("static");
         }
         if(d.@isFinal)
         {
            propsArr.push("final");
         }
         if(Boolean(o.hasOwnProperty("name")) && o.name != null)
         {
            objectName = " (" + o.name + ")";
         }
         else
         {
            objectName = "";
         }
         result += Ocore.colorTextLevel("Description of " + type + objectName,1);
         if(propsArr.length > 0)
         {
            result += Ocore.colorTextLevel(" (" + propsArr.join(", ") + ")",0);
         }
         baseList = d.extendsClass;
         heritage = "";
         numClasses = int(baseList.length());
         curClass = 0;
         while(curClass < numClasses)
         {
            heritage += extractClassNameFromPackage(baseList[curClass].@type);
            if(curClass < numClasses - 1)
            {
               heritage += "-";
            }
            curClass++;
         }
         result += newLine + newLine + Ocore.colorTextLevel("Inheritance tree: " + heritage,0);
         parsedVars = new Dictionary(true);
         varList = d.variable;
         accessorList = d.accessor.(@access == "readwrite" || @access == "readonly");
         if(varList.length() > 0)
         {
            varList.appendChild(accessorList);
         }
         else
         {
            varList = accessorList;
         }
         variables = "";
         numParsedVars = int(varList.length());
         varsTotal = int(varList.length());
         curVar = 0;
         while(curVar < numParsedVars)
         {
            v = varList[curVar];
            varName = v.@name;
            if(!limitProperties || limitProperties.indexOf(varName) != -1)
            {
               parsedVars[v.@name] = {
                  "name":v.@name,
                  "type":v.@type
               };
            }
            curVar++;
         }
         for(p in o)
         {
            if(!parsedVars[p])
            {
               varsTotal++;
               if(!limitProperties || limitProperties.indexOf(p) != -1)
               {
                  className = getQualifiedClassName(o[p]);
                  parsedVars[p] = {
                     "name":p,
                     "type":className
                  };
                  numParsedVars++;
               }
            }
         }
         for each(item in parsedVars)
         {
            variables += newLine + "var " + item.name + Ocore.colorTextLevel(":" + extractClassNameFromPackage(item.type),0) + "\t= " + o[item.name];
         }
         if(numParsedVars > 0)
         {
            result += separator + Ocore.colorTextLevel(variables,1);
         }
         constList = d.constant;
         constants = "";
         numConst = int(constList.length());
         curConst = 0;
         while(curConst < numConst)
         {
            varsTotal++;
            c = constList[curConst];
            if(!limitProperties || limitProperties.indexOf(String(c.@name)) != -1)
            {
               constants += "\n\tconst " + c.@name + Ocore.colorTextLevel(":" + extractClassNameFromPackage(c.@type),0) + "\t= " + o[c.@name];
            }
            curConst++;
         }
         if(numConst > 0)
         {
            result += separator + "\n\t" + Ocore.colorTextLevel(constants,1);
         }
         result += separator + newLine + Ocore.colorTextLevel(numParsedVars + " value(s) shown of total " + varsTotal + " found",0) + "\n";
         return result;
      }
      
      internal static function getLineStart(param1:int, param2:String, param3:String) : String
      {
         if(!Oplist.enableTimeStamp && !Oplist.enableLineNumbers && !Oplist.enableRunTime)
         {
            return "";
         }
         var _loc4_:String = "[";
         if(Oplist.enableLineNumbers)
         {
            _loc4_ += Otils.addLeadingZeroes(String(param1),3);
         }
         if(Oplist.enableTimeStamp)
         {
            _loc4_ += !!Oplist.enableLineNumbers ? Oplist.LINE_START_DELIMITER + param2 : param2;
         }
         if(Oplist.enableRunTime)
         {
            _loc4_ += Boolean(Oplist.enableTimeStamp) || Boolean(Oplist.enableLineNumbers) ? Oplist.LINE_START_DELIMITER + param3 : param3;
         }
         return _loc4_ + ("]" + Oplist.AFTER_LINE_START);
      }
      
      internal static function stopMemoryUsageUpdater() : void
      {
         if(_memUsageUpdater)
         {
            _memUsageUpdater.stop();
            _memUsageUpdater.removeEventListener(TimerEvent.TIMER,_updateMemoryUsage);
            _memUsageUpdater = null;
         }
      }
      
      internal static function startMemoryUsageUpdater() : void
      {
         if(Boolean(Oplist.showMemoryUsage) && !_memUsageUpdater)
         {
            _memUsageUpdater = new Timer(1000);
            _memUsageUpdater.addEventListener(TimerEvent.TIMER,_updateMemoryUsage);
            _memUsageUpdater.start();
         }
      }
      
      internal static function isPrimitive(param1:*) : Boolean
      {
         return param1 is String || param1 is Number || param1 is int || param1 is uint;
      }
      
      internal static function breakPoint(... rest) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:uint = uint(Oplist.MARKER_COLOR_INDEX);
         var _loc3_:String = "Breakpoint reached: " + getCallee(7);
         var _loc4_:int = int(rest.length);
         if(_loc4_ == 0)
         {
            Ocore.trace(_loc3_,_loc2_);
         }
         else if(_loc4_ == 1)
         {
            if(isPrimitive(rest[0]))
            {
               _loc3_ += ", " + parseMsgType(rest[_loc7_]);
               Ocore.trace(_loc3_,_loc2_);
            }
            else
            {
               Ocore.trace(_loc3_,_loc2_);
               Ocore.describe(rest[0],_loc2_);
            }
         }
         else
         {
            _loc5_ = true;
            _loc6_ = 1;
            while(_loc6_ < _loc4_)
            {
               if(!(rest[_loc6_] is String))
               {
                  _loc5_ = false;
                  break;
               }
               _loc6_++;
            }
            if(!isPrimitive(rest[0]) && _loc5_)
            {
               Ocore.trace(_loc3_,_loc2_);
               Ocore.describe(rest[0],_loc2_,null,rest.slice(1));
            }
            else
            {
               _loc7_ = 0;
               while(_loc7_ < _loc4_)
               {
                  _loc3_ += ", " + parseMsgType(rest[_loc7_]);
                  _loc7_++;
               }
               Ocore.trace(_loc3_,_loc2_);
            }
         }
      }
      
      private static function _updateMemoryUsage(param1:TimerEvent) : void
      {
         Owindow.displayMemoryUsage(Number((System.totalMemory * 9.54e-7).toFixed(1)));
      }
   }
}

