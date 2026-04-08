package tuxwars.ui.components
{
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.*;
   import flash.system.*;
   import flash.utils.*;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.http.*;
   import tuxwars.TuxWarsGame;
   
   public class DealSpotElement
   {
      private static const DEALSPOT:String = "Deal_spot_button";
      
      private var _design:MovieClip;
      
      private var _game:TuxWarsGame;
      
      private var mDealSpotUrl:String = "";
      
      private var federalCallTime:int;
      
      private var mDealSpot:MovieClip;
      
      public var mDealStopEnable:Boolean = true;
      
      public function DealSpotElement(param1:MovieClip, param2:TuxWarsGame)
      {
         super();
         this._design = param1;
         this._game = param2;
      }
      
      public function dispose() : void
      {
         this._game = null;
         this._design = null;
      }
      
      public function get design() : MovieClip
      {
         return this._design;
      }
      
      public function logicUpdate(param1:int) : void
      {
         if(this.mDealStopEnable)
         {
            this.getDealSpotURL();
         }
      }
      
      private function getDealSpotURL() : void
      {
         var _loc1_:HTTPService = null;
         _loc1_ = new HTTPService();
         if(Config.isDev() || Config.isStage())
         {
            Security.allowDomain("federalstage.digitalchocolate.com/");
            Security.loadPolicyFile("federalstage.digitalchocolate.com/crossdomain.xml");
            _loc1_.url = (Config.secure ? "https" : "http") + "://federalstage.digitalchocolate.com/payment/trialpay_dealspot_swf_url?game_id=Penguin_Facebook&fb_id=" + Config.platformUserId + "&on_transact=afterTrialPayCredits";
         }
         else
         {
            Security.allowDomain("federal.digitalchocolate.com/");
            Security.loadPolicyFile("federal.digitalchocolate.com/crossdomain.xml");
            Security.allowDomain("secure.digitalchocolate.com/");
            Security.loadPolicyFile("secure.digitalchocolate.com/crossdomain.xml");
            _loc1_.url = (Config.secure ? "https://secure.digitalchocolate.com/" : "http://federal.digitalchocolate.com/") + "payment/trialpay_dealspot_swf_url?game_id=Penguin_Facebook&fb_id=" + Config.platformUserId + "&on_transact=afterTrialPayCredits";
         }
         _loc1_.resultFormat = "text";
         _loc1_.addEventListener("result",this.resultHandler);
         _loc1_.addEventListener("fault",this.faultHandler);
         _loc1_.addEventListener("progress",this.progressHandler);
         _loc1_.addEventListener("ioError",this.errorLoad);
         _loc1_.send();
         this.federalCallTime = getTimer();
         this.mDealStopEnable = false;
      }
      
      private function progressHandler(param1:ProgressEvent) : void
      {
         if(getTimer() - this.federalCallTime > 5000)
         {
            param1.target.removeEventListener("result",this.resultHandler);
            param1.target.removeEventListener("fault",this.faultHandler);
            param1.target.removeEventListener("progress",this.progressHandler);
            param1.target.removeEventListener("ioError",this.errorLoad);
         }
      }
      
      private function faultHandler(param1:FaultEvent) : void
      {
         if(Config.debugMode)
         {
            LogUtils.log("Dealspot timeout - faultHandler : ","DealSpot",0,"DealSpot");
         }
      }
      
      private function resultHandler(param1:ResultEvent) : void
      {
         var event:ResultEvent = param1;
         var result:Object = null;
         try
         {
            result = JSON.parse(event.result as String);
            if(result)
            {
               if(Config.secure)
               {
                  this.mDealSpotUrl = result.secure_url;
               }
               else
               {
                  this.mDealSpotUrl = result.url;
               }
               this.addDealSpotLoader();
            }
         }
         catch(e:Error)
         {
            if(Config.debugMode)
            {
               LogUtils.log("resultHandler : catch : " + e,"DealSpot",0,"DealSpot");
            }
         }
      }
      
      private function addDealSpotLoader() : void
      {
         var request:URLRequest = null;
         var loader:Loader = new Loader();
         var loader_mc:MovieClip = this.design.getChildByName("loader") as MovieClip;
         try
         {
            loader_mc.addChild(loader);
            request = new URLRequest(this.mDealSpotUrl);
            loader.load(request);
            loader.contentLoaderInfo.addEventListener("complete",this.dealSpotLoaderComplete);
            loader.contentLoaderInfo.addEventListener("ioError",this.errorLoad);
         }
         catch(e:Error)
         {
            if(Config.debugMode)
            {
               LogUtils.log("addDealSpotLoader : ERROR in loading =" + e,"DealSpot",0,"DealSpot");
            }
         }
      }
      
      private function errorLoad(param1:IOErrorEvent) : void
      {
         if(Config.debugMode)
         {
            LogUtils.log("Deal spot swf failed to loaded","DealSpot",0,"DealSpot");
         }
      }
      
      private function dealSpotLoaderComplete(param1:Event) : void
      {
         if(Config.debugMode)
         {
            LogUtils.log("Deal spot swf load successfull","DealSpot",0,"DealSpot");
         }
      }
   }
}

