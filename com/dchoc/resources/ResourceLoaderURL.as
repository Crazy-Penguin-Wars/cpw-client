package com.dchoc.resources
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   
   public class ResourceLoaderURL
   {
      private static var instance:ResourceLoaderURL;
      
      private static const LOADING:String = "loading_anim_icon";
      
      public var waiting:MovieClip;
      
      public function ResourceLoaderURL()
      {
         super();
         if(instance == null)
         {
            if(DCResourceManager.instance.isAddedToLoadingList("flash/ui/hud_shared.swf"))
            {
               this.loadSWF();
            }
            else
            {
               this.addListeners("flash/ui/hud_shared.swf");
            }
            instance = this;
         }
      }
      
      public static function getInstance() : ResourceLoaderURL
      {
         if(instance == null)
         {
            new ResourceLoaderURL();
         }
         return instance;
      }
      
      public function load(param1:IResourceLoaderURL, param2:MovieClip = null) : URLResourceLoader
      {
         return new URLResourceLoader(param1.getTargetMovieClip(),param1.getResourceUrl(),param2);
      }
      
      private function loadSWF() : void
      {
         LogUtils.log("Loading placeholder images for resources succeded!",this,0,"LoadResource",false);
         this.waiting = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","loading_anim_icon","MovieClip");
      }
      
      private function loadError(param1:DCLoadingEvent) : void
      {
         LogUtils.log("Loading placeholder images for resources failed for: loading_anim_icon from: " + param1.resourceName,this,2,"ErrorLogging",false);
         this.removeListeners(param1.resourceName);
      }
      
      private function loadDone(param1:DCLoadingEvent) : void
      {
         this.removeListeners(param1.resourceName);
         this.loadSWF();
      }
      
      private function removeListeners(param1:String) : void
      {
         DCResourceManager.instance.removeCustomEventListener("error",this.loadError,param1);
         DCResourceManager.instance.removeCustomEventListener("complete",this.loadDone,param1);
      }
      
      private function addListeners(param1:String) : void
      {
         DCResourceManager.instance.addCustomEventListener("error",this.loadError,param1);
         DCResourceManager.instance.addCustomEventListener("complete",this.loadDone,param1);
      }
   }
}

