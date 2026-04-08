package com.dchoc.resources
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   
   public class BatchLoader
   {
      private static var idCounter:int;
      
      public static const FILES_LOADED:String = "FilesLoaded";
      
      public static const LOAD_ERROR:String = "LoadError";
      
      private var _id:String;
      
      private var files:Array;
      
      public function BatchLoader(param1:Array)
      {
         super();
         this.files = param1.slice();
         this._id = idCounter.toString();
         ++idCounter;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function notifyListeners() : void
      {
         LogUtils.log("[MichiDebug] " + JSON.stringify(this.files),this,1,"Assets",true,false,true);
         if(this.files.length == 0)
         {
            DCResourceManager.instance.removeCustomEventListener("complete",this.fileLoaded);
            DCResourceManager.instance.removeCustomEventListener("error",this.fileLoaded);
            MessageCenter.sendMessage("FilesLoaded",this.id);
         }
      }
      
      public function load(param1:Boolean = false) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:Array = [];
         for each(_loc2_ in this.files)
         {
            if(DCResourceManager.instance.isLoaded(_loc2_))
            {
               _loc4_.push(_loc2_);
            }
            else
            {
               DCResourceManager.instance.addCustomEventListener("complete",this.fileLoaded,_loc2_);
               DCResourceManager.instance.addCustomEventListener("error",this.error,_loc2_);
               DCResourceManager.instance.load(Config.getDataDir() + _loc2_,_loc2_,null,true,param1);
            }
         }
         for each(_loc3_ in _loc4_)
         {
            this.files.splice(this.files.indexOf(_loc3_),1);
         }
         this.notifyListeners();
      }
      
      private function fileLoaded(param1:DCLoadingEvent) : void
      {
         var _loc2_:int = int(this.files.indexOf(param1.resourceName));
         if(_loc2_ != -1)
         {
            this.files.splice(_loc2_,1);
         }
         this.notifyListeners();
      }
      
      private function error(param1:DCLoadingEvent) : void
      {
         LogUtils.log("Failed to load: " + param1.resourceName,this,3,"Assets",true,false,true);
         DCResourceManager.instance.removeCustomEventListener("complete",this.fileLoaded);
         DCResourceManager.instance.removeCustomEventListener("error",this.fileLoaded);
         MessageCenter.sendMessage("LoadError",{
            "id":this.id,
            "resource":param1.resourceName
         });
      }
   }
}

