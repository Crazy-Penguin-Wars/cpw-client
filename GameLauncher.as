package
{
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import tuxwars.*;
   import tuxwars.net.*;
   import tuxwars.net.login.LoginService;
   import flash.system.Capabilities;
   
   public class GameLauncher extends Sprite
   {
      private var game:TuxWarsGame;
      private var loginUI:LoginService;
      
      public function GameLauncher()
      {
         super();
         addEventListener("addedToStage",this.addedToStage);
      }
      
      private function addedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",this.addedToStage);
         DCResourceManager.setCrossDomainPrefix("tuxwars");
         CRMService.sendEvent("Level","Session Started","OnFlash",Config.getOSStr());
         var _loc2_:Date = new Date();

         stage.scaleMode = "noScale"; // needed for login page to support resizing the window
         stage.nativeWindow.maximize();
         loginUI = new LoginService(stage);
         loginUI.addEventListener(Event.COMPLETE, onLoginFinished);
         loginUI.showLogin();
      }

      private function onLoginFinished(event:Event):void {
         Config.setGameCreatedDate(new Date());
         if (Capabilities.playerType != "Desktop") {
            stage.scaleMode = "showAll"; // reset scale mode for the game: only in browser
         }
         LogUtils.log("Creating game after login.","GameLauncher",1,"Game",true,false,true);
         this.game = new TuxWarsGame(stage);
         if (Capabilities.playerType == "Desktop") { // Desktop = AIR
            stage.addEventListener(Event.RESIZE, this.onStageResize, false, 0, true);
         } else {
            stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreenChange);
         }
      }

      // Should only run in browser flash
      private function onFullScreenChange(event: FullScreenEvent) : void {
         if (event.fullScreen) {
            stage.scaleMode = "noScale";
         } else {
            stage.scaleMode = "showAll";
         }
      }

      // Should only run in AIR
      private function onStageResize(event:Event) : void {
         // just calling a fake full screen event
         stage.dispatchEvent(new FullScreenEvent(FullScreenEvent.FULL_SCREEN, false, false, true));
      }
   }
}

