package com.dchoc.resources
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   
   public class BatchLoader
   {
      
      public static const FILES_LOADED:String = "FilesLoaded";
      
      public static const LOAD_ERROR:String = "LoadError";
      
      private static var idCounter:int;
       
      
      private var _id:String;
      
      private var files:Array;
      
      public function BatchLoader(files:Array)
      {
         super();
         this.files = files.slice();
         _id = idCounter.toString();
         idCounter++;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function load(useContextForSwf:Boolean = false) : void
      {
         var _loc4_:Array = [];
         for each(var file in files)
         {
            if(DCResourceManager.instance.isLoaded(file))
            {
               _loc4_.push(file);
            }
            else
            {
               DCResourceManager.instance.addCustomEventListener("complete",fileLoaded,file);
               DCResourceManager.instance.addCustomEventListener("error",error,file);
               DCResourceManager.instance.load(Config.getDataDir() + file,file,null,true,useContextForSwf);
            }
         }
         for each(var alreadyLoadedFile in _loc4_)
         {
            files.splice(files.indexOf(alreadyLoadedFile),1);
         }
         notifyListeners();
      }
      
      private function fileLoaded(event:DCLoadingEvent) : void
      {
         var _loc2_:int = files.indexOf(event.resourceName);
         if(_loc2_ != -1)
         {
            files.splice(_loc2_,1);
         }
         notifyListeners();
      }
      
      private function error(event:DCLoadingEvent) : void
      {
         LogUtils.log("Failed to load: " + event.resourceName,this,3,"Assets",true,false,true);
         DCResourceManager.instance.removeCustomEventListener("complete",fileLoaded);
         DCResourceManager.instance.removeCustomEventListener("error",fileLoaded);
         MessageCenter.sendMessage("LoadError",{
            "id":id,
            "resource":event.resourceName
         });
      }
      
      private function notifyListeners() : void
      {
         if(files.length == 0)
         {
            DCResourceManager.instance.removeCustomEventListener("complete",fileLoaded);
            DCResourceManager.instance.removeCustomEventListener("error",fileLoaded);
            MessageCenter.sendMessage("FilesLoaded",id);
         }
      }
   }
}
