package tuxwars.home.ui.screen.privategame.host
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.ui.logic.privategame.host.*;
   import tuxwars.home.ui.screen.privategame.PrivateGameScreen;
   import tuxwars.utils.*;
   
   public class HostPrivateGameScreen extends PrivateGameScreen
   {
      private var playButton:UIButton;
      
      private var settingsButton:UIButton;
      
      public function HostPrivateGameScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/multiplayer.swf","multiplayer_private_host"),"HOST_GAME_HEADER");
         var _loc2_:MovieClip = getDesignMovieClip();
         this.playButton = TuxUiUtils.createButton(UIButton,_loc2_,"Start",this.playCallback,"BUTTON_PLAY");
         this.settingsButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Customize",this.settingsCallback,"BUTTON_SETTINGS");
         this.playButton.setEnabled(false);
      }
      
      override public function dispose() : void
      {
         this.playButton.dispose();
         this.playButton = null;
         this.settingsButton.dispose();
         this.settingsButton = null;
         super.dispose();
      }
      
      override public function update() : void
      {
         super.update();
         var _loc1_:PrivateGameModel = params;
         this.playButton.setEnabled(_loc1_.players.length > 1);
      }
      
      private function settingsCallback(param1:MouseEvent) : void
      {
         this.hostLogic.showSettings();
      }
      
      private function playCallback(param1:MouseEvent) : void
      {
         this.hostLogic.play();
      }
      
      private function get hostLogic() : HostPrivateGameLogic
      {
         return logic as HostPrivateGameLogic;
      }
   }
}

