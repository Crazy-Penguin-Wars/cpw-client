package tuxwars.home.ui.screen.customgame
{
   import com.dchoc.game.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.FullScreenEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.customgame.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.utils.*;
   
   public class CustomGameScreen extends TuxUIScreen
   {
      private static const MIN_NAME_LENGTH:int = 1;
      
      private var input:UIAutoTextField;
      
      private var closeButton:UIButton;
      
      private var practiceButton:UIButton;
      
      private var createGameButton:UIButton;
      
      private var joinGameButton:UIButton;
      
      public function CustomGameScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/multiplayer.swf","multiplayer_custom"));
         var _loc2_:MovieClip = getDesignMovieClip();
         TuxUiUtils.createAutoTextField(_loc2_.Text_Header,"CUSTOM_GAME_TITLE");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Practice_Header,"CUSTOM_GAME_PRACTICE_HEADER");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Practice_Description,"CUSTOM_GAME_PRACTICE_DESCRIPTION");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Private_Header,"CUSTOM_GAME_PRIVATE_HEADER");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Private_Description,"CUSTOM_GAME_PRIVATE_DESCRIPTION");
         this.input = TuxUiUtils.createAutoTextFieldWithText(_loc2_.Text_Input,"");
         this.initInputTextField(DCGame.isFullScreen());
         this.closeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Close",this.closeCallback);
         this.practiceButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Practice",this.practiceCallback,"BUTTON_PRACTICE");
         this.createGameButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Create",this.createCallback,"BUTTON_CREATE");
         this.createGameButton.setEnabled(false);
         this.joinGameButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Join",this.joinCallback,"BUTTON_JOIN");
         this.joinGameButton.setEnabled(false);
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      private function initInputTextField(param1:Boolean) : void
      {
         this.input.getTextField().mouseEnabled = !param1;
         this.input.getTextField().selectable = !param1;
         if(param1)
         {
            this.input.setText(ProjectManager.getText("NO_KEYBOARD_IN_FULLSCREEN"));
         }
         else
         {
            this.input.getTextField().addEventListener("click",this.inputClick,false,0,true);
            this.input.setText(ProjectManager.getText("DEFAULT_GAME_NAME"));
         }
      }
      
      override protected function fullscreenChanged(param1:FullScreenEvent) : void
      {
         super.fullscreenChanged(param1);
         this.initInputTextField(param1.fullScreen);
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         this.input.getTextField().removeEventListener("click",this.inputClick);
         this.input.getTextField().removeEventListener("keyUp",this.inputCallback);
         this.input = null;
         this.closeButton.dispose();
         this.closeButton = null;
         this.practiceButton.dispose();
         this.practiceButton = null;
         this.createGameButton.dispose();
         this.createGameButton = null;
         this.joinGameButton.dispose();
         this.joinGameButton = null;
         super.dispose();
      }
      
      private function joinCallback(param1:MouseEvent) : void
      {
         this.joinGameButton.setEnabled(false);
         this.customGameLogic.joinGame(this.input.getTextField().text);
      }
      
      private function createCallback(param1:MouseEvent) : void
      {
         this.createGameButton.setEnabled(false);
         this.customGameLogic.createGame(this.input.getTextField().text);
      }
      
      private function closeCallback(param1:MouseEvent) : void
      {
         this.customGameLogic.quit();
      }
      
      private function practiceCallback(param1:MouseEvent) : void
      {
         this.practiceButton.setEnabled(false);
         this.customGameLogic.practice();
      }
      
      private function inputClick(param1:MouseEvent) : void
      {
         this.input.getTextField().text = "";
         this.input.getTextField().removeEventListener("click",this.inputClick);
         this.input.getTextField().addEventListener("keyUp",this.inputCallback,false,0,true);
      }
      
      private function inputCallback(param1:KeyboardEvent) : void
      {
         var _loc2_:* = this.input.getTextField().text.length >= 1;
         this.createGameButton.setEnabled(_loc2_);
         this.joinGameButton.setEnabled(_loc2_);
      }
      
      private function get customGameLogic() : CustomGameLogic
      {
         return logic as CustomGameLogic;
      }
   }
}

