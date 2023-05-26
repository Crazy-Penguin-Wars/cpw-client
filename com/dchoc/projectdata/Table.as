package com.dchoc.projectdata
{
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import no.olog.utilfunctions.assert;
   
   public class Table
   {
       
      
      private const _cache:Object = {};
      
      private const _rows:Array = [];
      
      private var _name:String;
      
      public function Table(name:String)
      {
         super();
         _name = name;
      }
      
      final public function get name() : String
      {
         return _name;
      }
      
      final public function get rows() : Array
      {
         return _rows;
      }
      
      public function addRow(row:Row) : void
      {
         _rows.push(row);
      }
      
      final public function getRow(index:int) : Row
      {
         assert("Row index out of bounds.",true,index >= 0 && index < this._rows.length);
         return this._rows[index];
      }
      
      final public function findRow(name:String) : Row
      {
         var _loc2_:* = null;
         if(!_cache[name])
         {
            _loc2_ = DCUtils.find(this._rows,"id",name);
            if(!_loc2_)
            {
               var _loc3_:* = this;
               LogUtils.log("No row with name: \'" + name + "\' was found in table: \'" + _loc3_._name + "\'",this,3);
            }
            _cache[name] = _loc2_;
         }
         return _cache[name];
      }
   }
}
