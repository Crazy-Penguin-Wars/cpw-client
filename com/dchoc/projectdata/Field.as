package com.dchoc.projectdata
{
   import mx.utils.StringUtil;
   import no.olog.utilfunctions.assert;
   import org.as3commons.lang.StringUtils;
   
   public class Field
   {
       
      
      public var name:String;
      
      private var _value;
      
      private var _row:Row;
      
      private var overrideValue;
      
      public function Field(row:Row, name:String, value:* = null)
      {
         super();
         _row = row;
         this.name = name;
         _value = value;
      }
      
      public function get row() : Row
      {
         return _row;
      }
      
      final public function get value() : *
      {
         return overrideValue != null ? overrideValue : _value;
      }
      
      public function set value(value:*) : void
      {
         _value = value;
      }
      
      public function get originalValue() : *
      {
         return _value;
      }
      
      public function override(value:*) : void
      {
         overrideValue = convertToPointer(value);
      }
      
      private function convertToPointer(value:*) : *
      {
         var stringValue:* = null;
         var _loc2_:Number = NaN;
         var array:* = null;
         var i:int = 0;
         var string:* = null;
         var stringArray:* = null;
         if(value is String)
         {
            stringValue = value as String;
            if(StringUtils.compareToIgnoreCase(stringValue,"true") == 0)
            {
               return true;
            }
            if(StringUtils.compareToIgnoreCase(stringValue,"false") == 0)
            {
               return false;
            }
            _loc2_ = parseFloat(stringValue);
            if(!isNaN(_loc2_))
            {
               return _loc2_;
            }
            array = stringValue.split(",");
            for(i = 0; i < array.length; )
            {
               string = array[i];
               if(string.substr(0,1) == "#")
               {
                  string = string.slice(1);
                  stringArray = string.split(".");
                  var _loc10_:* = stringArray[0];
                  var _loc8_:ProjectManager = ProjectManager;
                  var _loc11_:* = stringArray[1];
                  var _loc9_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc10_);
                  §§push(array);
                  §§push(i);
                  if(!_loc9_._cache[_loc11_])
                  {
                     var _loc12_:Row = com.dchoc.utils.DCUtils.find(_loc9_.rows,"id",_loc11_);
                     if(!_loc12_)
                     {
                        com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc11_ + "\' was found in table: \'" + _loc9_.name + "\'",_loc9_,3);
                     }
                     _loc9_._cache[_loc11_] = _loc12_;
                  }
                  §§pop()[§§pop()] = _loc9_._cache[_loc11_];
               }
               i++;
            }
            value = array.length > 1 ? array : array[0];
         }
         return value;
      }
      
      public function isArray() : Boolean
      {
         return _value is Array;
      }
      
      public function get asArray() : Array
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         if(_value is String)
         {
            _loc3_ = _value.split(",");
            _loc1_ = [];
            for each(var str in _loc3_)
            {
               _loc1_.push(StringUtil.trim(str));
            }
            return _loc1_;
         }
         return null;
      }
      
      public function get(index:int) : *
      {
         assert("Field is not an array.",true,isArray());
         assert("Field index out of bounds.",true,index >= 0 && index < _value.length);
         return _value[index];
      }
      
      public function get length() : int
      {
         assert("Field is not an array.",true,isArray());
         return _value.length;
      }
   }
}
