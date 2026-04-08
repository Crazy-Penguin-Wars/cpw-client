package com.dchoc.game
{
   import com.dchoc.events.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.utils.*;
   
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
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc1_:* = "AddList: ";
         for each(_loc2_ in addList)
         {
            _loc1_ += "<" + getQualifiedClassName(_loc2_) + ">";
         }
         _loc1_ += "\nActiveList: ";
         for each(_loc3_ in activeList)
         {
            _loc1_ += "<" + getQualifiedClassName(_loc3_) + ">";
         }
         _loc1_ += "\nRemoveList: ";
         for each(_loc4_ in removeList)
         {
            _loc1_ += "<" + getQualifiedClassName(_loc4_) + ">";
         }
         return _loc1_ + "\n";
      }
      
      public static function logicUpdate(param1:int) : void
      {
         var deltaTime:int = param1;
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         //try
         //{
            while(removeList.length > 0)
            {
               _loc3_ = removeList.pop();
               _loc2_ = int(activeList.indexOf(_loc3_));
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
         //}
         //catch(e:Error)
         //{
         //   LogUtils.log(e.getStackTrace(),null,3,"LogicUpdater",true,true);
         //   MessageCenter.sendEvent(new ErrorMessage("LogicUpdater Exception","logicUpdate",e.message,null,e));
         //}
      }
      
      private static function update(param1:int) : void
      {
         var registerdObject:* = undefined;
         var deltaTime:int = param1;
         //try
         //{
            for each(registerdObject in activeList)
            {
               if(removeList.indexOf(registerdObject) == -1)
               {
                  registerdObject.logicUpdate(deltaTime);
               }
            }
         //}
         //catch(e:Error)
         //{
         //   LogUtils.log(e.getStackTrace(),null,3,"LogicUpdater",false);
         //   MessageCenter.sendEvent(new ErrorMessage("LogicUpdater Exception","update","Registered Object: \'" + getQualifiedClassName(registerdObject) + "\' " + e.message,getQualifiedClassName(registerdObject),e));
         //}
      }
      
      public static function register(param1:Object, param2:String = null) : void
      {
         removeFrom(param1,removeList);
         if(addList.indexOf(param1) != -1)
         {
            LogUtils.log("Object already in add list","LogicUpdater",2,"LogicUpdater",false,false,false);
            return;
         }
         if(activeList.indexOf(param1) != -1)
         {
            LogUtils.log("Object already registerd","LogicUpdater",2,"LogicUpdater",false,false,false);
            return;
         }
         if(param1.hasOwnProperty("logicUpdate"))
         {
            addList.push(param1);
            LogUtils.log("Registering: " + (param2 == null ? getQualifiedClassName(param1) : param2) + " addList count:" + addList.length + " activeList count:" + activeList.length,"LogicUpdater",4,"LogicUpdater",false,false,false);
         }
         else
         {
            LogUtils.log("Object has no logicUpdate method to register","LogicUpdater",3,"LogicUpdater",false,true,true);
         }
      }
      
      public static function unregister(param1:Object, param2:String = null) : void
      {
         removeFrom(param1,addList);
         removeList.push(param1);
         LogUtils.log("Unregister: " + (param2 == null ? getQualifiedClassName(param1) : param2) + " removeList count:" + removeList.length,"LogicUpdater",4,"LogicUpdater",false,false,false);
      }
      
      private static function removeFrom(param1:Object, param2:Vector.<Object>) : void
      {
         var _loc3_:int = int(param2.indexOf(param1));
         if(_loc3_ != -1)
         {
            LogUtils.log("Removed " + param1 + " from other list.","LogicUpdater",1,"LogicUpdater",false,false,false);
            param2.splice(_loc3_,1);
         }
      }
   }
}

