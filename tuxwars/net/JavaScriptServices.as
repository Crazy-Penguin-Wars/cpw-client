package tuxwars.net
{
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.external.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.net.objects.*;
   
   public class JavaScriptServices
   {
      private static var currentGame:TuxWarsGame;
      
      public function JavaScriptServices()
      {
         super();
         throw new Error("JavaScriptServices is a static class!");
      }
      
      public static function init(param1:TuxWarsGame) : void
      {
         currentGame = param1;
         LogUtils.addDebugLine("JavaScript","setting up ExternalInterface, available: " + ExternalInterface.available);
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("fromJavascript",fromJavascript);
         }
         GiftService.init(param1);
         NeighborService.init(param1);
         MoneyService.init(param1);
         LogUtils.addDebugLine("JavaScript","ExternalInterface set up");
      }
      
      public static function callJavascript(param1:JavaScriptObject, param2:Boolean = true) : void
      {
         if(param1 is JavaScriptCRMObject)
         {
            CRMService.addCommonCrmParametersForRequestData(param1 as JavaScriptCRMObject);
         }
         LogUtils.log("Java Script Call: " + param1.callType + " data: " + param1.toString(),"JavaScriptService",0,"JavaScript",false,false,false);
         if(ExternalInterface.available)
         {
            if(param2)
            {
               DCGame.setFullScreen(false,"showAll");
               MessageCenter.sendMessage("FullScreen",false);
            }
            ExternalInterface.call("fromFlash",param1.callType,JSON.stringify(param1));
         }
      }
      
      public static function fromJavascript(param1:String, param2:*) : void
      {
         LogUtils.addDebugLine("JavaScript","fromJavascript: " + param1 + ", data: " + param2);
         MessageCenter.sendMessage(param1,param2);
      }
   }
}

