package
{
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.Sprite;
   import flash.events.Event;
   import tuxwars.*;
   import tuxwars.net.*;
   
   public class GameLauncher extends Sprite
   {
      private var game:TuxWarsGame;
      
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
         Config.setGameCreatedDate(_loc2_);
         LogUtils.log("Creating game. " + _loc2_,"GameLauncher",1,"Game",true,false,true);
         this.game = new TuxWarsGame(stage);
      }
   }
}

