package com.dchoc.projectdata
{
   import com.dchoc.utils.*;
   import mx.utils.*;
   import no.olog.utilfunctions.*;
   import org.as3commons.lang.*;
   
   public class Field
   {
      public var name:String;
      
      private var _value:*;
      
      private var _row:Row;
      
      private var _overrideValue:*;
      
      public function Field(param1:Row, param2:String, param3:* = null)
      {
         super();
         this._row = param1;
         this.name = param2;
         this._value = param3;
      }
      
      public function get row() : Row
      {
         return this._row;
      }
      
      final public function get overrideValue() : *
      {
         return this._overrideValue != null ? this._overrideValue : this._value;
      }
      
      public function set overrideValue(param1:*) : void
      {
         this._value = param1;
      }
      
      final public function get value() : *
      {
         return this._overrideValue != null ? this._overrideValue : this._value;
      }
      
      public function set value(param1:*) : void
      {
         this._value = param1;
      }
      
      public function get originalValue() : *
      {
         return this._value;
      }
      
      public function override(param1:*) : void
      {
         this._overrideValue = this.convertToPointer(param1);
      }
      
      private function convertToPointer(param1:*) : *
      {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Table = null;
         var _loc11_:Row = null;
         var _loc2_:String = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         if(param1 is String)
         {
            _loc2_ = param1 as String;
            if(StringUtils.compareToIgnoreCase(_loc2_,"true") == 0)
            {
               return true;
            }
            if(StringUtils.compareToIgnoreCase(_loc2_,"false") == 0)
            {
               return false;
            }
            _loc3_ = Number(parseFloat(_loc2_));
            if(!isNaN(_loc3_))
            {
               return _loc3_;
            }
            _loc4_ = _loc2_.split(",");
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc6_ = _loc4_[_loc5_];
               if(_loc6_.substr(0,1) == "#")
               {
                  _loc6_ = _loc6_.slice(1);
                  _loc7_ = _loc6_.split(".");
                  _loc8_ = _loc7_[0];
                  _loc9_ = _loc7_[1];
                  _loc10_ = ProjectManager.projectData.findTable(_loc8_);
                  if(!_loc10_.getCache[_loc9_])
                  {
                     _loc11_ = DCUtils.find(_loc10_.rows,"id",_loc9_);
                     if(!_loc11_)
                     {
                        LogUtils.log("No row with name: \'" + _loc9_ + "\' was found in table: \'" + _loc10_.name + "\'",_loc10_,3);
                     }
                     _loc10_.getCache[_loc9_] = _loc11_;
                  }
                  _loc4_[_loc5_] = _loc10_.getCache[_loc9_];
               }
               _loc5_++;
            }
            param1 = _loc4_.length > 1 ? _loc4_ : _loc4_[0];
         }
         return param1;
      }
      
      public function isArray() : Boolean
      {
         return this._value is Array;
      }
      
      public function get asArray() : Array
      {
         var _loc3_:* = undefined;
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         if(this._value is String)
         {
            _loc1_ = this._value.split(",");
            _loc2_ = [];
            for each(_loc3_ in _loc1_)
            {
               _loc2_.push(StringUtil.trim(_loc3_));
            }
            return _loc2_;
         }
         return null;
      }
      
      public function get(param1:int) : *
      {
         assert("Field is not an array.",true,this.isArray());
         assert("Field index out of bounds.",true,param1 >= 0 && param1 < this._value.length);
         return this._value[param1];
      }
      
      public function get length() : int
      {
         assert("Field is not an array.",true,this.isArray());
         return this._value.length;
      }
   }
}

