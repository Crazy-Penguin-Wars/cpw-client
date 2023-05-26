package tuxwars.net
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import flash.external.ExternalInterface;
   import tuxwars.TuxWarsGame;
   import tuxwars.net.objects.JavaScriptCRMObject;
   import tuxwars.net.objects.JavaScriptObject;
   
   public class JavaScriptServices
   {
      
      private static var currentGame:TuxWarsGame;
       
      
      public function JavaScriptServices()
      {
         super();
         throw new Error("JavaScriptServices is a static class!");
      }
      
      public static function init(game:TuxWarsGame) : void
      {
         currentGame = game;
         LogUtils.addDebugLine("JavaScript","setting up ExternalInterface, available: " + ExternalInterface.available);
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("fromJavascript",fromJavascript);
         }
         GiftService.init(game);
         NeighborService.init(game);
         MoneyService.init(game);
         LogUtils.addDebugLine("JavaScript","ExternalInterface set up");
      }
      
      public static function callJavascript(data:JavaScriptObject, leaveFullScreen:Boolean = true) : void
      {
         if(data is JavaScriptCRMObject)
         {
            CRMService.addCommonCrmParametersForRequestData(data as JavaScriptCRMObject);
         }
         LogUtils.log("Java Script Call: " + data.callType + " data: " + data.toString(),"JavaScriptService",0,"JavaScript",false,false,false);
         if(ExternalInterface.available)
         {
            if(leaveFullScreen)
            {
               DCGame.setFullScreen(false,"showAll");
               MessageCenter.sendMessage("FullScreen",false);
            }
            ExternalInterface.call("fromFlash",data.callType,JSON.stringify(data));
         }
      }
      
      public static function fromJavascript(callType:String, data:*) : void
      {
         LogUtils.addDebugLine("JavaScript","fromJavascript: " + callType + ", data: " + data);
         MessageCenter.sendMessage(callType,data);
      }
   }
}
