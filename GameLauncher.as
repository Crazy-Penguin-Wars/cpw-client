package
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.LogUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import tuxwars.TuxWarsGame;
   import tuxwars.net.CRMService;
   
   public class GameLauncher extends Sprite
   {
       
      
      private var game:TuxWarsGame;
      
      public function GameLauncher()
      {
         super();
         addEventListener("addedToStage",addedToStage);
      }
      
      private function addedToStage(event:Event) : void
      {
         removeEventListener("addedToStage",addedToStage);
         DCResourceManager.setCrossDomainPrefix("tuxwars");
         CRMService.sendEvent("Level","Session Started","OnFlash",Config.getOSStr());
         var _loc2_:Date = new Date();
         Config.setGameCreatedDate(_loc2_);
         LogUtils.log("Creating game. " + _loc2_,"GameLauncher",1,"Game",true,false,true);
         game = new TuxWarsGame(stage);
      }
   }
}
