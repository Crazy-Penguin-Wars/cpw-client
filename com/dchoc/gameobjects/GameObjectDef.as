package com.dchoc.gameobjects
{
   import com.dchoc.data.GameData;
   import com.dchoc.data.GraphicsReference;
   import no.olog.utilfunctions.*;
   
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
      
      public function loadDataConf(param1:GameData) : void
      {
         assert("GameData is null.",true,param1 != null);
         this._name = param1.name;
         this._id = param1.id;
         this._tableName = param1.tableName;
         this._graphics = param1.graphics;
      }
      
      public function dispose() : void
      {
         this._graphics = null;
      }
      
      public function get graphics() : GraphicsReference
      {
         return this._graphics;
      }
      
      public function set graphics(param1:GraphicsReference) : void
      {
         this._graphics = param1;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get objClass() : Class
      {
         return this._objClass;
      }
      
      public function set objClass(param1:Class) : void
      {
         this._objClass = param1;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get tableName() : String
      {
         return this._tableName;
      }
   }
}

