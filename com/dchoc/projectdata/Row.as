package com.dchoc.projectdata
{
   import com.dchoc.utils.DCUtils;
   
   public class Row
   {
       
      
      private const _cache:Object = {};
      
      private const _fields:Array = [];
      
      public var id:String;
      
      private var _table:Table;
      
      public function Row(id:String, table:Table)
      {
         super();
         this.id = id;
         _table = table;
      }
      
      final public function get table() : Table
      {
         return _table;
      }
      
      final public function get fields() : Array
      {
         return _fields;
      }
      
      public function addField(field:Field) : void
      {
         _fields.push(field);
      }
      
      final public function findField(name:String) : Field
      {
         if(!_cache[name])
         {
            _cache[name] = DCUtils.find(_fields,"name",name);
         }
         return _cache[name];
      }
   }
}
