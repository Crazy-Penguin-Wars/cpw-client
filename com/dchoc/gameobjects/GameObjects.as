package com.dchoc.gameobjects
{
   import com.dchoc.game.DCGame;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   
   public class GameObjects
   {
      public const gameObjects:Vector.<GameObject> = new Vector.<GameObject>();
      
      private var game:DCGame;
      
      private var _worldReady:Boolean;
      
      public function GameObjects(param1:DCGame)
      {
         super();
         assert("GameObjects game",true,param1 != null);
         this.game = param1;
      }
      
      public function worldReady() : void
      {
         var _loc1_:* = undefined;
         if(!this._worldReady)
         {
            for each(_loc1_ in this.gameObjects)
            {
               _loc1_.worldReady();
            }
            this._worldReady = true;
         }
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         _loc1_ = int(this.gameObjects.length - 1);
         while(_loc1_ >= 0)
         {
            this.removeGameObject(this.gameObjects[_loc1_]);
            _loc1_--;
         }
         this.gameObjects.splice(0,this.gameObjects.length);
      }
      
      public function sort(param1:Function) : void
      {
         this.gameObjects.sort(param1);
      }
      
      public function createGameObject(param1:GameObjectDef) : *
      {
         assert("GameObjects#createGameObject def",true,param1 != null);
         var _loc2_:Class = param1.objClass;
         var _loc3_:GameObject = new _loc2_(param1,this.game);
         this.addGameObject(_loc3_);
         LogUtils.log("Created GameObject: " + _loc3_,this,1,"GameObjects",false,false,false);
         return _loc3_;
      }
      
      public function addGameObject(param1:GameObject) : void
      {
         this.gameObjects.push(param1);
         if(this._worldReady)
         {
            param1.worldReady();
         }
      }
      
      public function get numGameObjects() : int
      {
         return this.gameObjects.length;
      }
      
      public function getGameObjectAt(param1:int) : GameObject
      {
         if(param1 >= 0 && param1 < this.gameObjects.length)
         {
            return this.gameObjects[param1];
         }
         return null;
      }
      
      public function findGameObjectByName(param1:String) : GameObject
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         for each(_loc2_ in this.gameObjects)
         {
            _loc3_ = _loc2_;
            if(_loc3_._name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function findGameObjectById(param1:String) : GameObject
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         for each(_loc2_ in this.gameObjects)
         {
            _loc3_ = _loc2_;
            if(_loc3_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function findGameObjectByUniqueId(param1:String) : GameObject
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         for each(_loc2_ in this.gameObjects)
         {
            _loc3_ = _loc2_;
            if(_loc3_._uniqueId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function findGameObjectsbyClass(param1:Class) : Vector.<GameObject>
      {
         var _loc3_:* = undefined;
         var _loc2_:Vector.<GameObject> = new Vector.<GameObject>();
         for each(_loc3_ in this.gameObjects)
         {
            if(_loc3_ is param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function logicUpdate(param1:int, param2:Boolean = true) : void
      {
         this.updateGameObjects(param1);
         if(param2)
         {
            this.removeMarkedGameObjects();
         }
      }
      
      public function listGameObjects() : void
      {
         var _loc1_:* = undefined;
         LogUtils.log("Listing Game Objects: " + this.gameObjects.length,"GameObjects",1,"GameObjects",false,false,true);
         for each(_loc1_ in this.gameObjects)
         {
            LogUtils.log(_loc1_.toString(),"GameObjects",1,"GameObjects",false,false,true);
         }
      }
      
      public function addEventListenersToGameDisplayObjects(param1:Array, param2:Function, param3:Boolean = false, param4:Boolean = false) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         for each(_loc5_ in param1)
         {
            for each(_loc6_ in this.gameObjects)
            {
               _loc7_ = _loc6_;
               _loc7_.displayObject.addEventListener(_loc5_,param2);
               if(param4 && Config.debugMode)
               {
                  _loc8_ = _loc6_;
                  _loc9_ = _loc6_;
                  LogUtils.log("ID: " + _loc8_.id + " TableName: " + _loc9_.tableName + " ObjClass: " + _loc6_.objClass,this,0,"GameObjects",true,false,false);
               }
            }
            if(Config.debugMode)
            {
               LogUtils.log("Adding Event Listner:" + _loc5_ + " to all GameObjects",this,0,"GameObjects",true,false,false);
            }
            param4 = false;
         }
      }
      
      public function removeEventListenersFromGameDisplayObjects(param1:Array, param2:Function, param3:Boolean = false) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         for each(_loc4_ in param1)
         {
            for each(_loc5_ in this.gameObjects)
            {
               _loc6_ = _loc5_;
               _loc6_.displayObject.removeEventListener(_loc4_,param2);
            }
         }
      }
      
      public function findGameObjectsByTableAndId(param1:String, param2:String) : Array
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc3_:Array = [];
         for each(_loc4_ in this.gameObjects)
         {
            _loc5_ = _loc4_;
            if(_loc5_.tableName == param1 && _loc6_.id == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      private function sortById() : void
      {
         this.sort(function(param1:GameObject, param2:GameObject):int
         {
            var _loc3_:* = param1;
            var _loc4_:* = param2;
            return _loc3_.id.localeCompare(_loc4_.id);
         });
      }
      
      public function sortByUniqueId() : void
      {
         this.sort(function(param1:GameObject, param2:GameObject):int
         {
            var _loc3_:* = param1;
            var _loc4_:* = param2;
            return _loc3_._uniqueId.localeCompare(_loc4_._uniqueId);
         });
      }
      
      private function updateGameObjects(param1:int) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.gameObjects)
         {
            _loc2_.logicUpdate(param1);
         }
      }
      
      public function removeMarkedGameObjects() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:int = 0;
         var _loc2_:GameObject = null;
         _loc1_ = int(this.gameObjects.length - 1);
         while(_loc1_ >= 0)
         {
            _loc2_ = this.gameObjects[_loc1_];
            _loc3_ = _loc2_;
            if(_loc3_._markedForRemoval)
            {
               LogUtils.log("Remove GameObject: " + _loc2_.shortName + " after markedForRemoval",this,0,"GameObjects",false,false,false);
               this.removeGameObject(_loc2_);
            }
            _loc1_--;
         }
      }
      
      private function removeGameObject(param1:GameObject) : void
      {
         var _loc2_:int = int(this.gameObjects.indexOf(param1));
         if(_loc2_ > -1)
         {
            this.gameObjects.splice(_loc2_,1);
            param1.dispose();
         }
      }
      
      public function gameObjectsExist(param1:Class) : int
      {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         for each(_loc3_ in this.gameObjects)
         {
            if(_loc3_ is param1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
   }
}

