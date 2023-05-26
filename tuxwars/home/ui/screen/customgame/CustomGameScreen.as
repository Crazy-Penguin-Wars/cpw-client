package tuxwars.home.ui.screen.customgame
{
   import com.dchoc.game.DCGame;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.FullScreenEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.customgame.CustomGameLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class CustomGameScreen extends TuxUIScreen
   {
      
      private static const MIN_NAME_LENGTH:int = 1;
       
      
      private var input:UIAutoTextField;
      
      private var closeButton:UIButton;
      
      private var practiceButton:UIButton;
      
      private var createGameButton:UIButton;
      
      private var joinGameButton:UIButton;
      
      public function CustomGameScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/multiplayer.swf","multiplayer_custom"));
         var _loc2_:MovieClip = getDesignMovieClip();
         TuxUiUtils.createAutoTextField(_loc2_.Text_Header,"CUSTOM_GAME_TITLE");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Practice_Header,"CUSTOM_GAME_PRACTICE_HEADER");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Practice_Description,"CUSTOM_GAME_PRACTICE_DESCRIPTION");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Private_Header,"CUSTOM_GAME_PRIVATE_HEADER");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Private_Description,"CUSTOM_GAME_PRIVATE_DESCRIPTION");
         input = TuxUiUtils.createAutoTextFieldWithText(_loc2_.Text_Input,"");
         initInputTextField(DCGame.isFullScreen());
         closeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Close",closeCallback);
         practiceButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Practice",practiceCallback,"BUTTON_PRACTICE");
         createGameButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Create",createCallback,"BUTTON_CREATE");
         createGameButton.setEnabled(false);
         joinGameButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Join",joinCallback,"BUTTON_JOIN");
         joinGameButton.setEnabled(false);
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      private function initInputTextField(fullscreen:Boolean) : void
      {
         input.getTextField().mouseEnabled = !fullscreen;
         input.getTextField().selectable = !fullscreen;
         if(fullscreen)
         {
            input.setText(ProjectManager.getText("NO_KEYBOARD_IN_FULLSCREEN"));
         }
         else
         {
            input.getTextField().addEventListener("click",inputClick,false,0,true);
            input.setText(ProjectManager.getText("DEFAULT_GAME_NAME"));
         }
      }
      
      override protected function fullscreenChanged(event:FullScreenEvent) : void
      {
         super.fullscreenChanged(event);
         initInputTextField(event.fullScreen);
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         input.getTextField().removeEventListener("click",inputClick);
         input.getTextField().removeEventListener("keyUp",inputCallback);
         input = null;
         closeButton.dispose();
         closeButton = null;
         practiceButton.dispose();
         practiceButton = null;
         createGameButton.dispose();
         createGameButton = null;
         joinGameButton.dispose();
         joinGameButton = null;
         super.dispose();
      }
      
      private function joinCallback(event:MouseEvent) : void
      {
         joinGameButton.setEnabled(false);
         customGameLogic.joinGame(input.getTextField().text);
      }
      
      private function createCallback(event:MouseEvent) : void
      {
         createGameButton.setEnabled(false);
         customGameLogic.createGame(input.getTextField().text);
      }
      
      private function closeCallback(event:MouseEvent) : void
      {
         customGameLogic.quit();
      }
      
      private function practiceCallback(event:MouseEvent) : void
      {
         practiceButton.setEnabled(false);
         customGameLogic.practice();
      }
      
      private function inputClick(event:MouseEvent) : void
      {
         input.getTextField().text = "";
         input.getTextField().removeEventListener("click",inputClick);
         input.getTextField().addEventListener("keyUp",inputCallback,false,0,true);
      }
      
      private function inputCallback(event:KeyboardEvent) : void
      {
         var _loc2_:Boolean = input.getTextField().text.length >= 1;
         createGameButton.setEnabled(_loc2_);
         joinGameButton.setEnabled(_loc2_);
      }
      
      private function get customGameLogic() : CustomGameLogic
      {
         return logic as CustomGameLogic;
      }
   }
}
