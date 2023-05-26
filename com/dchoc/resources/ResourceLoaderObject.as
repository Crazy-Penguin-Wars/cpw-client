package com.dchoc.resources
{
   import flash.display.LoaderInfo;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.Timer;
   
   internal class ResourceLoaderObject
   {
      
      private static const POLLING_TIMEOUT:int = 15;
       
      
      internal var resourceName:String;
      
      internal var url:URLRequest;
      
      internal var retryCount:int;
      
      internal var loaderContext:LoaderContext;
      
      internal var loaderInfo:LoaderInfo;
      
      private var pollingCounter:int;
      
      private var callbackWhenPolicyLoaded:Function;
      
      private var pollingTimer:Timer;
      
      public function ResourceLoaderObject(resourceName:String, url:URLRequest, loaderContext:LoaderContext)
      {
         super();
         this.resourceName = resourceName;
         this.url = url;
         this.loaderContext = loaderContext;
      }
      
      internal function startPolling(callback:Function) : void
      {
         callbackWhenPolicyLoaded = callback;
         pollingCounter = 0;
         pollingTimer = new Timer(1000);
         pollingTimer.addEventListener("timer",oneSec,false,0,true);
         pollingTimer.start();
      }
      
      private function oneSec(e:TimerEvent) : void
      {
         if(loaderInfo && loaderInfo.childAllowsParent)
         {
            callbackWhenPolicyLoaded(loaderInfo);
            pollingTimer.stop();
            pollingTimer.removeEventListener("timer",oneSec);
            pollingTimer = null;
            return;
         }
         pollingCounter++;
         if(pollingCounter > 15)
         {
            pollingTimer.stop();
            pollingTimer.removeEventListener("timer",oneSec);
            pollingTimer = null;
         }
      }
   }
}
