package com.dchoc.resources
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   
   public class ResourceLoaderURL
   {
      
      private static const LOADING:String = "loading_anim_icon";
      
      private static var instance:ResourceLoaderURL;
       
      
      public var waiting:MovieClip;
      
      public function ResourceLoaderURL()
      {
         super();
         if(instance == null)
         {
            if(DCResourceManager.instance.isAddedToLoadingList("flash/ui/hud_shared.swf"))
            {
               loadSWF();
            }
            else
            {
               addListeners("flash/ui/hud_shared.swf");
            }
            instance = this;
         }
      }
      
      public static function getInstance() : ResourceLoaderURL
      {
         if(instance == null)
         {
         }
         return instance;
      }
      
      public function load(target:IResourceLoaderURL, defaultImage:MovieClip = null) : URLResourceLoader
      {
         return new URLResourceLoader(target.getTargetMovieClip(),target.getResourceUrl(),defaultImage);
      }
      
      private function loadSWF() : void
      {
         LogUtils.log("Loading placeholder images for resources succeded!",this,0,"LoadResource",false);
         waiting = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","loading_anim_icon","MovieClip");
      }
      
      private function loadError(event:DCLoadingEvent) : void
      {
         LogUtils.log("Loading placeholder images for resources failed for: loading_anim_icon from: " + event.resourceName,this,2,"ErrorLogging",false);
         removeListeners(event.resourceName);
      }
      
      private function loadDone(event:DCLoadingEvent) : void
      {
         removeListeners(event.resourceName);
         loadSWF();
      }
      
      private function removeListeners(resName:String) : void
      {
         DCResourceManager.instance.removeCustomEventListener("error",loadError,resName);
         DCResourceManager.instance.removeCustomEventListener("complete",loadDone,resName);
      }
      
      private function addListeners(resName:String) : void
      {
         DCResourceManager.instance.addCustomEventListener("error",loadError,resName);
         DCResourceManager.instance.addCustomEventListener("complete",loadDone,resName);
      }
   }
}
