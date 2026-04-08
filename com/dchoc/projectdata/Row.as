package com.dchoc.projectdata
{
   import com.dchoc.utils.*;
   
   public class Row
   {
      private const _cache:Object = {};
      
      private const _fields:Array = [];
      
      public var id:String;
      
      private var _table:Table;
      
      public function Row(param1:String, param2:Table)
      {
         super();
         this.id = param1;
         this._table = param2;
      }
      
      final public function get table() : Table
      {
         return this._table;
      }
      
      final public function get fields() : Array
      {
         return this._fields;
      }
      
      public function addField(param1:Field) : void
      {
         this._fields.push(param1);
      }
      
      public function get getCache() : Object
      {
         return this._cache;
      }
      
      public function set getCache(param1:Object) : void
      {
         this._cache = param1;
      }
      
      public function getFields() : Object
      {
         return this._fields;
      }
      
      final public function findField(param1:String) : Field
      {
         if(!this._cache[param1])
         {
            this._cache[param1] = DCUtils.find(this._fields,"name",param1);
         }
         return this._cache[param1];
      }
   }
}

