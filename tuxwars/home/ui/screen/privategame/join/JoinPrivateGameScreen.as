package tuxwars.home.ui.screen.privategame.join
{
   import com.dchoc.resources.DCResourceManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.privategame.PrivateGameScreen;
   
   public class JoinPrivateGameScreen extends PrivateGameScreen
   {
       
      
      public function JoinPrivateGameScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/multiplayer.swf","multiplayer_private"),"JOIN_GAME_HEADER");
      }
   }
}
