package tuxwars.home.ui.screen.privategame.host
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.ui.logic.privategame.host.HostPrivateGameLogic;
   import tuxwars.home.ui.screen.privategame.PrivateGameScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class HostPrivateGameScreen extends PrivateGameScreen
   {
       
      
      private var playButton:UIButton;
      
      private var settingsButton:UIButton;
      
      public function HostPrivateGameScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/multiplayer.swf","multiplayer_private_host"),"HOST_GAME_HEADER");
         var _loc2_:MovieClip = getDesignMovieClip();
         playButton = TuxUiUtils.createButton(UIButton,_loc2_,"Start",playCallback,"BUTTON_PLAY");
         settingsButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Customize",settingsCallback,"BUTTON_SETTINGS");
         playButton.setEnabled(false);
      }
      
      override public function dispose() : void
      {
         playButton.dispose();
         playButton = null;
         settingsButton.dispose();
         settingsButton = null;
         super.dispose();
      }
      
      override public function update() : void
      {
         super.update();
         var _loc1_:PrivateGameModel = params;
         playButton.setEnabled(_loc1_.players.length > 1);
      }
      
      private function settingsCallback(event:MouseEvent) : void
      {
         hostLogic.showSettings();
      }
      
      private function playCallback(event:MouseEvent) : void
      {
         hostLogic.play();
      }
      
      private function get hostLogic() : HostPrivateGameLogic
      {
         return logic as HostPrivateGameLogic;
      }
   }
}
