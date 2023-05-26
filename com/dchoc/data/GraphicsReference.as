package com.dchoc.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   
   public class GraphicsReference
   {
      
      private static const SWF:String = "SWF";
      
      private static const EXPORT:String = "Export";
       
      
      private var _swf:String;
      
      private var _export:String;
      
      private var _fieldCache:Object;
      
      private var _row:Row;
      
      public function GraphicsReference(row:Row)
      {
         super();
         _fieldCache = {};
         _row = row;
      }
      
      public function get row() : Row
      {
         return _row;
      }
      
      public function get swf() : String
      {
         if(_swf)
         {
            return _swf;
         }
         var _loc1_:Field = getField("SWF");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
      
      public function set swf(value:String) : void
      {
         _swf = value;
      }
      
      public function get export() : String
      {
         if(_export)
         {
            return _export;
         }
         var _loc1_:Field = getField("Export");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
      
      public function set export(value:String) : void
      {
         _export = value;
      }
      
      private function getField(name:String) : Field
      {
         var _loc2_:* = null;
         if(!_fieldCache.hasOwnProperty(name))
         {
            var _loc4_:* = name;
            var _loc3_:Row = row;
            if(!_loc3_._cache[_loc4_])
            {
               _loc3_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc4_);
            }
            _loc2_ = _loc3_._cache[_loc4_];
            if(!_loc2_)
            {
               LogUtils.log("Couldn\'t find field \'" + name + "\' from row \'" + row.id + "\'.","GraphicsReference",3,"Assets",false,false,true);
            }
            _fieldCache[name] = _loc2_;
         }
         return _fieldCache[name];
      }
      
      public function toString() : String
      {
         return "export:" + export + " swf:" + swf;
      }
   }
}
