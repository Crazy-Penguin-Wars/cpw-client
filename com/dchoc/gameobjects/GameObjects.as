package com.dchoc.gameobjects
{
   import com.dchoc.game.DCGame;
   import com.dchoc.utils.LogUtils;
   import no.olog.utilfunctions.assert;
   
   public class GameObjects
   {
       
      
      public const gameObjects:Vector.<GameObject> = new Vector.<GameObject>();
      
      private var game:DCGame;
      
      private var _worldReady:Boolean;
      
      public function GameObjects(game:DCGame)
      {
         super();
         assert("GameObjects game",true,game != null);
         this.game = game;
      }
      
      public function worldReady() : void
      {
         if(!_worldReady)
         {
            for each(var gameObject in gameObjects)
            {
               gameObject.worldReady();
            }
            _worldReady = true;
         }
      }
      
      public function clear() : void
      {
         var i:int = 0;
         for(i = gameObjects.length - 1; i >= 0; )
         {
            removeGameObject(gameObjects[i]);
            i--;
         }
         gameObjects.splice(0,gameObjects.length);
      }
      
      public function sort(sorter:Function) : void
      {
         gameObjects.sort(sorter);
      }
      
      public function createGameObject(def:GameObjectDef) : *
      {
         assert("GameObjects#createGameObject def",true,def != null);
         var _loc3_:Class = def.objClass;
         var _loc2_:GameObject = new _loc3_(def,game);
         addGameObject(_loc2_);
         LogUtils.log("Created GameObject: " + _loc2_,this,1,"GameObjects",false,false,false);
         return _loc2_;
      }
      
      public function addGameObject(gameObject:GameObject) : void
      {
         gameObjects.push(gameObject);
         if(_worldReady)
         {
            gameObject.worldReady();
         }
      }
      
      public function get numGameObjects() : int
      {
         return gameObjects.length;
      }
      
      public function getGameObjectAt(index:int) : GameObject
      {
         if(index >= 0 && index < gameObjects.length)
         {
            return gameObjects[index];
         }
         return null;
      }
      
      public function findGameObjectByName(name:String) : GameObject
      {
         for each(var gameObject in gameObjects)
         {
            var _loc3_:* = gameObject;
            if(_loc3_._name == name)
            {
               return gameObject;
            }
         }
         return null;
      }
      
      public function findGameObjectById(id:String) : GameObject
      {
         for each(var gameObject in gameObjects)
         {
            var _loc3_:* = gameObject;
            if(_loc3_._id == id)
            {
               return gameObject;
            }
         }
         return null;
      }
      
      public function findGameObjectByUniqueId(id:String) : GameObject
      {
         for each(var gameObject in gameObjects)
         {
            var _loc3_:* = gameObject;
            if(_loc3_._uniqueId == id)
            {
               return gameObject;
            }
         }
         return null;
      }
      
      public function findGameObjectsbyClass(klazz:Class) : Vector.<GameObject>
      {
         var _loc2_:Vector.<GameObject> = new Vector.<GameObject>();
         for each(var gameObject in gameObjects)
         {
            if(gameObject is klazz)
            {
               _loc2_.push(gameObject);
            }
         }
         return _loc2_;
      }
      
      public function logicUpdate(deltaTime:int, removeMarked:Boolean = true) : void
      {
         updateGameObjects(deltaTime);
         if(removeMarked)
         {
            removeMarkedGameObjects();
         }
      }
      
      public function listGameObjects() : void
      {
         LogUtils.log("Listing Game Objects: " + gameObjects.length,"GameObjects",1,"GameObjects",false,false,true);
         for each(var gameObject in gameObjects)
         {
            LogUtils.log(gameObject.toString(),"GameObjects",1,"GameObjects",false,false,true);
         }
      }
      
      public function addEventListenersToGameDisplayObjects(events:Array, callBack:Function, setMouseEnabled:Boolean = false, traceAllObjects:Boolean = false) : void
      {
         for each(var event in events)
         {
            for each(var obj in gameObjects)
            {
               var _loc7_:* = obj;
               _loc7_._displayObject.addEventListener(event,callBack);
               if(traceAllObjects && Config.debugMode)
               {
                  var _loc8_:* = obj;
                  var _loc9_:* = obj;
                  LogUtils.log("ID: " + _loc8_._id + " TableName: " + _loc9_._tableName + " ObjClass: " + obj.objClass,this,0,"GameObjects",true,false,false);
               }
            }
            if(Config.debugMode)
            {
               LogUtils.log("Adding Event Listner:" + event + " to all GameObjects",this,0,"GameObjects",true,false,false);
            }
            traceAllObjects = false;
         }
      }
      
      public function removeEventListenersFromGameDisplayObjects(events:Array, callBack:Function, setMouseEnabled:Boolean = false) : void
      {
         for each(var event in events)
         {
            for each(var obj in gameObjects)
            {
               var _loc6_:* = obj;
               _loc6_._displayObject.removeEventListener(event,callBack);
            }
         }
      }
      
      public function findGameObjectsByTableAndId(tableName:String, id:String) : Array
      {
         var _loc3_:Array = [];
         for each(var obj in gameObjects)
         {
            var _loc5_:* = obj;
            if(_loc5_._tableName == tableName && _loc6_._id == id)
            {
               _loc3_.push(obj);
            }
         }
         return _loc3_;
      }
      
      private function sortById() : void
      {
         sort(function(obj1:GameObject, obj2:GameObject):int
         {
            var _loc3_:* = obj1;
            var _loc4_:* = obj2;
            return _loc3_._id.localeCompare(_loc4_._id);
         });
      }
      
      public function sortByUniqueId() : void
      {
         sort(function(obj1:GameObject, obj2:GameObject):int
         {
            var _loc3_:* = obj1;
            var _loc4_:* = obj2;
            return _loc3_._uniqueId.localeCompare(_loc4_._uniqueId);
         });
      }
      
      private function updateGameObjects(deltaTime:int) : void
      {
         for each(var gameObject in gameObjects)
         {
            gameObject.logicUpdate(deltaTime);
         }
      }
      
      public function removeMarkedGameObjects() : void
      {
         var i:int = 0;
         var _loc1_:* = null;
         for(i = gameObjects.length - 1; i >= 0; )
         {
            _loc1_ = gameObjects[i];
            var _loc3_:* = _loc1_;
            if(_loc3_._markedForRemoval)
            {
               LogUtils.log("Remove GameObject: " + _loc1_.shortName + " after markedForRemoval",this,0,"GameObjects",false,false,false);
               removeGameObject(_loc1_);
            }
            i--;
         }
      }
      
      private function removeGameObject(gameObject:GameObject) : void
      {
         var _loc2_:int = gameObjects.indexOf(gameObject);
         if(_loc2_ > -1)
         {
            gameObjects.splice(_loc2_,1);
            gameObject.dispose();
         }
      }
      
      public function gameObjectsExist(gameObjectType:Class) : int
      {
         var count:int = 0;
         for each(var gameObject in gameObjects)
         {
            if(gameObject is gameObjectType)
            {
               count++;
            }
         }
         return count;
      }
   }
}
