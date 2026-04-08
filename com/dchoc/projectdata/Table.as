package com.dchoc.projectdata
{
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   
   public class Table
   {
      private const _cache:Object = {};
      
      private const __rows:Array = [];
      
      private var __name:String;
      
      public function Table(param1:String)
      {
         super();
         this.__name = param1;
      }
      
      final public function get _name() : String
      {
         return this.__name;
      }
      
      final public function get name() : String
      {
         return this.__name;
      }
      
      final public function get _rows() : Array
      {
         return this.__rows;
      }
      
      final public function get rows() : Array
      {
         return this.__rows;
      }
      
      public function addRow(param1:Row) : void
      {
         this.__rows.push(param1);
      }
      
      final public function getRow(param1:int) : Row
      {
         assert("Row index out of bounds.",true,param1 >= 0 && param1 < this.__rows.length);
         return this.__rows[param1];
      }
      
      public function get getCache() : Object
      {
         return this._cache;
      }
      
      public function set getCache(param1:Object) : void
      {
         this._cache = param1;
      }
      
      final public function findRow(param1:String) : Row
      {
         var _loc3_:* = undefined;
         var _loc2_:Row = null;
         if(!this._cache[param1])
         {
            _loc2_ = DCUtils.find(this.__rows,"id",param1);
            if(!_loc2_)
            {
               _loc3_ = this;
               LogUtils.log("No row with name: \'" + param1 + "\' was found in table: \'" + _loc3_.__name + "\'",this,3);
            }
            this._cache[param1] = _loc2_;
         }
         return this._cache[param1];
      }
   }
}

