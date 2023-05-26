package com.dchoc.resources
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   
   public class URLResourceLoader
   {
      
      private static const listnerCounter:Object = {};
       
      
      private var mc:MovieClip;
      
      private var url:String;
      
      private var defaultImage:MovieClip;
      
      public function URLResourceLoader(mc:MovieClip, url:String, defaultImage:MovieClip = null)
      {
         super();
         if(mc == null)
         {
            LogUtils.log("Target movieClip is null for URL: " + url,this,3,"LoadResource",false,true);
            return;
         }
         if(url == null || url == "")
         {
            LogUtils.log("Target URL is null or empty, try defaultImage",this,0,"LoadResource",false);
            setDefaultImage();
            return;
         }
         this.mc = mc;
         this.url = url;
         this.defaultImage = defaultImage;
         if(DCResourceManager.instance.load(url,url,"BitmapData",true))
         {
            LogUtils.log("Waiting for URL: " + url,this,0,"LoadResource",false);
            mc.addChild(ResourceLoaderURL.getInstance().waiting);
            addListeners(url);
         }
         else
         {
            LogUtils.log("Cache for URL: " + url,this,0,"LoadResource",false,false,false);
            removeListeners(url);
            replaceImage();
         }
      }
      
      private function loadError(event:DCLoadingEvent) : void
      {
         removeListeners(url);
         if(mc.contains(ResourceLoaderURL.getInstance().waiting))
         {
            mc.removeChild(ResourceLoaderURL.getInstance().waiting);
         }
         LogUtils.log("Failed to load the requested image from URL: " + url,this,2);
         setDefaultImage();
      }
      
      private function loadDone(event:DCLoadingEvent) : void
      {
         if(event.resourceName == url)
         {
            LogUtils.log("Loaded successfull for URL: " + url,this,0,"LoadResource",false);
            removeListeners(url);
            replaceImage();
         }
         else
         {
            LogUtils.log("Resource name: " + event.resourceName + " != " + url,this,2,"LoadResource");
         }
      }
      
      private function replaceImage() : void
      {
         var bitmap:* = null;
         var newMc:* = null;
         var bitmapData:BitmapData = DCResourceManager.instance.get(url);
         if(bitmapData != null)
         {
            bitmap = new Bitmap(bitmapData);
            if(bitmap != null)
            {
               bitmap.smoothing = true;
               newMc = new MovieClip();
               DCUtils.alignCentered(bitmap);
               newMc.addChild(bitmap);
               if(mc.contains(ResourceLoaderURL.getInstance().waiting))
               {
                  mc.removeChild(ResourceLoaderURL.getInstance().waiting);
               }
               DCUtils.replaceDisplayObject(mc,newMc,false,true);
               LogUtils.log("Replace successfull for URL: " + url,this,0,"LoadResource",true,false,false);
               bitmap = null;
               newMc = null;
            }
            else if(!setDefaultImage())
            {
               LogUtils.log("Unable to form a bitmap image from bitmapData object got from URL: " + url,this,2);
            }
         }
         else if(!setDefaultImage())
         {
            LogUtils.log("Unable to form a correct bitmapData object from data from URL: " + url,this,2);
         }
         else
         {
            LogUtils.log("Bitmap data not correct for url: " + url,this,2);
         }
         dispose();
      }
      
      private function setDefaultImage() : Boolean
      {
         if(defaultImage != null)
         {
            LogUtils.log("Using defaultImage in place of image from URL: " + url,this,0,"LoadResource",false);
            DCUtils.replaceDisplayObject(mc,defaultImage,true,true);
            return true;
         }
         LogUtils.log("No defaultImage specified for URL: " + url,this,0,"LoadResource",false);
         return false;
      }
      
      private function addListeners(resName:String) : void
      {
         if(!listnerCounter.hasOwnProperty(resName))
         {
            listnerCounter[resName] = 0;
         }
         listnerCounter[resName]++;
         if(listnerCounter[resName] > 0)
         {
            DCResourceManager.instance.addCustomEventListener("error",loadError,resName);
            DCResourceManager.instance.addCustomEventListener("complete",loadDone,resName);
         }
      }
      
      private function removeListeners(resName:String) : void
      {
         if(!listnerCounter.hasOwnProperty(resName))
         {
            listnerCounter[resName] = 0;
         }
         listnerCounter[resName]--;
         if(listnerCounter[resName] <= 0)
         {
            listnerCounter[resName] == 0;
            DCResourceManager.instance.removeCustomEventListener("error",loadError,resName);
            DCResourceManager.instance.removeCustomEventListener("complete",loadDone,resName);
         }
      }
      
      public function dispose() : void
      {
         removeListeners(url);
         mc = null;
         url = null;
         defaultImage = null;
      }
   }
}
