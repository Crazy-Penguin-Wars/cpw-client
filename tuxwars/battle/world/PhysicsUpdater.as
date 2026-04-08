package tuxwars.battle.world
{
   import com.dchoc.events.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.utils.*;
   import org.as3commons.lang.*;
   
   public class PhysicsUpdater
   {
      private static var needsSorting:Boolean;
      
      private static const addList:Array = [];
      
      private static const activeList:Array = [];
      
      private static const removeList:Array = [];
      
      public function PhysicsUpdater()
      {
         super();
         throw new Error("PhysicsUpdater is a static class!");
      }
      
      public static function dispose() : void
      {
         addList.splice(0,addList.length);
         activeList.splice(0,activeList.length);
         removeList.splice(0,removeList.length);
         needsSorting = false;
      }
      
      public static function physicsUpdate(param1:int) : void
      {
         var deltaTime:int = param1;
         var _loc3_:UpdateObject = null;
         var _loc2_:int = 0;
         try
         {
            while(removeList.length > 0)
            {
               _loc3_ = removeList.pop();
               _loc2_ = int(indexOfUpdateObject(activeList,_loc3_));
               if(_loc2_ != -1)
               {
                  activeList.splice(_loc2_,1);
                  needsSorting = true;
               }
               else
               {
                  LogUtils.log("Trying to remove a non-existing object from active list, obj: " + _loc3_,"PhysicsUpdater",2,"PhysicsUpdater");
               }
            }
            while(addList.length > 0)
            {
               activeList.push(addList.pop());
               needsSorting = true;
            }
            if(needsSorting)
            {
               sortActiveList();
               needsSorting = false;
               printActiveList();
            }
            update(deltaTime);
         }
         catch(e:Error)
         {
            LogUtils.log(e.getStackTrace(),null,3,"PhysicsUpdater",true,true);
            MessageCenter.sendEvent(new ErrorMessage("PhysicsUpdater Exception","physicsUpdate",e.message,null,e));
         }
      }
      
      private static function printActiveList() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:String = "";
         for each(_loc2_ in activeList)
         {
            _loc1_ += _loc2_.id + ", ";
         }
         LogUtils.log("PhysicsUpdater active list: " + _loc1_,"PhysicsUpdater",1,"PhysicsUpdater",false,false,false);
      }
      
      private static function indexOfUpdateObject(param1:Array, param2:UpdateObject) : int
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param1)
         {
            if(_loc3_.id == param2.id && _loc3_.object == param2.object)
            {
               return param1.indexOf(_loc3_);
            }
         }
         return -1;
      }
      
      public static function register(param1:Object, param2:String) : void
      {
         var _loc3_:UpdateObject = new UpdateObject(param1,param2);
         removeFrom(_loc3_,removeList);
         if(listContains(param1,addList))
         {
            LogUtils.log("Object already in add list","PhysicsUpdater",2,"PhysicsUpdater",false);
            return;
         }
         if(listContains(param1,activeList))
         {
            LogUtils.log("Object already registerd","PhysicsUpdater",2,"PhysicsUpdater",false);
            return;
         }
         if(param1.hasOwnProperty("physicsUpdate"))
         {
            addList.push(_loc3_);
            if(param2 == null)
            {
               LogUtils.log("Registering: " + getQualifiedClassName(param1) + " addList count:" + addList.length + " activeList count:" + activeList.length,"PhysicsUpdater",4,"PhysicsUpdater",false);
            }
            else
            {
               LogUtils.log("Registering: " + param2 + " addList count:" + addList.length + " activeList count:" + activeList.length,"PhysicsUpdater",4,"PhysicsUpdater",false);
            }
         }
         else
         {
            LogUtils.log("Object has no physicsUpdate method to register","PhysicsUpdater",2,"PhysicsUpdater",false);
         }
      }
      
      public static function unregister(param1:Object, param2:String = null) : void
      {
         var _loc3_:UpdateObject = new UpdateObject(param1,param2);
         removeFrom(_loc3_,addList);
         removeList.push(_loc3_);
         if(param2 == null)
         {
            LogUtils.log("Unregister: " + getQualifiedClassName(param1) + " removeList count:" + removeList.length,"PhysicsUpdater",4,"PhysicsUpdater",false);
         }
         else
         {
            LogUtils.log("Unregister: " + param2 + " removeList count:" + removeList.length,"PhysicsUpdater",4,"PhysicsUpdater",false);
         }
      }
      
      private static function sortActiveList() : void
      {
         activeList.sort(function(param1:UpdateObject, param2:UpdateObject):int
         {
            return StringUtils.compareTo(param1.id,param2.id);
         });
      }
      
      private static function update(param1:int) : void
      {
         var id:String = null;
         var registerdObject:* = undefined;
         var deltaTime:int = param1;
         id = null;
         try
         {
            for each(registerdObject in activeList)
            {
               if(removeList.indexOf(registerdObject) == -1)
               {
                  registerdObject.object.physicsUpdate(deltaTime);
               }
            }
         }
         catch(e:Error)
         {
            LogUtils.log(e.getStackTrace(),null,3,"PhysicsUpdater",false);
            id = "Unspecified";
            if(registerdObject)
            {
               if(registerdObject.hasOwnProperty("id"))
               {
                  id = registerdObject.id;
               }
               else
               {
                  id = getQualifiedClassName(registerdObject);
               }
            }
            MessageCenter.sendEvent(new ErrorMessage("PhysicsUpdater Exception","update","Registered Object: \'" + id + "\' " + e.message,id,e));
         }
      }
      
      private static function listContains(param1:Object, param2:Array) : Boolean
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param2)
         {
            if(_loc3_.object == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function removeFrom(param1:UpdateObject, param2:Array) : void
      {
         var _loc4_:* = undefined;
         var _loc3_:int = 0;
         for each(_loc4_ in param2)
         {
            if(_loc4_.object == param1.object)
            {
               _loc3_ = int(param2.indexOf(_loc4_));
               if(_loc3_ != -1)
               {
                  LogUtils.log("Removed " + param1 + " from other list.","PhysicsUpdater",1,"PhysicsUpdater");
                  param2.splice(_loc3_,1);
               }
               return;
            }
         }
      }
   }
}

class UpdateObject
{
   public var object:Object;
   
   public var id:String;
   
   public function UpdateObject(param1:Object, param2:String)
   {
      super();
      this.object = param1;
      this.id = param2;
   }
   
   public function toString() : String
   {
      return "id: " + this.id + " obj: " + this.object;
   }
}
