package com.dchoc.game
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import flash.utils.getQualifiedClassName;
   
   public class LogicUpdater
   {
      
      private static var addList:Vector.<Object> = new Vector.<Object>();
      
      private static var activeList:Vector.<Object> = new Vector.<Object>();
      
      private static var removeList:Vector.<Object> = new Vector.<Object>();
       
      
      public function LogicUpdater()
      {
         super();
         throw new Error("LogicUpdater is a static class!");
      }
      
      public static function toString() : String
      {
         var s:String = "AddList: ";
         for each(var o1 in addList)
         {
            s += "<" + getQualifiedClassName(o1) + ">";
         }
         s += "\nActiveList: ";
         for each(var o2 in activeList)
         {
            s += "<" + getQualifiedClassName(o2) + ">";
         }
         s += "\nRemoveList: ";
         for each(var o3 in removeList)
         {
            s += "<" + getQualifiedClassName(o3) + ">";
         }
         return s + "\n";
      }
      
      public static function logicUpdate(deltaTime:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         try
         {
            while(removeList.length > 0)
            {
               _loc3_ = removeList.pop();
               _loc2_ = activeList.indexOf(_loc3_);
               if(_loc2_ != -1)
               {
                  activeList.splice(_loc2_,1);
               }
               else
               {
                  LogUtils.log("Trying to remove a non-existing object from active list: " + _loc3_,"LogicUpdater",2,"LogicUpdater");
               }
            }
            while(addList.length > 0)
            {
               activeList.push(addList.pop());
            }
            update(deltaTime);
         }
         catch(e:Error)
         {
            LogUtils.log(e.getStackTrace(),null,3,"LogicUpdater",true,true);
            MessageCenter.sendEvent(new ErrorMessage("LogicUpdater Exception","logicUpdate",e.message,null,e));
         }
      }
      
      private static function update(deltaTime:int) : void
      {
         try
         {
            for each(var registerdObject in activeList)
            {
               if(removeList.indexOf(registerdObject) == -1)
               {
                  registerdObject.logicUpdate(deltaTime);
               }
            }
         }
         catch(e:Error)
         {
            LogUtils.log(e.getStackTrace(),null,3,"LogicUpdater",false);
            MessageCenter.sendEvent(new ErrorMessage("LogicUpdater Exception","update","Registered Object: \'" + getQualifiedClassName(registerdObject) + "\' " + e.message,getQualifiedClassName(registerdObject),e));
         }
      }
      
      public static function register(object:Object, stringToDisplay:String = null) : void
      {
         removeFrom(object,removeList);
         if(addList.indexOf(object) != -1)
         {
            LogUtils.log("Object already in add list","LogicUpdater",2,"LogicUpdater",false,false,false);
            return;
         }
         if(activeList.indexOf(object) != -1)
         {
            LogUtils.log("Object already registerd","LogicUpdater",2,"LogicUpdater",false,false,false);
            return;
         }
         if(object.hasOwnProperty("logicUpdate"))
         {
            addList.push(object);
            LogUtils.log("Registering: " + (stringToDisplay == null ? getQualifiedClassName(object) : stringToDisplay) + " addList count:" + addList.length + " activeList count:" + activeList.length,"LogicUpdater",4,"LogicUpdater",false,false,false);
         }
         else
         {
            LogUtils.log("Object has no logicUpdate method to register","LogicUpdater",3,"LogicUpdater",false,true,true);
         }
      }
      
      public static function unregister(object:Object, stringToDisplay:String = null) : void
      {
         removeFrom(object,addList);
         removeList.push(object);
         LogUtils.log("Unregister: " + (stringToDisplay == null ? getQualifiedClassName(object) : stringToDisplay) + " removeList count:" + removeList.length,"LogicUpdater",4,"LogicUpdater",false,false,false);
      }
      
      private static function removeFrom(obj:Object, from:Vector.<Object>) : void
      {
         var _loc3_:int = from.indexOf(obj);
         if(_loc3_ != -1)
         {
            LogUtils.log("Removed " + obj + " from other list.","LogicUpdater",1,"LogicUpdater",false,false,false);
            from.splice(_loc3_,1);
         }
      }
   }
}
