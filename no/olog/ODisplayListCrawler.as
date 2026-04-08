package no.olog
{
   import flash.display.*;
   
   internal class ODisplayListCrawler
   {
      private static var _numInstances:uint;
      
      private static const TAB:String = " . ";
      
      public function ODisplayListCrawler()
      {
         super();
      }
      
      internal static function getTree(param1:DisplayObjectContainer, param2:uint = 0, param3:uint = 10, param4:String = null, param5:int = -1) : String
      {
         var _loc8_:DisplayObject = null;
         var _loc11_:* = null;
         var _loc6_:String = "";
         var _loc7_:String = "";
         var _loc9_:int = param1.numChildren;
         if(param2 == 0)
         {
            _numInstances = 1;
         }
         var _loc10_:int = int(param2);
         while(_loc10_ > 0)
         {
            _loc6_ += TAB;
            _loc10_--;
         }
         if(param5 != -1)
         {
            _loc11_ = param5 + ".";
         }
         else if(param1.parent)
         {
            _loc11_ = param1.parent.getChildIndex(param1) + ".";
         }
         else
         {
            _loc11_ = "X.";
         }
         _loc7_ += "\n" + _loc6_ + _loc11_ + param1.toString().match(/(?<=\s|\.)\w+(?=\]|$)/)[0] + _getPropertyValue(param1,param4);
         _loc6_ += TAB;
         var _loc12_:int = _loc9_ - 1;
         while(_loc12_ > -1)
         {
            ++_numInstances;
            _loc8_ = param1.getChildAt(_loc12_);
            if(_loc8_ is DisplayObjectContainer && param2 < param3 - 1)
            {
               _loc7_ += getTree(_loc8_ as DisplayObjectContainer,param2 + 1,param3,param4,_loc12_);
            }
            else
            {
               _loc7_ += "\n" + _loc6_ + _loc12_ + "." + _loc8_.toString().match(/(?<=\s|\.)\w+(?=\]|$)/)[0] + _getPropertyValue(_loc8_,param4);
            }
            _loc12_--;
         }
         return _loc7_;
      }
      
      private static function _getPropertyValue(param1:DisplayObject, param2:String = null) : String
      {
         var result:String;
         var isFunction:Boolean;
         var child:DisplayObject = param1;
         var property:String = param2;
         if(!property)
         {
            return "";
         }
         result = "";
         isFunction = false;
         if(property.indexOf("(") != -1)
         {
            property = property.substr(0,property.indexOf("("));
            isFunction = true;
         }
         if(Boolean(property) && Boolean(child.hasOwnProperty(property)))
         {
            if(!isFunction)
            {
               result = "." + property + " = " + child[property];
            }
            else
            {
               try
               {
                  result = "." + property + "() returned " + String(child[property]());
               }
               catch(e:Error)
               {
                  result = " ERROR " + property + "() expects arguments";
               }
            }
         }
         return result;
      }
      
      public static function get numInstances() : uint
      {
         return _numInstances;
      }
   }
}

