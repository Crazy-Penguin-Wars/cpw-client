package com.dchoc.resources
{
   import flash.display.LoaderInfo;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.*;
   
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
      
      public function ResourceLoaderObject(param1:String, param2:URLRequest, param3:LoaderContext)
      {
         super();
         this.resourceName = param1;
         this.url = param2;
         this.loaderContext = param3;
      }
      
      internal function startPolling(param1:Function) : void
      {
         this.callbackWhenPolicyLoaded = param1;
         this.pollingCounter = 0;
         this.pollingTimer = new Timer(1000);
         this.pollingTimer.addEventListener("timer",this.oneSec,false,0,true);
         this.pollingTimer.start();
      }
      
      private function oneSec(param1:TimerEvent) : void
      {
         if(Boolean(this.loaderInfo) && Boolean(this.loaderInfo.childAllowsParent))
         {
            this.callbackWhenPolicyLoaded(this.loaderInfo);
            this.pollingTimer.stop();
            this.pollingTimer.removeEventListener("timer",this.oneSec);
            this.pollingTimer = null;
            return;
         }
         ++this.pollingCounter;
         if(this.pollingCounter > 15)
         {
            this.pollingTimer.stop();
            this.pollingTimer.removeEventListener("timer",this.oneSec);
            this.pollingTimer = null;
         }
      }
   }
}

