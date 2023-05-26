package tuxwars.ui.components
{
   import com.dchoc.game.DCGame;
   import com.dchoc.media.DCSoundManager;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.chat.ChatMessage;
   import tuxwars.battle.net.messages.control.ChickeningOutMessage;
   import tuxwars.data.SoundManager;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.net.CRMService;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.exitquestion.ExitQuestionPopUpSubState;
   import tuxwars.utils.TuxUiUtils;
   
   public class ToolsElementScreen extends TuxUIElementScreen
   {
      
      private static const TIME_BEFORE_AUTO_CLOSE_SETTINGS:int = 5000;
      
      private static const OPTIONS_CONTAINER:String = "Options_Bar";
      
      private static const BUTTON_FULLSCREEN:String = "Button_Fullscreen";
      
      private static const BUTTON_QUALITY:String = "Button_Quality";
      
      private static const BUTTON_MUSIC:String = "Button_Music";
      
      private static const BUTTON_SOUNDS:String = "Button_Sounds";
      
      private static const BUTTON_ON:String = "Button_On";
      
      private static const BUTTON_OFF:String = "Button_Off";
      
      private static const ANIM_IN:String = "Visible_To_Hover";
      
      private static const ANIM_OUT:String = "Hover_To_Visible";
       
      
      private var fullscreenOnButton:UIButton;
      
      private var fullscreenOffButton:UIButton;
      
      private var qualityOnButton:UIButton;
      
      private var qualityOffButton:UIButton;
      
      private var musicOnButton:UIButton;
      
      private var musicOffButton:UIButton;
      
      private var soundsOnButton:UIButton;
      
      private var soundsOffButton:UIButton;
      
      private var exitButton:UIButton;
      
      private var optionsContainer:MovieClip;
      
      private var settingsOpenTimer:Timer;
      
      public function ToolsElementScreen(from:MovieClip, game:TuxWarsGame)
      {
         optionsContainer = from.getChildByName("Options_Bar") as MovieClip;
         super(optionsContainer,game);
         optionsContainer.mouseEnabled = false;
         optionsContainer.mouseChildren = false;
         var _loc5_:MovieClip = optionsContainer.getChildByName("Button_Fullscreen") as MovieClip;
         fullscreenOnButton = TuxUiUtils.createButton(UIButton,_loc5_,"Button_On",fullscreenOn);
         fullscreenOffButton = TuxUiUtils.createButton(UIButton,_loc5_,"Button_Off",fullscreenOff);
         fullscreenOffButton.setVisible(DCGame.isFullScreen());
         fullscreenOnButton.setVisible(!DCGame.isFullScreen());
         var _loc4_:MovieClip = optionsContainer.getChildByName("Button_Quality") as MovieClip;
         qualityOnButton = TuxUiUtils.createButton(UIButton,_loc4_,"Button_On",qualityOn);
         qualityOffButton = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Off",qualityOff);
         qualityOffButton.setVisible(false);
         var _loc6_:MovieClip = optionsContainer.getChildByName("Button_Music") as MovieClip;
         musicOnButton = TuxUiUtils.createButton(UIButton,_loc6_,"Button_On",musicOn);
         musicOffButton = TuxUiUtils.createButton(UIButton,_loc6_,"Button_Off",musicOff);
         musicOnButton.setVisible(DCSoundManager.getInstance().isMusicOn());
         musicOffButton.setVisible(!DCSoundManager.getInstance().isMusicOn());
         var _loc3_:MovieClip = optionsContainer.getChildByName("Button_Sounds") as MovieClip;
         soundsOnButton = TuxUiUtils.createButton(UIButton,_loc3_,"Button_On",soundsOn);
         soundsOffButton = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Off",soundsOff);
         soundsOnButton.setVisible(DCSoundManager.getInstance().isSfxOn());
         soundsOffButton.setVisible(!DCSoundManager.getInstance().isSfxOn());
         if(optionsContainer.getChildByName("Button_Exit"))
         {
            exitButton = TuxUiUtils.createButton(UIButton,optionsContainer,"Button_Exit",exitCallback);
            enableExitButton();
            var _loc7_:Tutorial = Tutorial;
            if(tuxwars.tutorial.Tutorial._tutorial)
            {
               disableExitButton();
            }
         }
         var _loc8_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            disableFullScreenButtons();
            MessageCenter.addListener("TutorialEnd",tutorialEnded);
         }
         setShowTransitions(false);
         setVisible(false);
         setShowTransitions(true);
      }
      
      override public function dispose() : void
      {
         optionsContainer = null;
         fullscreenOnButton.dispose();
         fullscreenOnButton = null;
         qualityOnButton.dispose();
         qualityOnButton = null;
         musicOnButton.dispose();
         musicOnButton = null;
         soundsOnButton.dispose();
         soundsOnButton = null;
         fullscreenOffButton.dispose();
         fullscreenOffButton = null;
         qualityOffButton.dispose();
         qualityOffButton = null;
         musicOffButton.dispose();
         musicOffButton = null;
         soundsOffButton.dispose();
         soundsOffButton = null;
         if(exitButton)
         {
            exitButton.dispose();
            exitButton = null;
         }
         MessageCenter.removeListener("TutorialEnd",tutorialEnded);
         stopAutoCloseTimer();
         super.dispose();
      }
      
      override public function fullscreenChanged(fullscreen:Boolean) : void
      {
         super.fullscreenChanged(fullscreen);
         fullscreenOffButton.setVisible(DCGame.isFullScreen());
         fullscreenOnButton.setVisible(!DCGame.isFullScreen());
      }
      
      public function optionsCallback(event:MouseEvent) : void
      {
         if(getVisible())
         {
            animOut();
         }
         else
         {
            animIn();
            startAutoCloseTimer();
         }
      }
      
      public function startAutoCloseTimer() : void
      {
         settingsOpenTimer = new Timer(5000,1);
         settingsOpenTimer.addEventListener("timer",closeSettings,false,0,true);
         settingsOpenTimer.reset();
         settingsOpenTimer.start();
      }
      
      public function stopAutoCloseTimer() : void
      {
         if(settingsOpenTimer)
         {
            settingsOpenTimer.stop();
            settingsOpenTimer.removeEventListener("timer",closeSettings);
         }
      }
      
      public function resetSettingsCloseTimer() : void
      {
         if(settingsOpenTimer && settingsOpenTimer.running)
         {
            settingsOpenTimer.reset();
            settingsOpenTimer.start();
         }
      }
      
      public function disableFullScreenButtons() : void
      {
         fullscreenOnButton.setEnabled(false);
         fullscreenOffButton.setEnabled(false);
      }
      
      public function enableFullScreenButtons() : void
      {
         fullscreenOnButton.setEnabled(true);
         fullscreenOffButton.setEnabled(true);
      }
      
      public function disableExitButton() : void
      {
         exitButton.setEnabled(false);
      }
      
      public function enableExitButton() : void
      {
         exitButton.setEnabled(true);
      }
      
      private function closeSettings(event:TimerEvent) : void
      {
         if(getVisible())
         {
            animOut();
         }
      }
      
      private function animIn() : void
      {
         setVisible(true);
         optionsContainer.mouseEnabled = true;
         optionsContainer.mouseChildren = true;
      }
      
      private function animOut() : void
      {
         stopAutoCloseTimer();
         setVisible(false);
         optionsContainer.mouseEnabled = false;
         optionsContainer.mouseChildren = false;
      }
      
      private function fullscreenOn(event:MouseEvent) : void
      {
         resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","FullScreen on");
         DCGame.setFullScreen(true,"noScale");
         fullscreenOnButton.setVisible(false);
         fullscreenOffButton.setVisible(true);
         event.stopImmediatePropagation();
      }
      
      private function fullscreenOff(event:MouseEvent) : void
      {
         resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","FullScreen off");
         DCGame.setFullScreen(false,"showAll");
         fullscreenOnButton.setVisible(true);
         fullscreenOffButton.setVisible(false);
         event.stopImmediatePropagation();
      }
      
      private function qualityOn(event:MouseEvent) : void
      {
         resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","Quality low");
         DCGame.setQuality("low");
         qualityOffButton.setVisible(true);
         qualityOnButton.setVisible(false);
         event.stopImmediatePropagation();
      }
      
      private function qualityOff(event:MouseEvent) : void
      {
         resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","Quality high");
         DCGame.setQuality("high");
         qualityOffButton.setVisible(false);
         qualityOnButton.setVisible(true);
         event.stopImmediatePropagation();
      }
      
      private function musicOn(event:MouseEvent) : void
      {
         resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","Music off");
         musicOffButton.setVisible(true);
         musicOnButton.setVisible(false);
         DCSoundManager.getInstance().setMusicOn(false);
         event.stopImmediatePropagation();
         SoundManager.saveMusicState();
      }
      
      private function musicOff(event:MouseEvent) : void
      {
         resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","Music on");
         musicOffButton.setVisible(false);
         musicOnButton.setVisible(true);
         DCSoundManager.getInstance().setMusicOn(true);
         SoundManager.continueMusic();
         event.stopImmediatePropagation();
         SoundManager.saveMusicState();
      }
      
      private function soundsOn(event:MouseEvent) : void
      {
         resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","SoundFx off");
         soundsOffButton.setVisible(true);
         soundsOnButton.setVisible(false);
         DCSoundManager.getInstance().setSfxOn(false);
         SoundManager.clearSfxList();
         event.stopImmediatePropagation();
         SoundManager.saveSfxState();
      }
      
      private function soundsOff(event:MouseEvent) : void
      {
         resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","SoundFx on");
         soundsOffButton.setVisible(false);
         soundsOnButton.setVisible(true);
         DCSoundManager.getInstance().setSfxOn(true);
         event.stopImmediatePropagation();
         SoundManager.saveSfxState();
      }
      
      private function exitCallback(event:MouseEvent) : void
      {
         if(!BattleManager.isPracticeMode())
         {
            MessageCenter.sendEvent(new ChatMessage(game.player.id,null,"EXIT_PRESSED_INGAME"));
            MessageCenter.sendEvent(new ChickeningOutMessage(game.player.id,1));
            CRMService.sendEvent("Game","Battle_Ended","Clicked","PressExit");
         }
         var _loc2_:PopUpManager = PopUpManager;
         if(!tuxwars.ui.popups.PopUpManager._instance)
         {
            tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
         }
         tuxwars.ui.popups.PopUpManager._instance.addPopup(new ExitQuestionPopUpSubState(game));
         var _loc3_:PopUpManager = PopUpManager;
         if(!tuxwars.ui.popups.PopUpManager._instance)
         {
            tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
         }
         tuxwars.ui.popups.PopUpManager._instance.showPopUps(game.battleState);
      }
      
      private function tutorialEnded(msg:Message) : void
      {
         MessageCenter.removeListener("TutorialEnd",tutorialEnded);
         enableFullScreenButtons();
      }
   }
}
