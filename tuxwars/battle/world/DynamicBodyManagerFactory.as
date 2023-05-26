package tuxwars.battle.world
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import no.olog.Olog;
   
   public class DynamicBodyManagerFactory extends EventDispatcher implements IEventDispatcher
   {
      
      private static const EXTRA_INFORMATION:Boolean = Config.debugMode;
      
      private static const TIMER_LOGIC_UPDATE_TIME:int = 1000;
      
      private static const TIMES_LOOP_COUNT:int = 1;
      
      private static const KEY:String = "ID";
      
      private static const VALUE:String = "Value";
      
      private static const CALL_BACK:String = "Call_Back";
      
      private static const ID_PREFIX:String = "ID_";
      
      private static var instance:DynamicBodyManagerFactory;
       
      
      private var idNumber:int = 0;
      
      private var timer:Timer;
      
      private var errorOccured:Boolean;
      
      private var managersInLoading:Vector.<Object>;
      
      private var removeBin:Vector.<Object>;
      
      private var managerCache:Object;
      
      public function DynamicBodyManagerFactory()
      {
         if(instance == null)
         {
            super();
            instance = this;
            managerCache = {};
            managersInLoading = new Vector.<Object>();
            removeBin = new Vector.<Object>();
            errorOccured = false;
         }
      }
      
      public static function getInstance() : DynamicBodyManagerFactory
      {
         if(instance == null)
         {
         }
         return instance;
      }
      
      public function dispose() : void
      {
         instance = null;
         DCUtils.deleteProperties(managerCache);
         if(managersInLoading)
         {
            managersInLoading.splice(0,managersInLoading.length);
         }
         if(removeBin)
         {
            removeBin.splice(0,removeBin.length);
         }
         if(timer)
         {
            timer.stop();
            timer = null;
         }
      }
      
      public function createManager(file:String, callBackOnLoad:Function) : String
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(isLoadingFile(file))
         {
            _loc4_ = findIdForLoadingManager(file);
            addEventListener(_loc4_,callBackOnLoad,false,0,true);
            return _loc4_;
         }
         if(hasLoadedFile(file))
         {
            _loc5_ = findIdForLoadedManager(file);
            callBackOnLoad(new TimerEvent(_loc5_));
            return _loc5_;
         }
         var _loc3_:String = "ID_" + getNewIdNumber();
         var _loc6_:Object = {};
         _loc6_["ID"] = _loc3_;
         _loc6_["Value"] = file;
         _loc6_["Call_Back"] = callBackOnLoad;
         managersInLoading.push(_loc6_);
         DCResourceManager.instance.addCustomEventListener("error",error,file);
         addEventListener(_loc3_,callBackOnLoad,false,0,true);
         startTimer(1000 / 10);
         return _loc3_;
      }
      
      public function getManager(id:String) : DynamicBodyManager
      {
         return managerCache[id] as DynamicBodyManager;
      }
      
      public function hasLoadedFile(file:String) : Boolean
      {
         for(var id in managerCache)
         {
            if(managerCache[id].getFile() == file)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isLoadingFile(file:String) : Boolean
      {
         for each(var obj in managersInLoading)
         {
            if(obj["Value"] == file)
            {
               return true;
            }
         }
         return false;
      }
      
      private function findIdForLoadingManager(file:String) : String
      {
         for each(var obj in managersInLoading)
         {
            if(obj["Value"] == file)
            {
               return obj["ID"];
            }
         }
         return null;
      }
      
      private function findIdForLoadedManager(file:String) : String
      {
         for(var id in managerCache)
         {
            if(managerCache[id].getFile() == file)
            {
               return id;
            }
         }
         return null;
      }
      
      private function getNewIdNumber() : int
      {
         idNumber++;
         return idNumber;
      }
      
      private function update(event:TimerEvent) : void
      {
         var removeObject:* = null;
         var index:int = 0;
         for each(var loadObject in managersInLoading)
         {
            if(updateLoading(loadObject))
            {
               removeBin.push(loadObject);
            }
         }
         while(removeBin.length > 0)
         {
            removeObject = removeBin.pop();
            index = managersInLoading.indexOf(removeObject);
            managersInLoading.splice(index,1);
         }
         if(managersInLoading.length > 0)
         {
            startTimer(1000);
         }
      }
      
      private function startTimer(time:int) : void
      {
         if(managersInLoading.length > 0)
         {
            if(timer == null)
            {
               timer = new Timer(1000,1);
               timer.addEventListener("timerComplete",update);
            }
            timer.reset();
            timer.delay = time;
            if(!errorOccured)
            {
               timer.start();
            }
            else
            {
               LogUtils.log("Error has Occured, not restarting timer!",this,2);
            }
         }
      }
      
      private function error(event:DCLoadingEvent) : void
      {
         errorOccured = true;
         if(timer != null && timer.running)
         {
            timer.stop();
         }
         if(Config.debugMode)
         {
            Olog.open();
         }
         var message:String = "Error loading file: " + event.resourceName;
         LogUtils.log(message,this,3);
         throw new Error(message);
      }
      
      private function updateLoading(loadObject:Object) : Boolean
      {
         var _loc2_:String = loadObject["ID"];
         var _loc4_:String = loadObject["Value"];
         var _loc3_:Boolean = DCResourceManager.instance.load(Config.getDataDir() + "dynamicobjects/" + _loc4_,_loc4_,"TextFile",false);
         var _loc5_:Boolean = !_loc3_;
         if(_loc5_)
         {
            if(managerCache == null)
            {
               managerCache = {};
            }
            managerCache[_loc2_] = new DynamicBodyManager(_loc2_,_loc4_);
            if(hasEventListener(_loc2_))
            {
               dispatchEvent(new TimerEvent(_loc2_));
               removeEventListener(_loc2_,loadObject["Call_Back"]);
            }
            else
            {
               LogUtils.log("No listener for event Id: " + _loc2_,this,2);
            }
            DCResourceManager.instance.removeCustomEventListener("error",error,_loc4_);
         }
         return _loc5_;
      }
   }
}
