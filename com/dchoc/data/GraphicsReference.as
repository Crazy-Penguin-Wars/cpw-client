package com.dchoc.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class GraphicsReference
   {
      private static const SWF:String = "SWF";
      
      private static const EXPORT:String = "Export";
      
      private var _swf:String;
      
      private var _export:String;
      
      private var _fieldCache:Object;
      
      private var _row:Row;
      
      public function GraphicsReference(param1:Row)
      {
         super();
         this._fieldCache = {};
         this._row = param1;
      }
      
      public function get row() : Row
      {
         return this._row;
      }
      
      public function get swf() : String
      {
         var _loc2_:* = undefined;
         if(this._swf)
         {
            return this._swf;
         }
         var _loc1_:Field = this.getField("SWF");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
      
      public function set swf(param1:String) : void
      {
         this._swf = param1;
      }
      
      public function get export() : String
      {
         var _loc2_:* = undefined;
         if(this._export)
         {
            return this._export;
         }
         var _loc1_:Field = this.getField("Export");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
      
      public function set export(param1:String) : void
      {
         this._export = param1;
      }
      
      private function getField(param1:String) : Field
      {
         var _loc3_:* = undefined;
         var _loc4_:Row = null;
         var _loc2_:Field = null;
         if(!this._fieldCache.hasOwnProperty(param1))
         {
            _loc3_ = param1;
            _loc4_ = this.row;
            if(!_loc4_.getCache[_loc3_])
            {
               _loc4_.getCache[_loc3_] = DCUtils.find(_loc4_.getFields(),"name",_loc3_);
            }
            _loc2_ = _loc4_.getCache[_loc3_];
            if(!_loc2_)
            {
               LogUtils.log("Couldn\'t find field \'" + param1 + "\' from row \'" + this.row.id + "\'.","GraphicsReference",3,"Assets",false,false,true);
            }
            this._fieldCache[param1] = _loc2_;
         }
         return this._fieldCache[param1];
      }
      
      public function toString() : String
      {
         return "export:" + this.export + " swf:" + this.swf;
      }
   }
}

