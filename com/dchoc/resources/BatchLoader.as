package com.dchoc.resources
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import flash.external.ExternalInterface;
   
   public class BatchLoader
   {
      private static var idCounter:int;
      
      public static const FILES_LOADED:String = "FilesLoaded";
      
      public static const LOAD_ERROR:String = "LoadError";
      
      private var _id:String;
      
      private var files:Array;
      
      public function BatchLoader(files:Array)
      {
         super();
         this.files = files.slice();
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
      
      public function load(useContextForSwf:Boolean = false) : void
      {
         var file:* = undefined;
         var alreadyLoadedFile:* = undefined;
         ExternalInterface.call("console.log",JSON.stringify(this.files));
         var _loc4_:Array = [];
         for each(file in this.files)
         {
            if(DCResourceManager.instance.isLoaded(file))
            {
               _loc4_.push(file);
            }
            else
            {
               DCResourceManager.instance.addCustomEventListener("complete",this.fileLoaded,file);
               DCResourceManager.instance.addCustomEventListener("error",this.error,file);
               DCResourceManager.instance.load(Config.getDataDir() + file,file,null,true,useContextForSwf);
            }
         }
         for each(alreadyLoadedFile in _loc4_)
         {
            this.files.splice(this.files.indexOf(alreadyLoadedFile),1);
         }
         ExternalInterface.call("console.log","Listeners notfied of:");
         ExternalInterface.call("console.log",JSON.stringify(this.files));
         ExternalInterface.call("console.log",JSON.stringify(_loc4_));
         this.notifyListeners();
      }
      
      private function fileLoaded(event:DCLoadingEvent) : void
      {
         var _loc2_:int = int(this.files.indexOf(event.resourceName));
         if(_loc2_ != -1)
         {
            this.files.splice(_loc2_,1);
         }
         this.notifyListeners();
      }
      
      private function error(event:DCLoadingEvent) : void
      {
         LogUtils.log("Failed to load: " + event.resourceName,this,3,"Assets",true,false,true);
         DCResourceManager.instance.removeCustomEventListener("complete",this.fileLoaded);
         DCResourceManager.instance.removeCustomEventListener("error",this.fileLoaded);
         MessageCenter.sendMessage("LoadError",{
            "id":this.id,
            "resource":event.resourceName
         });
      }
   }
}

