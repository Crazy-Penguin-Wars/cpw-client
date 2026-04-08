package com.dchoc.resources
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.utils.*;
   import flash.display.*;
   
   public class URLResourceLoader
   {
      private static const listnerCounter:Object = {};
      
      private var mc:MovieClip;
      
      private var url:String;
      
      private var defaultImage:MovieClip;
      
      public function URLResourceLoader(param1:MovieClip, param2:String, param3:MovieClip = null)
      {
         super();
         if(param1 == null)
         {
            LogUtils.log("Target movieClip is null for URL: " + param2,this,3,"LoadResource",false,true);
            return;
         }
         if(param2 == null || param2 == "")
         {
            LogUtils.log("Target URL is null or empty, try defaultImage",this,0,"LoadResource",false);
            this.setDefaultImage();
            return;
         }
         this.mc = param1;
         this.url = param2;
         this.defaultImage = param3;
         if(DCResourceManager.instance.load(param2,param2,"BitmapData",true))
         {
            LogUtils.log("Waiting for URL: " + param2,this,0,"LoadResource",false);
            param1.addChild(ResourceLoaderURL.getInstance().waiting);
            this.addListeners(param2);
         }
         else
         {
            LogUtils.log("Cache for URL: " + param2,this,0,"LoadResource",false,false,false);
            this.removeListeners(param2);
            this.replaceImage();
         }
      }
      
      private function loadError(param1:DCLoadingEvent) : void
      {
         this.removeListeners(this.url);
         if(this.mc.contains(ResourceLoaderURL.getInstance().waiting))
         {
            this.mc.removeChild(ResourceLoaderURL.getInstance().waiting);
         }
         LogUtils.log("Failed to load the requested image from URL: " + this.url,this,2);
         this.setDefaultImage();
      }
      
      private function loadDone(param1:DCLoadingEvent) : void
      {
         if(param1.resourceName == this.url)
         {
            LogUtils.log("Loaded successfull for URL: " + this.url,this,0,"LoadResource",false);
            this.removeListeners(this.url);
            this.replaceImage();
         }
         else
         {
            LogUtils.log("Resource name: " + param1.resourceName + " != " + this.url,this,2,"LoadResource");
         }
      }
      
      private function replaceImage() : void
      {
         var _loc1_:Bitmap = null;
         var _loc2_:MovieClip = null;
         var _loc3_:BitmapData = DCResourceManager.instance.get(this.url);
         if(_loc3_ != null)
         {
            _loc1_ = new Bitmap(_loc3_);
            if(_loc1_ != null)
            {
               _loc1_.smoothing = true;
               _loc2_ = new MovieClip();
               DCUtils.alignCentered(_loc1_);
               _loc2_.addChild(_loc1_);
               if(this.mc.contains(ResourceLoaderURL.getInstance().waiting))
               {
                  this.mc.removeChild(ResourceLoaderURL.getInstance().waiting);
               }
               DCUtils.replaceDisplayObject(this.mc,_loc2_,false,true);
               LogUtils.log("Replace successfull for URL: " + this.url,this,0,"LoadResource",true,false,false);
               _loc1_ = null;
               _loc2_ = null;
            }
            else if(!this.setDefaultImage())
            {
               LogUtils.log("Unable to form a bitmap image from bitmapData object got from URL: " + this.url,this,2);
            }
         }
         else if(!this.setDefaultImage())
         {
            LogUtils.log("Unable to form a correct bitmapData object from data from URL: " + this.url,this,2);
         }
         else
         {
            LogUtils.log("Bitmap data not correct for url: " + this.url,this,2);
         }
         this.dispose();
      }
      
      private function setDefaultImage() : Boolean
      {
         if(this.defaultImage != null)
         {
            LogUtils.log("Using defaultImage in place of image from URL: " + this.url,this,0,"LoadResource",false);
            DCUtils.replaceDisplayObject(this.mc,this.defaultImage,true,true);
            return true;
         }
         LogUtils.log("No defaultImage specified for URL: " + this.url,this,0,"LoadResource",false);
         return false;
      }
      
      private function addListeners(param1:String) : void
      {
         if(!listnerCounter.hasOwnProperty(param1))
         {
            listnerCounter[param1] = 0;
         }
         ++listnerCounter[param1];
         if(listnerCounter[param1] > 0)
         {
            DCResourceManager.instance.addCustomEventListener("error",this.loadError,param1);
            DCResourceManager.instance.addCustomEventListener("complete",this.loadDone,param1);
         }
      }
      
      private function removeListeners(param1:String) : void
      {
         if(!listnerCounter.hasOwnProperty(param1))
         {
            listnerCounter[param1] = 0;
         }
         --listnerCounter[param1];
         if(listnerCounter[param1] <= 0)
         {
            listnerCounter[param1] == 0;
            DCResourceManager.instance.removeCustomEventListener("error",this.loadError,param1);
            DCResourceManager.instance.removeCustomEventListener("complete",this.loadDone,param1);
         }
      }
      
      public function dispose() : void
      {
         this.removeListeners(this.url);
         this.mc = null;
         this.url = null;
         this.defaultImage = null;
      }
   }
}

