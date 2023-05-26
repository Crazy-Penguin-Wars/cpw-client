package tuxwars.battle.world
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import flash.utils.getQualifiedClassName;
   import org.as3commons.lang.StringUtils;
   
   public class PhysicsUpdater
   {
      
      private static const addList:Array = [];
      
      private static const activeList:Array = [];
      
      private static const removeList:Array = [];
      
      private static var needsSorting:Boolean;
       
      
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
      
      public static function physicsUpdate(deltaTime:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         try
         {
            while(removeList.length > 0)
            {
               _loc3_ = removeList.pop();
               _loc2_ = indexOfUpdateObject(activeList,_loc3_);
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
         var str:String = "";
         for each(var obj in activeList)
         {
            str += obj.id + ", ";
         }
         LogUtils.log("PhysicsUpdater active list: " + str,"PhysicsUpdater",1,"PhysicsUpdater",false,false,false);
      }
      
      private static function indexOfUpdateObject(list:Array, updateObject:UpdateObject) : int
      {
         for each(var listUpdateObject in list)
         {
            if(listUpdateObject.id == updateObject.id && listUpdateObject.object == updateObject.object)
            {
               return list.indexOf(listUpdateObject);
            }
         }
         return -1;
      }
      
      public static function register(object:Object, id:String) : void
      {
         var _loc3_:UpdateObject = new UpdateObject(object,id);
         removeFrom(_loc3_,removeList);
         if(listContains(object,addList))
         {
            LogUtils.log("Object already in add list","PhysicsUpdater",2,"PhysicsUpdater",false);
            return;
         }
         if(listContains(object,activeList))
         {
            LogUtils.log("Object already registerd","PhysicsUpdater",2,"PhysicsUpdater",false);
            return;
         }
         if(object.hasOwnProperty("physicsUpdate"))
         {
            addList.push(_loc3_);
            if(id == null)
            {
               LogUtils.log("Registering: " + getQualifiedClassName(object) + " addList count:" + addList.length + " activeList count:" + activeList.length,"PhysicsUpdater",4,"PhysicsUpdater",false);
            }
            else
            {
               LogUtils.log("Registering: " + id + " addList count:" + addList.length + " activeList count:" + activeList.length,"PhysicsUpdater",4,"PhysicsUpdater",false);
            }
         }
         else
         {
            LogUtils.log("Object has no physicsUpdate method to register","PhysicsUpdater",2,"PhysicsUpdater",false);
         }
      }
      
      public static function unregister(object:Object, id:String = null) : void
      {
         var _loc3_:UpdateObject = new UpdateObject(object,id);
         removeFrom(_loc3_,addList);
         removeList.push(_loc3_);
         if(id == null)
         {
            LogUtils.log("Unregister: " + getQualifiedClassName(object) + " removeList count:" + removeList.length,"PhysicsUpdater",4,"PhysicsUpdater",false);
         }
         else
         {
            LogUtils.log("Unregister: " + id + " removeList count:" + removeList.length,"PhysicsUpdater",4,"PhysicsUpdater",false);
         }
      }
      
      private static function sortActiveList() : void
      {
         activeList.sort(function(obj1:UpdateObject, obj2:UpdateObject):int
         {
            return StringUtils.compareTo(obj1.id,obj2.id);
         });
      }
      
      private static function update(deltaTime:int) : void
      {
         var id:* = null;
         try
         {
            for each(var registerdObject in activeList)
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
      
      private static function listContains(object:Object, list:Array) : Boolean
      {
         for each(var updateObject in list)
         {
            if(updateObject.object == object)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function removeFrom(obj:UpdateObject, from:Array) : void
      {
         var _loc3_:int = 0;
         for each(var updateObject in from)
         {
            if(updateObject.object == obj.object)
            {
               _loc3_ = from.indexOf(updateObject);
               if(_loc3_ != -1)
               {
                  LogUtils.log("Removed " + obj + " from other list.","PhysicsUpdater",1,"PhysicsUpdater");
                  from.splice(_loc3_,1);
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
   
   public function UpdateObject(object:Object, id:String)
   {
      super();
      this.object = object;
      this.id = id;
   }
   
   public function toString() : String
   {
      return "id: " + id + " obj: " + object;
   }
}
