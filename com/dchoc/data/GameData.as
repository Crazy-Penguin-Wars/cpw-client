package com.dchoc.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   
   public class GameData
   {
      private static const NAME:String = "Name";
      
      private static const GRAPHICS:String = "Graphics";
      
      private var _fieldCache:Object;
      
      private var _row:Row;
      
      protected var _graphics:GraphicsReference;
      
      public function GameData(param1:Row)
      {
         super();
         assert("Row is null.",true,param1 != null);
         this._fieldCache = {};
         this._row = param1;
      }
      
      public function get row() : Row
      {
         return this._row;
      }
      
      protected function getField(param1:String) : Field
      {
         var _loc2_:Row = null;
         if(!this._fieldCache.hasOwnProperty(param1))
         {
            _loc2_ = this.row;
            if(!_loc2_.getCache[param1])
            {
               _loc2_.getCache[param1] = DCUtils.find(_loc2_.getFields(),"name",param1);
            }
            this._fieldCache[param1] = _loc2_.getCache[param1];
         }
         return this._fieldCache[param1];
      }
      
      public function get name() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("Name");
         return !!_loc1_ ? (_loc2_ = _loc1_, ProjectManager.getText(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value)) : null;
      }
      
      public function get graphics() : GraphicsReference
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = null;
         if(!this._graphics)
         {
            _loc1_ = this.getField("Graphics");
            if(_loc1_ != null)
            {
               _loc2_ = this.getField("Graphics");
               this._graphics = new GraphicsReference(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value);
            }
            else
            {
               this._graphics = null;
               LogUtils.log("Field named: Graphics is missing or empty for " + this.row.id,this,2,"LoadResource",false,false,false);
            }
         }
         return this._graphics;
      }
      
      public function get id() : String
      {
         return this.row.id;
      }
      
      public function get tableName() : String
      {
         var _loc1_:Row = this.row;
         var _loc2_:* = _loc1_.table;
         return _loc2_._name;
      }
   }
}

