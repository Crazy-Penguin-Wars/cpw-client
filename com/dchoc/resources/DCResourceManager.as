package com.dchoc.resources
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class DCResourceManager extends EventDispatcher
   {
      
      private static const MEDIA_SPEED_DATAS:Vector.<MediaSpeedData> = new Vector.<MediaSpeedData>();
      
      public static const TYPE_MOVIE_CLIP:String = "MovieClip";
      
      public static const TYPE_BYTE_ARRAY:String = "ByteArray";
      
      public static const TYPE_BITMAP_DATA:String = "BitmapData";
      
      public static const TYPE_STRING:String = "String";
      
      public static const TYPE_TEXT_FILE:String = "TextFile";
      
      public static const TYPE_VARIABLES_FILE:String = "VariablesTextFile";
      
      private static const USE_CONTEXT:Boolean = true;
      
      private static const LOAD_RETRIES:int = 1;
      
      private static var crossDomainPrefix:String;
      
      public static const instance:DCResourceManager = new DCResourceManager();
       
      
      private const list:Object = {};
      
      private const type:Object = {};
      
      private const loaded:Object = {};
      
      private const loadInBackground:Object = {};
      
      private const resolver:Dictionary = new Dictionary(true);
      
      private const unloader:Object = {};
      
      private const loadedPolicyFiles:Array = [];
      
      private var totalSize:int;
      
      private var fileCountToLoad:int;
      
      private var totalFileCountToLoad:int;
      
      public function DCResourceManager()
      {
         super();
      }
      
      public static function setCrossDomainPrefix(value:String) : void
      {
         crossDomainPrefix = value;
      }
      
      public function addCustomEventListener(eventType:String, listener:Function, resName:String = null) : void
      {
         super.addEventListener(generateCustomEventType(eventType,resName),listener,false,0,true);
      }
      
      public function removeCustomEventListener(eventType:String, listener:Function, resName:String = null) : void
      {
         super.removeEventListener(generateCustomEventType(eventType,resName),listener);
      }
      
      private function generateCustomEventType(eventType:String, customName:String) : String
      {
         if(customName == null)
         {
            return eventType;
         }
         return eventType + "@" + customName;
      }
      
      override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         throw new Error("You cannot use addEventListener for this class. Use addCustomEventListener() instead");
      }
      
      override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         throw new Error("You cannot use removeEventListener for this class. Use removeCustomEventListener() instead");
      }
      
      public function load(name:String, resName:String, objectType:String = null, loadInBackground:Boolean = false, useContextForSwf:Boolean = false, scale:Number = 1) : Boolean
      {
         if(loaded[resName])
         {
            return false;
         }
         if(type[resName] == null)
         {
            loadFromFile(name,resName,objectType,loadInBackground,useContextForSwf);
            if(!loadInBackground)
            {
               totalFileCountToLoad++;
               fileCountToLoad++;
            }
         }
         return true;
      }
      
      public function getFromSWF(resName:String, className:String = null, resType:String = "MovieClip") : *
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         if(resName == null)
         {
            return null;
         }
         if(className == null)
         {
            _loc6_ = resName.lastIndexOf("/");
            className = resName.slice(_loc6_ + 1);
            resName = resName.slice(0,_loc6_);
         }
         var _loc4_:ApplicationDomain = getLoadedSWFAppDomain(resName);
         if(_loc4_ && _loc4_.hasDefinition(className))
         {
            _loc5_ = Class(_loc4_.getDefinition(className));
            switch(resType)
            {
               case "MovieClip":
                  return new _loc5_();
               case "BitmapData":
                  return new _loc5_(0,0);
            }
         }
         return null;
      }
      
      public function get(resName:String) : *
      {
         if(list[resName] == null)
         {
            LogUtils.log("Resource " + resName + " doesn\'t exist.",this,3,"Assets");
            return null;
         }
         if(!loaded[resName])
         {
            LogUtils.log("ERROR: " + resName + " is not loaded.",this,3,"Assets");
            return null;
         }
         switch(type[resName])
         {
            case ".bin":
            case ".swf":
            case "MovieClip":
            case "Bitmap":
            case ".txt":
            case ".csv":
            case ".json":
            case "TextFile":
               break;
            case "VariablesTextFile":
               break;
            case ".jpg":
            case "jpeg":
            case ".gif":
            case ".png":
            case "BitmapData":
               return Bitmap(list[resName]).bitmapData;
            case ".xml":
               return new XML(list[resName]);
            default:
               return null;
         }
         return list[resName];
      }
      
      public function unload(entryName:String) : void
      {
         if(entryName == null)
         {
            return;
         }
         if(!loaded[entryName])
         {
            return;
         }
         switch(type[entryName])
         {
            case "Bitmap":
            case "BitmapData":
            case ".jpg":
            case "jpeg":
            case ".gif":
            case ".png":
               Bitmap(list[entryName]).bitmapData.dispose();
         }
         if(unloader[entryName] is Loader && unloader[entryName].numChildren > 0)
         {
            unloader[entryName].unload();
         }
         loaded[entryName] = false;
         delete unloader[entryName];
         delete resolver[entryName];
         delete list[entryName];
         delete loaded[entryName];
         delete type[entryName];
      }
      
      public function unloadAll() : void
      {
         for(var key in list)
         {
            unload(key);
         }
      }
      
      public function getFileCountToLoad() : int
      {
         return fileCountToLoad;
      }
      
      public function isLoaded(resName:String) : Boolean
      {
         return loaded.hasOwnProperty(resName) ? loaded[resName] : false;
      }
      
      public function isAddedToLoadingList(resName:String) : Boolean
      {
         return list.hasOwnProperty(resName);
      }
      
      public function calculateAverageDownloadSpeed() : Number
      {
         var speed:Number = 0;
         for each(var msd in MEDIA_SPEED_DATAS)
         {
            if(msd.finished)
            {
               speed += msd.speed;
            }
         }
         return speed / MEDIA_SPEED_DATAS.length;
      }
      
      public function findSpeedDataFor(resName:String) : MediaSpeedData
      {
         return DCUtils.find(MEDIA_SPEED_DATAS,"file",resName);
      }
      
      private function loadFromFile(path:String, resName:String, returnType:String = null, _loadInBackground:Boolean = false, useContextForSwf:Boolean = false) : void
      {
         var _loc6_:int = 0;
         if(returnType == null)
         {
            _loc6_ = path.lastIndexOf(".");
            if(_loc6_ != -1)
            {
               returnType = path.substring(_loc6_);
            }
         }
         loaded[resName] = false;
         type[resName] = returnType;
         loadInBackground[resName] = _loadInBackground;
         switch(returnType)
         {
            case ".csv":
            case ".txt":
            case ".json":
               break;
            case "TextFile":
               break;
            case "VariablesTextFile":
               loadBinFile(path,resName,"variables",returnType);
               return;
            case ".bin":
               loadBinFile(path,resName,"binary",returnType);
               return;
            default:
               var _loc9_:URLRequest = new URLRequest(path);
               var _loc8_:Loader = new Loader();
               list[resName] = _loc8_;
               unloader[resName] = _loc8_;
               _loc8_.contentLoaderInfo.addEventListener("complete",completeLoad,false,0,true);
               _loc8_.contentLoaderInfo.addEventListener("progress",progressLoad,false,0,true);
               _loc8_.contentLoaderInfo.addEventListener("ioError",errorLoad,false,0,true);
               var loaderContext:LoaderContext = null;
               if(returnType == ".swf")
               {
                  if(useContextForSwf)
                  {
                     loaderContext = new LoaderContext(true,ApplicationDomain.currentDomain);
                  }
                  _loc8_.load(_loc9_,loaderContext);
               }
               else
               {
                  loaderContext = new LoaderContext(true,ApplicationDomain.currentDomain);
                  _loc8_.load(_loc9_,loaderContext);
               }
               resolver[_loc8_.contentLoaderInfo] = new ResourceLoaderObject(resName,_loc9_,loaderContext);
               MEDIA_SPEED_DATAS.push(new MediaSpeedData(resName,getTimer()));
               LogUtils.log("Loading file " + path,this,1,"Assets");
               return;
         }
         loadBinFile(path,resName,"text",returnType);
      }
      
      private function progressLoad(event:ProgressEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(event.target is URLLoaderWithName)
         {
            _loc2_ = URLLoaderWithName(event.target);
            _loc3_ = resolver[_loc2_.getName()];
            LogUtils.log("Load progress: , " + _loc3_.resourceName + ", bytes loaded: " + event.bytesLoaded + ", total: " + event.bytesTotal,this,1,"Assets",true,false,false);
         }
         updateProgess();
      }
      
      private function updateProgess() : void
      {
         totalSize = 0;
         for(var p in list)
         {
            if(unloader[p] is Loader)
            {
               totalSize += Loader(unloader[p]).contentLoaderInfo.bytesTotal;
            }
            else
            {
               totalSize += URLLoaderWithName(unloader[p]).bytesTotal;
            }
         }
      }
      
      private function completeLoad(event:Event) : void
      {
         var _loc2_:ResourceLoaderObject = resolver[event.target];
         LogUtils.log("Load completed " + _loc2_.resourceName,this,1,"Assets");
         finalizeSpeedData(_loc2_.resourceName,event.target.bytesLoaded);
         event.target.removeEventListener("complete",completeLoad);
         event.target.removeEventListener("progress",progressLoad);
         event.target.removeEventListener("ioError",errorLoad);
         if(!event.target.childAllowsParent)
         {
            _loc2_.loaderInfo = event.target as LoaderInfo;
            loadSecurityPolicyFile(_loc2_);
            return;
         }
         finalizeLoading(event.target as LoaderInfo);
      }
      
      private function finalizeSpeedData(resourceName:String, bytesLoaded:int) : void
      {
         var _loc3_:MediaSpeedData = findSpeedDataFor(resourceName);
         if(_loc3_)
         {
            _loc3_.endTime = getTimer();
            _loc3_.size = bytesLoaded;
         }
         else
         {
            LogUtils.log("Couldn\'t find speed data object for: " + resourceName,this,2,"Assets");
         }
      }
      
      private function finalizeLoading(loaderInfo:LoaderInfo) : void
      {
         var _loc2_:String = resolver[loaderInfo].resourceName;
         list[_loc2_] = loaderInfo.content;
         loaded[_loc2_] = true;
         delete resolver[loaderInfo];
         unloader[_loc2_] = loaderInfo.loader;
         dispatchEvent(new DCLoadingEvent("complete",_loc2_));
         if(!loadInBackground[_loc2_])
         {
            fileCountToLoad--;
            if(fileCountToLoad == 0)
            {
               dispatchEvent(new DCLoadingEvent("loadOver"));
            }
         }
      }
      
      private function loadSecurityPolicyFile(resLoader:ResourceLoaderObject) : void
      {
         var _loc3_:String = resLoader.loaderInfo.url;
         var _loc2_:Array = _loc3_.split("/");
         var _loc4_:String = _loc2_[0] + "//" + _loc2_[2];
         if(loadedPolicyFiles.indexOf(_loc4_) < 0)
         {
            loadedPolicyFiles.push(_loc4_);
            Security.loadPolicyFile(_loc4_ + "/crossdomain.xml");
            LogUtils.log("Loading security policy file: " + _loc4_ + "/crossdomain.xml",this,1,"Assets",false,false,false);
         }
         resLoader.startPolling(finalizeLoading);
      }
      
      private function completeTextLoad(event:Event) : void
      {
         var _loc2_:URLLoaderWithName = URLLoaderWithName(event.target);
         var _loc3_:String = resolver[_loc2_.getName()].resourceName;
         LogUtils.log("Text load completed " + _loc3_,this,1,"Assets");
         _loc2_.removeEventListener("complete",completeTextLoad);
         _loc2_.removeEventListener("progress",progressLoad);
         _loc2_.removeEventListener("ioError",errorTextLoad);
         list[_loc3_] = _loc2_.data;
         loaded[_loc3_] = true;
         delete resolver[_loc2_.getName()];
         unloader[_loc3_] = _loc2_;
         dispatchEvent(new DCLoadingEvent("complete",_loc3_));
         if(!loadInBackground[_loc3_])
         {
            fileCountToLoad--;
            if(fileCountToLoad == 0)
            {
               dispatchEvent(new DCLoadingEvent("loadOver"));
            }
         }
      }
      
      private function errorLoad(event:IOErrorEvent) : void
      {
         LogUtils.log("Loading error: " + event.toString(),this,3,"Assets");
         var _loc3_:ResourceLoaderObject = resolver[event.target];
         var _loc2_:Loader = event.target.loader;
         if(_loc3_.retryCount > 1)
         {
            event.target.removeEventListener("complete",completeTextLoad);
            event.target.removeEventListener("progress",progressLoad);
            event.target.removeEventListener("ioError",errorLoad);
            delete resolver[event.target];
            dispatchEvent(new DCLoadingEvent("error",_loc3_.resourceName));
            fileCountToLoad--;
         }
         else
         {
            _loc2_.load(_loc3_.url,_loc3_.loaderContext);
            _loc3_.retryCount++;
         }
      }
      
      private function errorTextLoad(event:IOErrorEvent) : void
      {
         LogUtils.log("Loading error: " + event.toString(),this,3,"Assets");
         var _loc2_:URLLoaderWithName = URLLoaderWithName(event.target);
         var _loc3_:ResourceLoaderObject = resolver[_loc2_.getName()];
         if(_loc3_.retryCount > 1)
         {
            event.target.removeEventListener("complete",completeTextLoad);
            event.target.removeEventListener("progress",progressLoad);
            event.target.removeEventListener("ioError",errorTextLoad);
            delete resolver[_loc2_.getName()];
            dispatchEvent(new DCLoadingEvent("error",_loc3_.resourceName));
            fileCountToLoad--;
         }
         else
         {
            _loc2_.load(_loc3_.url);
            _loc3_.retryCount++;
         }
      }
      
      private function loadBinFile(path:String, resName:String, dataFormat:String, returnType:String = null) : void
      {
         var _loc6_:URLRequest = new URLRequest(path);
         var _loc5_:URLLoaderWithName = new URLLoaderWithName();
         _loc5_.dataFormat = dataFormat;
         _loc5_.load(_loc6_);
         resolver[_loc5_.getName()] = new ResourceLoaderObject(resName,_loc6_,null);
         list[resName] = _loc5_;
         unloader[resName] = _loc5_;
         _loc5_.addEventListener("complete",completeTextLoad,false,0,true);
         _loc5_.addEventListener("progress",progressLoad,false,0,true);
         _loc5_.addEventListener("ioError",errorTextLoad,false,0,true);
      }
      
      private function getLoadedSWFAppDomain(resName:String) : ApplicationDomain
      {
         var _loc2_:Loader = unloader[resName];
         return !!_loc2_ ? _loc2_.contentLoaderInfo.applicationDomain : null;
      }
   }
}
