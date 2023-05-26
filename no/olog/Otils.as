package no.olog
{
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.net.SharedObject;
   import flash.system.System;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   import no.olog.utilfunctions.getCallee;
   
   internal class Otils
   {
      
      private static var _so:SharedObject;
      
      private static var _memUsageUpdater:Timer;
       
      
      public function Otils()
      {
         super();
      }
      
      internal static function parseMsgType(message:Object) : String
      {
         var result:* = null;
         var urlPos:int = 0;
         var className:String = getClassName(message);
         var classNameSupported:String = getClassName(message,true);
         switch(classNameSupported)
         {
            case "String":
               result = message != "" ? String(message) : "[empty message]";
               break;
            case "null":
               result = "null";
               break;
            case "Number":
            case "int":
               result = _parseNumberMessage(message);
               break;
            case "XML":
            case "XMLList":
               result = parseMsgType(message.toXMLString());
               break;
            case "Array":
            case "Vector":
               result = _parseArrayType(message);
               break;
            case "Sprite":
               result = classNameSupported + " (type:" + className + ", name:" + message.name + ")";
               break;
            case "MovieClip":
               result = classNameSupported + " (type:" + className + ", name:" + message.name + ", frames:" + message.totalFrames + ")";
               break;
            case "UncaughtErrorEvent":
               result = "[UNCAUHGT] " + parseMsgType(message.error);
               break;
            case "ErrorEvent":
               result = "";
               urlPos = int(message.text.indexOf("URL:"));
               if(urlPos != -1)
               {
                  result += "File not found: " + message.text.substr(urlPos + 5);
               }
               else
               {
                  result += message.text;
               }
               result += " (" + _styleEventType(message.type) + ")";
               if(message.target)
               {
                  result += " › " + getClassName(message.target);
               }
               if(message.target != message.currentTarget)
               {
                  result += " (via " + getClassName(message.currentTarget) + ")";
                  break;
               }
               break;
            case "Event":
               result = className + "." + _styleEventType(message.type);
               if(message.target)
               {
                  result += " from " + message.target;
               }
               if(message.target != message.currentTarget)
               {
                  result += " (via " + message.currentTarget + "): ";
               }
               else
               {
                  result += ": ";
               }
               result += _parseProperties(message);
               break;
            case "Error":
               result = className + _getClosestStackMethod(message) + ": " + message.message + " (id=" + message.errorID + ")";
               break;
            case "Object":
               result = JSON.stringify(message);
               break;
            default:
               result = String(message);
         }
         return result.replace(/</g,"&lt;").replace(/\>/g,"&gt;") || result;
      }
      
      private static function _parseArrayType(message:Object) : String
      {
         var result:* = null;
         var num:int = 0;
         var i:int = 0;
         if(!Oplist.expandArrayItems)
         {
            return message.join(", ") + " (" + message.length + " items)";
         }
         result = "[";
         num = int(message.length);
         for(i = 0; i < num; )
         {
            if(message[i])
            {
               result += parseMsgType(message[i]);
               if(i < num - 1)
               {
                  result += ", ";
               }
            }
            i++;
         }
         return result + "]";
      }
      
      private static function _parseNumberMessage(message:Object) : String
      {
         if(!isNaN(uint(message)) && uint(message).toString(16).length == 6)
         {
            return "0x" + uint(message).toString(16);
         }
         return String(message);
      }
      
      private static function _getClosestStackMethod(message:Object) : String
      {
         return message.getStackTrace().split("\n")[1].replace("\t"," ");
      }
      
      private static function _styleEventType(type:String) : String
      {
         return type.replace(/[A-Z]/,"_$&").toUpperCase();
      }
      
      private static function _parseProperties(message:Object, includeType:Boolean = false) : String
      {
         var i:int = 0;
         var p:* = null;
         var result:String = "";
         var props:XMLList = describeType(message).accessor;
         var num:int = props.length();
         for(i = 0; i < num; )
         {
            p = props[i];
            result += p.@name;
            if(includeType)
            {
               result += ":" + p.@type;
            }
            result += "=" + message[p.@name];
            if(i < num - 1)
            {
               result += ", ";
            }
            i++;
         }
         return result;
      }
      
      internal static function parseOrigin(origin:Object = null) : String
      {
         var result:String = origin is String ? String(origin) : getClassName(origin);
         return result != "null" ? result : "";
      }
      
      internal static function getClassName(o:Object, supported:Boolean = false) : String
      {
         var result:* = null;
         var inheritanceTree:* = null;
         var num:int = 0;
         var i:int = 0;
         if(o == null)
         {
            return "null";
         }
         var info:XML = describeType(o);
         var className:String = _extractClassOnly(info.@name);
         if(!supported || _isSupportedClass(className))
         {
            result = className;
         }
         else
         {
            inheritanceTree = info.extendsClass;
            num = inheritanceTree.length();
            for(i = 0; i < num; )
            {
               result = extractClassNameFromPackage(inheritanceTree[i].@type);
               if(_isSupportedClass(result))
               {
                  break;
               }
               i++;
            }
         }
         return result;
      }
      
      private static function extractClassNameFromPackage(packageString:String) : String
      {
         if(packageString.indexOf("::") != -1)
         {
            return packageString.split("::")[1];
         }
         return packageString;
      }
      
      private static function _isSupportedClass(name:String) : Boolean
      {
         var i:int = 0;
         var result:Boolean = false;
         var num:int = Oplist.SUPPORTED_TYPES.length;
         for(i = 0; i < num; )
         {
            if(Oplist.SUPPORTED_TYPES[i] == name)
            {
               result = true;
               break;
            }
            i++;
         }
         return result;
      }
      
      private static function _extractClassOnly(className:String) : String
      {
         if(className.indexOf(":") != -1)
         {
            return className.split("::")[1];
         }
         return className;
      }
      
      internal static function validateLevel(level:int) : int
      {
         return Math.min(Math.max(level,0),5);
      }
      
      internal static function getDefaultWindowBounds() : Rectangle
      {
         var fillScreenWidth:int = 0;
         var fillScreenHeight:int = 0;
         var restoredWidth:int = 0;
         var restoredHeight:int = 0;
         var paddingX2:int = 5 * 2;
         var b:Rectangle = new Rectangle();
         _so = SharedObject.getLocal("OlogSettings");
         if(_so)
         {
            var _loc8_:Owindow = Owindow;
            if(!no.olog.Owindow._i)
            {
               no.olog.Owindow._i = new no.olog.Owindow();
            }
            fillScreenWidth = Number(no.olog.Owindow._i.stage.stageWidth) - paddingX2;
            var _loc9_:Owindow = Owindow;
            if(!no.olog.Owindow._i)
            {
               no.olog.Owindow._i = new no.olog.Owindow();
            }
            fillScreenHeight = Number(no.olog.Owindow._i.stage.stageHeight) - paddingX2;
            restoredWidth = uint(_so.data.width);
            restoredHeight = uint(_so.data.height);
            b.x = Math.max(uint(_so.data.x),5);
            b.y = Math.max(uint(_so.data.y),5);
            b.width = Math.min(restoredWidth,fillScreenWidth);
            b.height = Math.min(restoredHeight,fillScreenHeight);
         }
         else
         {
            b.x = Math.max(Oplist.x,5);
            b.y = Math.max(Oplist.y,5);
            b.width = Oplist.width != -1 ? Oplist.width : 400;
            b.height = Oplist.height != -1 ? Oplist.height : 350;
         }
         return b;
      }
      
      internal static function getDaysSinceVersionCheck() : int
      {
         var now:int = 0;
         var then:int = 0;
         _so = SharedObject.getLocal("OlogSettings");
         if(_so)
         {
            now = new Date().getTime();
            then = int(_so.data.lastVersionCheck);
            return then > 0 ? Math.floor((now - then) / 86400000) : 7;
         }
         return 7;
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
         var _loc1_:Owindow = Owindow;
         §§push(_so.data);
         §§push(Math);
         §§push(Math);
         §§push(0);
         if(!no.olog.Owindow._i)
         {
            no.olog.Owindow._i = new no.olog.Owindow();
         }
         var _loc2_:Owindow = Owindow;
         §§push(§§pop().max(§§pop(),no.olog.Owindow._i.x));
         if(!no.olog.Owindow._i)
         {
            no.olog.Owindow._i = new no.olog.Owindow();
         }
         §§pop().x = §§pop().min(§§pop(),no.olog.Owindow._i.stage.stageWidth);
         var _loc3_:Owindow = Owindow;
         §§push(_so.data);
         §§push(Math);
         §§push(Math);
         §§push(0);
         if(!no.olog.Owindow._i)
         {
            no.olog.Owindow._i = new no.olog.Owindow();
         }
         var _loc4_:Owindow = Owindow;
         §§push(§§pop().max(§§pop(),no.olog.Owindow._i.y));
         if(!no.olog.Owindow._i)
         {
            no.olog.Owindow._i = new no.olog.Owindow();
         }
         §§pop().y = §§pop().min(§§pop(),no.olog.Owindow._i.stage.stageHeight);
         var _loc5_:Owindow = Owindow;
         §§push(_so.data);
         if(!no.olog.Owindow._i)
         {
            no.olog.Owindow._i = new no.olog.Owindow();
         }
         §§pop().width = no.olog.Owindow._i.width;
         var _loc6_:Owindow = Owindow;
         §§push(_so.data);
         if(!no.olog.Owindow._i)
         {
            no.olog.Owindow._i = new no.olog.Owindow();
         }
         §§pop().height = no.olog.Owindow._i.height;
         var _loc7_:Owindow = Owindow;
         _so.data.isMinimized = no.olog.Owindow._isMinimized;
         var _loc8_:Owindow = Owindow;
         _so.data.isOpen = !!no.olog.Owindow._i ? no.olog.Owindow._i.visible : false;
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
      
      internal static function formatTime(ms:int) : String
      {
         var d:Date = new Date(ms);
         var strms:String = addLeadingZeroes(String(d.getMilliseconds()),3);
         var strsec:String = addLeadingZeroes(String(d.getSeconds()),2);
         var strmin:String = addLeadingZeroes(String(d.getMinutes()),2);
         var strhrs:String = String(d.getHours() - 1);
         return strhrs + ":" + strmin + ":" + strsec + "\'" + strms;
      }
      
      internal static function addLeadingZeroes(numString:String, numZeroes:int = 2) : String
      {
         while(numString.length < numZeroes)
         {
            numString = "0" + numString;
         }
         return numString;
      }
      
      internal static function parseTypeAndLevel(supportedType:String, level:uint) : int
      {
         switch(supportedType)
         {
            case "Error":
               break;
            case "ErrorEvent":
               break;
            case "Event":
               return 5;
            default:
               return validateLevel(level);
         }
         return 3;
      }
      
      internal static function getLevelColorAsUint(level:uint) : uint
      {
         return uint("0x" + String(Oplist.TEXT_COLORS_HEX[level]).substr(1));
      }
      
      internal static function getDescriptionOf(o:Object, limitProperties:Array = null) : String
      {
         var objectName:* = null;
         var curClass:int = 0;
         var varName:* = null;
         var curVar:int = 0;
         var v:* = null;
         var className:* = null;
         var curConst:int = 0;
         var c:* = null;
         var separator:String = "\n\t" + Ocore.colorTextLevel("-",0);
         var result:String = "";
         var d:XML = describeType(o);
         var type:String = getClassName(o);
         var propsArr:Array = [];
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
         if(o.hasOwnProperty("name") && o.name != null)
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
         var baseList:XMLList = d.extendsClass;
         var heritage:String = "";
         var numClasses:int = baseList.length();
         for(curClass = 0; curClass < numClasses; )
         {
            heritage += extractClassNameFromPackage(baseList[curClass].@type);
            if(curClass < numClasses - 1)
            {
               heritage += "-";
            }
            curClass++;
         }
         result += "\n\t" + "\n\t" + Ocore.colorTextLevel("Inheritance tree: " + heritage,0);
         var parsedVars:Dictionary = new Dictionary(true);
         var varList:* = d.variable;
         var accessorList:* = d.accessor.(@access == "readwrite" || @access == "readonly");
         if(varList.length() > 0)
         {
            varList.appendChild(accessorList);
         }
         else
         {
            varList = accessorList;
         }
         var variables:String = "";
         var numParsedVars:int = int(varList.length());
         var varsTotal:int = int(varList.length());
         for(curVar = 0; curVar < numParsedVars; )
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
         for(var p in o)
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
         for each(var item in parsedVars)
         {
            variables += "\n\t" + "var " + item.name + Ocore.colorTextLevel(":" + extractClassNameFromPackage(item.type),0) + "\t= " + o[item.name];
         }
         if(numParsedVars > 0)
         {
            result += separator + Ocore.colorTextLevel(variables,1);
         }
         var constList:XMLList = d.constant;
         var constants:String = "";
         var numConst:int = constList.length();
         for(curConst = 0; curConst < numConst; )
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
         return result + (separator + "\n\t" + Ocore.colorTextLevel(numParsedVars + " value(s) shown of total " + varsTotal + " found",0) + "\n");
      }
      
      internal static function getLineStart(index:int, timestamp:String, runtime:String) : String
      {
         if(!Oplist.enableTimeStamp && !Oplist.enableLineNumbers && !Oplist.enableRunTime)
         {
            return "";
         }
         var result:String = "[";
         if(Oplist.enableLineNumbers)
         {
            result += Otils.addLeadingZeroes(String(index),3);
         }
         if(Oplist.enableTimeStamp)
         {
            result += Oplist.enableLineNumbers ? " " + timestamp : timestamp;
         }
         if(Oplist.enableRunTime)
         {
            result += Oplist.enableTimeStamp || Oplist.enableLineNumbers ? " " + runtime : runtime;
         }
         return result + "] ";
      }
      
      internal static function stopMemoryUsageUpdater() : void
      {
         if(_memUsageUpdater)
         {
            _memUsageUpdater.stop();
            _memUsageUpdater.removeEventListener("timer",_updateMemoryUsage);
            _memUsageUpdater = null;
         }
      }
      
      internal static function startMemoryUsageUpdater() : void
      {
         if(Oplist.showMemoryUsage && !_memUsageUpdater)
         {
            _memUsageUpdater = new Timer(1000);
            _memUsageUpdater.addEventListener("timer",_updateMemoryUsage);
            _memUsageUpdater.start();
         }
      }
      
      internal static function isPrimitive(value:*) : Boolean
      {
         return value is String || value is Number || value is int || value is uint;
      }
      
      internal static function breakPoint(... args) : void
      {
         var restArgsAllStrings:Boolean = false;
         var restArgIndex:int = 0;
         var i:int = 0;
         var msg:String = "Breakpoint reached: " + getCallee(7);
         var numArgs:int = int(args.length);
         if(numArgs == 0)
         {
            Ocore.trace(msg,9);
         }
         else if(numArgs == 1)
         {
            if(isPrimitive(args[0]))
            {
               msg += ", " + parseMsgType(args[i]);
               Ocore.trace(msg,9);
            }
            else
            {
               Ocore.trace(msg,9);
               Ocore.describe(args[0],9);
            }
         }
         else
         {
            restArgsAllStrings = true;
            for(restArgIndex = 1; restArgIndex < numArgs; )
            {
               if(!(args[restArgIndex] is String))
               {
                  restArgsAllStrings = false;
                  break;
               }
               restArgIndex++;
            }
            if(!isPrimitive(args[0]) && restArgsAllStrings)
            {
               Ocore.trace(msg,9);
               Ocore.describe(args[0],9,null,args.slice(1));
            }
            else
            {
               for(i = 0; i < numArgs; )
               {
                  msg += ", " + parseMsgType(args[i]);
                  i++;
               }
               Ocore.trace(msg,9);
            }
         }
      }
      
      private static function _updateMemoryUsage(e:TimerEvent) : void
      {
         Owindow.displayMemoryUsage(Number((System.totalMemory * 9.54e-7).toFixed(1)));
      }
   }
}
