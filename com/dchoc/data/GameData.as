package com.dchoc.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   import no.olog.utilfunctions.assert;
   
   public class GameData
   {
      
      private static const NAME:String = "Name";
      
      private static const GRAPHICS:String = "Graphics";
       
      
      private var _fieldCache:Object;
      
      private var _row:Row;
      
      protected var _graphics:GraphicsReference;
      
      public function GameData(row:Row)
      {
         super();
         assert("Row is null.",true,row != null);
         _fieldCache = {};
         _row = row;
      }
      
      public function get row() : Row
      {
         return _row;
      }
      
      protected function getField(name:String) : Field
      {
         if(!_fieldCache.hasOwnProperty(name))
         {
            var _loc3_:* = name;
            var _loc2_:Row = row;
            §§push(_fieldCache);
            §§push(name);
            if(!_loc2_._cache[_loc3_])
            {
               _loc2_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc3_);
            }
            §§pop()[§§pop()] = _loc2_._cache[_loc3_];
         }
         return _fieldCache[name];
      }
      
      public function get name() : String
      {
         var _loc1_:Field = getField("Name");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, ProjectManager.getText(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value)) : null;
      }
      
      public function get graphics() : GraphicsReference
      {
         var _loc1_:* = null;
         if(!_graphics)
         {
            _loc1_ = getField("Graphics");
            if(_loc1_ != null)
            {
               var _loc2_:* = getField("Graphics");
               _graphics = new GraphicsReference(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value);
            }
            else
            {
               _graphics = null;
               LogUtils.log("Field named: Graphics is missing or empty for " + row.id,this,2,"LoadResource",false,false,false);
            }
         }
         return _graphics;
      }
      
      public function get id() : String
      {
         return row.id;
      }
      
      public function get tableName() : String
      {
         var _loc1_:Row = row;
         var _loc2_:* = _loc1_._table;
         return _loc2_._name;
      }
   }
}
