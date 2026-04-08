package tuxwars.battle.world
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.events.*;
   import flash.utils.*;
   import no.olog.*;
   
   public class DynamicBodyManagerFactory extends EventDispatcher implements IEventDispatcher
   {
      private static var instance:DynamicBodyManagerFactory;
      
      private static const TIMER_LOGIC_UPDATE_TIME:int = 1000;
      
      private static const TIMES_LOOP_COUNT:int = 1;
      
      private static const KEY:String = "ID";
      
      private static const VALUE:String = "Value";
      
      private static const CALL_BACK:String = "Call_Back";
      
      private static const ID_PREFIX:String = "ID_";
      
      private static const EXTRA_INFORMATION:Boolean = Config.debugMode;
      
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
            this.managerCache = {};
            this.managersInLoading = new Vector.<Object>();
            this.removeBin = new Vector.<Object>();
            this.errorOccured = false;
         }
      }
      
      public static function getInstance() : DynamicBodyManagerFactory
      {
         if(instance == null)
         {
            new DynamicBodyManagerFactory();
         }
         return instance;
      }
      
      public function dispose() : void
      {
         instance = null;
         DCUtils.deleteProperties(this.managerCache);
         if(this.managersInLoading)
         {
            this.managersInLoading.splice(0,this.managersInLoading.length);
         }
         if(this.removeBin)
         {
            this.removeBin.splice(0,this.removeBin.length);
         }
         if(this.timer)
         {
            this.timer.stop();
            this.timer = null;
         }
      }
      
      public function createManager(param1:String, param2:Function) : String
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(this.isLoadingFile(param1))
         {
            _loc3_ = this.findIdForLoadingManager(param1);
            addEventListener(_loc3_,param2,false,0,true);
            return _loc3_;
         }
         if(this.hasLoadedFile(param1))
         {
            _loc4_ = this.findIdForLoadedManager(param1);
            param2(new TimerEvent(_loc4_));
            return _loc4_;
         }
         var _loc5_:String = "ID_" + this.getNewIdNumber();
         var _loc6_:Object = {};
         _loc6_["ID"] = _loc5_;
         _loc6_["Value"] = param1;
         _loc6_["Call_Back"] = param2;
         this.managersInLoading.push(_loc6_);
         DCResourceManager.instance.addCustomEventListener("error",this.error,param1);
         addEventListener(_loc5_,param2,false,0,true);
         this.startTimer(1000 / 10);
         return _loc5_;
      }
      
      public function getManager(param1:String) : DynamicBodyManager
      {
         return this.managerCache[param1] as DynamicBodyManager;
      }
      
      public function hasLoadedFile(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         for(_loc2_ in this.managerCache)
         {
            if(this.managerCache[_loc2_].getFile() == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isLoadingFile(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.managersInLoading)
         {
            if(_loc2_["Value"] == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function findIdForLoadingManager(param1:String) : String
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.managersInLoading)
         {
            if(_loc2_["Value"] == param1)
            {
               return _loc2_["ID"];
            }
         }
         return null;
      }
      
      private function findIdForLoadedManager(param1:String) : String
      {
         var _loc2_:* = undefined;
         for(_loc2_ in this.managerCache)
         {
            if(this.managerCache[_loc2_].getFile() == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getNewIdNumber() : int
      {
         ++this.idNumber;
         return this.idNumber;
      }
      
      private function update(param1:TimerEvent) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         for each(_loc4_ in this.managersInLoading)
         {
            if(this.updateLoading(_loc4_))
            {
               this.removeBin.push(_loc4_);
            }
         }
         while(this.removeBin.length > 0)
         {
            _loc2_ = this.removeBin.pop();
            _loc3_ = int(this.managersInLoading.indexOf(_loc2_));
            this.managersInLoading.splice(_loc3_,1);
         }
         if(this.managersInLoading.length > 0)
         {
            this.startTimer(1000);
         }
      }
      
      private function startTimer(param1:int) : void
      {
         if(this.managersInLoading.length > 0)
         {
            if(this.timer == null)
            {
               this.timer = new Timer(1000,1);
               this.timer.addEventListener("timerComplete",this.update);
            }
            this.timer.reset();
            this.timer.delay = param1;
            if(!this.errorOccured)
            {
               this.timer.start();
            }
            else
            {
               LogUtils.log("Error has Occured, not restarting timer!",this,2);
            }
         }
      }
      
      private function error(param1:DCLoadingEvent) : void
      {
         this.errorOccured = true;
         if(this.timer != null && Boolean(this.timer.running))
         {
            this.timer.stop();
         }
         if(Config.debugMode)
         {
            Olog.open();
         }
         var _loc2_:String = "Error loading file: " + param1.resourceName;
         LogUtils.log(_loc2_,this,3);
         throw new Error(_loc2_);
      }
      
      private function updateLoading(param1:Object) : Boolean
      {
         var _loc2_:String = param1["ID"];
         var _loc3_:String = param1["Value"];
         var _loc4_:Boolean = Boolean(DCResourceManager.instance.load(Config.getDataDir() + "dynamicobjects/" + _loc3_,_loc3_,"TextFile",false));
         var _loc5_:* = !_loc4_;
         if(_loc5_)
         {
            if(this.managerCache == null)
            {
               this.managerCache = {};
            }
            this.managerCache[_loc2_] = new DynamicBodyManager(_loc2_,_loc3_);
            if(hasEventListener(_loc2_))
            {
               dispatchEvent(new TimerEvent(_loc2_));
               removeEventListener(_loc2_,param1["Call_Back"]);
            }
            else
            {
               LogUtils.log("No listener for event Id: " + _loc2_,this,2);
            }
            DCResourceManager.instance.removeCustomEventListener("error",this.error,_loc3_);
         }
         return _loc5_;
      }
   }
}

