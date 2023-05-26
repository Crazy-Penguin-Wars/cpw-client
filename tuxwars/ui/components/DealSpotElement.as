package tuxwars.ui.components
{
   import com.dchoc.utils.LogUtils;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.Security;
   import flash.utils.getTimer;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.http.HTTPService;
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
      
      public function DealSpotElement(design:MovieClip, game:TuxWarsGame)
      {
         super();
         _design = design;
         _game = game;
      }
      
      public function dispose() : void
      {
         _game = null;
         _design = null;
      }
      
      public function get design() : MovieClip
      {
         return _design;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         if(mDealStopEnable)
         {
            getDealSpotURL();
         }
      }
      
      private function getDealSpotURL() : void
      {
         var httpService:* = null;
         httpService = new HTTPService();
         if(Config.isDev() || Config.isStage())
         {
            Security.allowDomain("federalstage.digitalchocolate.com/");
            Security.loadPolicyFile("federalstage.digitalchocolate.com/crossdomain.xml");
            httpService.url = (Config.secure ? "https" : "http") + "://federalstage.digitalchocolate.com/payment/trialpay_dealspot_swf_url?game_id=Penguin_Facebook&fb_id=" + Config.platformUserId + "&on_transact=afterTrialPayCredits";
         }
         else
         {
            Security.allowDomain("federal.digitalchocolate.com/");
            Security.loadPolicyFile("federal.digitalchocolate.com/crossdomain.xml");
            Security.allowDomain("secure.digitalchocolate.com/");
            Security.loadPolicyFile("secure.digitalchocolate.com/crossdomain.xml");
            httpService.url = (Config.secure ? "https://secure.digitalchocolate.com/" : "http://federal.digitalchocolate.com/") + "payment/trialpay_dealspot_swf_url?game_id=Penguin_Facebook&fb_id=" + Config.platformUserId + "&on_transact=afterTrialPayCredits";
         }
         httpService.resultFormat = "text";
         httpService.addEventListener("result",resultHandler);
         httpService.addEventListener("fault",faultHandler);
         httpService.addEventListener("progress",progressHandler);
         httpService.addEventListener("ioError",errorLoad);
         httpService.send();
         federalCallTime = getTimer();
         mDealStopEnable = false;
      }
      
      private function progressHandler(event:ProgressEvent) : void
      {
         if(getTimer() - federalCallTime > 5000)
         {
            event.target.removeEventListener("result",resultHandler);
            event.target.removeEventListener("fault",faultHandler);
            event.target.removeEventListener("progress",progressHandler);
            event.target.removeEventListener("ioError",errorLoad);
         }
      }
      
      private function faultHandler(event:FaultEvent) : void
      {
         if(Config.debugMode)
         {
            LogUtils.log("Dealspot timeout - faultHandler : ","DealSpot",0,"DealSpot");
         }
      }
      
      private function resultHandler(event:ResultEvent) : void
      {
         var result:* = null;
         try
         {
            result = JSON.parse(event.result as String);
            if(result)
            {
               if(Config.secure)
               {
                  mDealSpotUrl = result.secure_url;
               }
               else
               {
                  mDealSpotUrl = result.url;
               }
               addDealSpotLoader();
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
         var request:* = null;
         var loader:Loader = new Loader();
         var loader_mc:MovieClip = design.getChildByName("loader") as MovieClip;
         try
         {
            loader_mc.addChild(loader);
            request = new URLRequest(mDealSpotUrl);
            loader.load(request);
            loader.contentLoaderInfo.addEventListener("complete",dealSpotLoaderComplete);
            loader.contentLoaderInfo.addEventListener("ioError",errorLoad);
         }
         catch(e:Error)
         {
            if(Config.debugMode)
            {
               LogUtils.log("addDealSpotLoader : ERROR in loading =" + e,"DealSpot",0,"DealSpot");
            }
         }
      }
      
      private function errorLoad(event:IOErrorEvent) : void
      {
         if(Config.debugMode)
         {
            LogUtils.log("Deal spot swf failed to loaded","DealSpot",0,"DealSpot");
         }
      }
      
      private function dealSpotLoaderComplete(e:Event) : void
      {
         if(Config.debugMode)
         {
            LogUtils.log("Deal spot swf load successfull","DealSpot",0,"DealSpot");
         }
      }
   }
}
