package
{
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import tuxwars.*;
   import tuxwars.net.*;
   CONFIG::BUILD_FOR_PC {
      import tuxwars.net.login.LoginService;
   }
   import flash.system.Capabilities;
   
   public class GameLauncher extends Sprite
   {
      private var game:TuxWarsGame;

      CONFIG::BUILD_FOR_PC {
         private var loginUI:LoginService;
      }
      
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
		  
		 CONFIG::BUILD_FOR_BROWSER {
			 var _loc2_:Date = new Date();
			 Config.setGameCreatedDate(new Date());
			 LogUtils.log("Creating game. " + _loc2_,"GameLauncher",1,"Game",true,false,true);
			 this.game = new TuxWarsGame(stage);
			 stage.addEventListener(Event.RESIZE, this.onStageResize, false, 0, true);
		 }

		 CONFIG::BUILD_FOR_PC {
			 stage.scaleMode = "noScale"; // needed for login page to support resizing the window
			 stage.nativeWindow.maximize();
			 loginUI = new LoginService(stage);
			 loginUI.addEventListener(Event.COMPLETE, onLoginFinished);
			 loginUI.startLogin();
		 }
      }

      private function onLoginFinished(event:Event):void {
         Config.setGameCreatedDate(new Date());
         LogUtils.log("Creating game after login.","GameLauncher",1,"Game",true,false,true);
         this.game = new TuxWarsGame(stage);
		 stage.addEventListener(Event.RESIZE, this.onStageResize, false, 0, true);
      }

      // Should only run in AIR
      private function onStageResize(event:Event) : void {
         // just calling a fake full screen event
         stage.dispatchEvent(new FullScreenEvent(FullScreenEvent.FULL_SCREEN, false, false, true));
      }
   }
}

