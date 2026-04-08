package com.dchoc.resources
{
   import com.dchoc.events.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.*;
   import flash.system.*;
   import flash.utils.*;
   
   public class DCResourceManager extends EventDispatcher
   {
      private static var crossDomainPrefix:String;
      
      public static const TYPE_MOVIE_CLIP:String = "MovieClip";
      
      public static const TYPE_BYTE_ARRAY:String = "ByteArray";
      
      public static const TYPE_BITMAP_DATA:String = "BitmapData";
      
      public static const TYPE_STRING:String = "String";
      
      public static const TYPE_TEXT_FILE:String = "TextFile";
      
      public static const TYPE_VARIABLES_FILE:String = "VariablesTextFile";
      
      private static const USE_CONTEXT:Boolean = true;
      
      private static const LOAD_RETRIES:int = 1;
      
      private static const MEDIA_SPEED_DATAS:Vector.<MediaSpeedData> = new Vector.<MediaSpeedData>();
      
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
      
      public static function setCrossDomainPrefix(param1:String) : void
      {
         crossDomainPrefix = param1;
      }
      
      public function addCustomEventListener(param1:String, param2:Function, param3:String = null) : void
      {
         super.addEventListener(this.generateCustomEventType(param1,param3),param2,false,0,true);
      }
      
      public function removeCustomEventListener(param1:String, param2:Function, param3:String = null) : void
      {
         super.removeEventListener(this.generateCustomEventType(param1,param3),param2);
      }
      
      private function generateCustomEventType(param1:String, param2:String) : String
      {
         if(param2 == null)
         {
            return param1;
         }
         return param1 + "@" + param2;
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         throw new Error("You cannot use addEventListener for this class. Use addCustomEventListener() instead");
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         throw new Error("You cannot use removeEventListener for this class. Use removeCustomEventListener() instead");
      }
      
      public function load(param1:String, param2:String, param3:String = null, param4:Boolean = false, param5:Boolean = false, param6:Number = 1) : Boolean
      {
         if(this.loaded[param2])
         {
            return false;
         }
         if(this.type[param2] == null)
         {
            this.loadFromFile(param1,param2,param3,param4,param5);
            if(!param4)
            {
               ++this.totalFileCountToLoad;
               ++this.fileCountToLoad;
            }
         }
         return true;
      }
      
      public function getFromSWF(param1:String, param2:String = null, param3:String = "MovieClip") : *
      {
         var _loc4_:int = 0;
         var _loc5_:Class = null;
         if(param1 == null)
         {
            return null;
         }
         if(param2 == null)
         {
            _loc4_ = int(param1.lastIndexOf("/"));
            param2 = param1.slice(_loc4_ + 1);
            param1 = param1.slice(0,_loc4_);
         }
         var _loc6_:ApplicationDomain = this.getLoadedSWFAppDomain(param1);
         if((Boolean(_loc6_)) && _loc6_.hasDefinition(param2))
         {
            _loc5_ = Class(_loc6_.getDefinition(param2));
            switch(param3)
            {
               case "MovieClip":
                  return new _loc5_();
               case "BitmapData":
                  return new _loc5_(0,0);
            }
         }
         return null;
      }
      
      public function get(param1:String) : *
      {
         if(this.list[param1] == null)
         {
            LogUtils.log("Resource " + param1 + " doesn\'t exist.",this,3,"Assets");
            return null;
         }
         if(!this.loaded[param1])
         {
            LogUtils.log("ERROR: " + param1 + " is not loaded.",this,3,"Assets");
            return null;
         }
         switch(this.type[param1])
         {
            case ".bin":
            case ".swf":
            case "MovieClip":
            case "Bitmap":
            case ".txt":
            case ".csv":
            case ".json":
            case "TextFile":
            case "VariablesTextFile":
               return this.list[param1];
            case ".jpg":
            case "jpeg":
            case ".gif":
            case ".png":
            case "BitmapData":
               return Bitmap(this.list[param1]).bitmapData;
            case ".xml":
               return new XML(this.list[param1]);
            default:
               return null;
         }
      }
      
      public function unload(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(!this.loaded[param1])
         {
            return;
         }
         switch(this.type[param1])
         {
            case "Bitmap":
            case "BitmapData":
            case ".jpg":
            case "jpeg":
            case ".gif":
            case ".png":
               Bitmap(this.list[param1]).bitmapData.dispose();
         }
         if(this.unloader[param1] is Loader && this.unloader[param1].numChildren > 0)
         {
            this.unloader[param1].unload();
         }
         this.loaded[param1] = false;
         delete this.unloader[param1];
         delete this.resolver[param1];
         delete this.list[param1];
         delete this.loaded[param1];
         delete this.type[param1];
      }
      
      public function unloadAll() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.list)
         {
            this.unload(_loc1_);
         }
      }
      
      public function getFileCountToLoad() : int
      {
         return this.fileCountToLoad;
      }
      
      public function isLoaded(param1:String) : Boolean
      {
         return !!this.loaded.hasOwnProperty(param1) ? Boolean(this.loaded[param1]) : false;
      }
      
      public function isAddedToLoadingList(param1:String) : Boolean
      {
         return this.list.hasOwnProperty(param1);
      }
      
      public function calculateAverageDownloadSpeed() : Number
      {
         var _loc2_:* = undefined;
         var _loc1_:Number = 0;
         for each(_loc2_ in MEDIA_SPEED_DATAS)
         {
            if(_loc2_.finished)
            {
               _loc1_ += _loc2_.speed;
            }
         }
         return _loc1_ / MEDIA_SPEED_DATAS.length;
      }
      
      public function findSpeedDataFor(param1:String) : MediaSpeedData
      {
         return DCUtils.find(MEDIA_SPEED_DATAS,"file",param1);
      }
      
      private function loadFromFile(param1:String, param2:String, param3:String = null, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc7_:URLRequest = null;
         var _loc8_:Loader = null;
         var _loc9_:LoaderContext = null;
         var _loc6_:int = 0;
         if(param3 == null)
         {
            _loc6_ = int(param1.lastIndexOf("."));
            if(_loc6_ != -1)
            {
               param3 = param1.substring(_loc6_);
            }
         }
         this.loaded[param2] = false;
         this.type[param2] = param3;
         this.loadInBackground[param2] = param4;
         switch(param3)
         {
            case ".csv":
            case ".txt":
            case ".json":
            case "TextFile":
               this.loadBinFile(param1,param2,"text",param3);
               return;
            case "VariablesTextFile":
               this.loadBinFile(param1,param2,"variables",param3);
               return;
            case ".bin":
               this.loadBinFile(param1,param2,"binary",param3);
               return;
            default:
               _loc7_ = new URLRequest(param1);
               _loc8_ = new Loader();
               this.list[param2] = _loc8_;
               this.unloader[param2] = _loc8_;
               _loc8_.contentLoaderInfo.addEventListener("complete",this.completeLoad,false,0,true);
               _loc8_.contentLoaderInfo.addEventListener("progress",this.progressLoad,false,0,true);
               _loc8_.contentLoaderInfo.addEventListener("ioError",this.errorLoad,false,0,true);
               _loc9_ = null;
               if(param3 == ".swf")
               {
                  if(param5)
                  {
                     _loc9_ = new LoaderContext(true,ApplicationDomain.currentDomain);
                  }
                  _loc8_.load(_loc7_,_loc9_);
               }
               else
               {
                  _loc9_ = new LoaderContext(true,ApplicationDomain.currentDomain);
                  _loc8_.load(_loc7_,_loc9_);
               }
               this.resolver[_loc8_.contentLoaderInfo] = new ResourceLoaderObject(param2,_loc7_,_loc9_);
               MEDIA_SPEED_DATAS.push(new MediaSpeedData(param2,getTimer()));
               LogUtils.log("Loading file " + param1,this,1,"Assets");
               return;
         }
      }
      
      private function progressLoad(param1:ProgressEvent) : void
      {
         var _loc2_:URLLoaderWithName = null;
         var _loc3_:ResourceLoaderObject = null;
         if(param1.target is URLLoaderWithName)
         {
            _loc2_ = URLLoaderWithName(param1.target);
            _loc3_ = this.resolver[_loc2_.getName()];
            LogUtils.log("Load progress: , " + _loc3_.resourceName + ", bytes loaded: " + param1.bytesLoaded + ", total: " + param1.bytesTotal,this,1,"Assets",true,false,false);
         }
         this.updateProgess();
      }
      
      private function updateProgess() : void
      {
         var _loc1_:* = undefined;
         this.totalSize = 0;
         for(_loc1_ in this.list)
         {
            if(this.unloader[_loc1_] is Loader)
            {
               this.totalSize += Loader(this.unloader[_loc1_]).contentLoaderInfo.bytesTotal;
            }
            else
            {
               this.totalSize += URLLoaderWithName(this.unloader[_loc1_]).bytesTotal;
            }
         }
      }
      
      private function completeLoad(param1:Event) : void
      {
         var _loc2_:ResourceLoaderObject = this.resolver[param1.target];
         LogUtils.log("Load completed " + _loc2_.resourceName,this,1,"Assets");
         this.finalizeSpeedData(_loc2_.resourceName,param1.target.bytesLoaded);
         LogUtils.log("So far still works xd",this,1,"Assets");
         param1.target.removeEventListener("complete",this.completeLoad);
         param1.target.removeEventListener("progress",this.progressLoad);
         param1.target.removeEventListener("ioError",this.errorLoad);
         if(!param1.target.childAllowsParent)
         {
            _loc2_.loaderInfo = param1.target as LoaderInfo;
            this.loadSecurityPolicyFile(_loc2_);
         }
         this.finalizeLoading(param1.target as LoaderInfo);
      }
      
      private function finalizeSpeedData(param1:String, param2:int) : void
      {
         var _loc3_:MediaSpeedData = this.findSpeedDataFor(param1);
         if(_loc3_)
         {
            _loc3_.endTime = getTimer();
            _loc3_.size = param2;
         }
         else
         {
            LogUtils.log("Couldn\'t find speed data object for: " + param1,this,2,"Assets");
         }
      }
      
      private function finalizeLoading(param1:LoaderInfo) : void
      {
         var _loc2_:String = this.resolver[param1].resourceName;
         this.list[_loc2_] = param1.content;
         this.loaded[_loc2_] = true;
         delete this.resolver[param1];
         this.unloader[_loc2_] = param1.loader;
         dispatchEvent(new DCLoadingEvent("complete",_loc2_));
         if(!this.loadInBackground[_loc2_])
         {
            --this.fileCountToLoad;
            if(this.fileCountToLoad == 0)
            {
               dispatchEvent(new DCLoadingEvent("loadOver"));
            }
         }
      }
      
      private function loadSecurityPolicyFile(param1:ResourceLoaderObject) : void
      {
         var _loc2_:String = param1.loaderInfo.url;
         var _loc3_:Array = _loc2_.split("/");
         var _loc4_:String = _loc3_[0] + "//" + _loc3_[2];
         if(this.loadedPolicyFiles.indexOf(_loc4_) < 0)
         {
            this.loadedPolicyFiles.push(_loc4_);
            Security.loadPolicyFile(_loc4_ + "/crossdomain.xml");
            LogUtils.log("Loading security policy file: " + _loc4_ + "/crossdomain.xml",this,1,"Assets",false,false,false);
         }
         param1.startPolling(this.finalizeLoading);
      }
      
      private function completeTextLoad(param1:Event) : void
      {
         var _loc2_:URLLoaderWithName = URLLoaderWithName(param1.target);
         var _loc3_:String = this.resolver[_loc2_.getName()].resourceName;
         LogUtils.log("Text load completed " + _loc3_,this,1,"Assets");
         _loc2_.removeEventListener("complete",this.completeTextLoad);
         _loc2_.removeEventListener("progress",this.progressLoad);
         _loc2_.removeEventListener("ioError",this.errorTextLoad);
         this.list[_loc3_] = _loc2_.data;
         this.loaded[_loc3_] = true;
         delete this.resolver[_loc2_.getName()];
         this.unloader[_loc3_] = _loc2_;
         dispatchEvent(new DCLoadingEvent("complete",_loc3_));
         if(!this.loadInBackground[_loc3_])
         {
            --this.fileCountToLoad;
            if(this.fileCountToLoad == 0)
            {
               dispatchEvent(new DCLoadingEvent("loadOver"));
            }
         }
      }
      
      private function errorLoad(param1:IOErrorEvent) : void
      {
         LogUtils.log("Loading error: " + param1.toString(),this,3,"Assets");
         var _loc2_:ResourceLoaderObject = this.resolver[param1.target];
         var _loc3_:Loader = param1.target.loader;
         if(_loc2_.retryCount > 1)
         {
            param1.target.removeEventListener("complete",this.completeTextLoad);
            param1.target.removeEventListener("progress",this.progressLoad);
            param1.target.removeEventListener("ioError",this.errorLoad);
            delete this.resolver[param1.target];
            dispatchEvent(new DCLoadingEvent("error",_loc2_.resourceName));
            --this.fileCountToLoad;
         }
         else
         {
            _loc3_.load(_loc2_.url,_loc2_.loaderContext);
            ++_loc2_.retryCount;
         }
      }
      
      private function errorTextLoad(param1:IOErrorEvent) : void
      {
         LogUtils.log("Loading error: " + param1.toString(),this,3,"Assets");
         var _loc2_:URLLoaderWithName = URLLoaderWithName(param1.target);
         var _loc3_:ResourceLoaderObject = this.resolver[_loc2_.getName()];
         if(_loc3_.retryCount > 1)
         {
            param1.target.removeEventListener("complete",this.completeTextLoad);
            param1.target.removeEventListener("progress",this.progressLoad);
            param1.target.removeEventListener("ioError",this.errorTextLoad);
            delete this.resolver[_loc2_.getName()];
            dispatchEvent(new DCLoadingEvent("error",_loc3_.resourceName));
            --this.fileCountToLoad;
         }
         else
         {
            _loc2_.load(_loc3_.url);
            ++_loc3_.retryCount;
         }
      }
      
      private function loadBinFile(param1:String, param2:String, param3:String, param4:String = null) : void
      {
         var _loc5_:URLRequest = new URLRequest(param1);
         var _loc6_:URLLoaderWithName = new URLLoaderWithName();
         _loc6_.dataFormat = param3;
         _loc6_.load(_loc5_);
         this.resolver[_loc6_.getName()] = new ResourceLoaderObject(param2,_loc5_,null);
         this.list[param2] = _loc6_;
         this.unloader[param2] = _loc6_;
         _loc6_.addEventListener("complete",this.completeTextLoad,false,0,true);
         _loc6_.addEventListener("progress",this.progressLoad,false,0,true);
         _loc6_.addEventListener("ioError",this.errorTextLoad,false,0,true);
      }
      
      private function getLoadedSWFAppDomain(param1:String) : ApplicationDomain
      {
         var _loc2_:Loader = this.unloader[param1];
         return !!_loc2_ ? _loc2_.contentLoaderInfo.applicationDomain : null;
      }
   }
}

