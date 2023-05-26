package com.dchoc.gameobjects
{
   import com.dchoc.data.GameData;
   import com.dchoc.data.GraphicsReference;
   import no.olog.utilfunctions.assert;
   
   public class GameObjectDef
   {
       
      
      private var _name:String;
      
      private var _objClass:Class;
      
      private var _graphics:GraphicsReference;
      
      private var _id:String;
      
      private var _tableName:String;
      
      public function GameObjectDef()
      {
         super();
      }
      
      public function loadDataConf(data:GameData) : void
      {
         assert("GameData is null.",true,data != null);
         _name = data.name;
         _id = data.id;
         _tableName = data.tableName;
         _graphics = data.graphics;
      }
      
      public function dispose() : void
      {
         _graphics = null;
      }
      
      public function get graphics() : GraphicsReference
      {
         return _graphics;
      }
      
      public function set graphics(value:GraphicsReference) : void
      {
         _graphics = value;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get objClass() : Class
      {
         return _objClass;
      }
      
      public function set objClass(value:Class) : void
      {
         _objClass = value;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function set id(value:String) : void
      {
         _id = value;
      }
      
      public function get tableName() : String
      {
         return _tableName;
      }
   }
}
