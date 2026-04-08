package tuxwars.ui.components
{
   import com.dchoc.game.*;
   import com.dchoc.media.*;
   import com.dchoc.messages.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.net.messages.chat.*;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.data.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.net.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.exitquestion.*;
   import tuxwars.utils.*;
   
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
      
      public function ToolsElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         this.optionsContainer = param1.getChildByName("Options_Bar") as MovieClip;
         super(this.optionsContainer,param2);
         this.optionsContainer.mouseEnabled = false;
         this.optionsContainer.mouseChildren = false;
         var _loc3_:MovieClip = this.optionsContainer.getChildByName("Button_Fullscreen") as MovieClip;
         this.fullscreenOnButton = TuxUiUtils.createButton(UIButton,_loc3_,"Button_On",this.fullscreenOn);
         this.fullscreenOffButton = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Off",this.fullscreenOff);
         this.fullscreenOffButton.setVisible(DCGame.isFullScreen());
         this.fullscreenOnButton.setVisible(!DCGame.isFullScreen());
         var _loc4_:MovieClip = this.optionsContainer.getChildByName("Button_Quality") as MovieClip;
         this.qualityOnButton = TuxUiUtils.createButton(UIButton,_loc4_,"Button_On",this.qualityOn);
         this.qualityOffButton = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Off",this.qualityOff);
         this.qualityOffButton.setVisible(false);
         var _loc5_:MovieClip = this.optionsContainer.getChildByName("Button_Music") as MovieClip;
         this.musicOnButton = TuxUiUtils.createButton(UIButton,_loc5_,"Button_On",this.musicOn);
         this.musicOffButton = TuxUiUtils.createButton(UIButton,_loc5_,"Button_Off",this.musicOff);
         this.musicOnButton.setVisible(DCSoundManager.getInstance().isMusicOn());
         this.musicOffButton.setVisible(!DCSoundManager.getInstance().isMusicOn());
         var _loc6_:MovieClip = this.optionsContainer.getChildByName("Button_Sounds") as MovieClip;
         this.soundsOnButton = TuxUiUtils.createButton(UIButton,_loc6_,"Button_On",this.soundsOn);
         this.soundsOffButton = TuxUiUtils.createButton(UIButton,_loc6_,"Button_Off",this.soundsOff);
         this.soundsOnButton.setVisible(DCSoundManager.getInstance().isSfxOn());
         this.soundsOffButton.setVisible(!DCSoundManager.getInstance().isSfxOn());
         if(this.optionsContainer.getChildByName("Button_Exit"))
         {
            this.exitButton = TuxUiUtils.createButton(UIButton,this.optionsContainer,"Button_Exit",this.exitCallback);
            this.enableExitButton();
            if(Tutorial._tutorial)
            {
               this.disableExitButton();
            }
         }
         if(Tutorial._tutorial)
         {
            this.disableFullScreenButtons();
            MessageCenter.addListener("TutorialEnd",this.tutorialEnded);
         }
         setShowTransitions(false);
         setVisible(false);
         setShowTransitions(true);
      }
      
      override public function dispose() : void
      {
         this.optionsContainer = null;
         this.fullscreenOnButton.dispose();
         this.fullscreenOnButton = null;
         this.qualityOnButton.dispose();
         this.qualityOnButton = null;
         this.musicOnButton.dispose();
         this.musicOnButton = null;
         this.soundsOnButton.dispose();
         this.soundsOnButton = null;
         this.fullscreenOffButton.dispose();
         this.fullscreenOffButton = null;
         this.qualityOffButton.dispose();
         this.qualityOffButton = null;
         this.musicOffButton.dispose();
         this.musicOffButton = null;
         this.soundsOffButton.dispose();
         this.soundsOffButton = null;
         if(this.exitButton)
         {
            this.exitButton.dispose();
            this.exitButton = null;
         }
         MessageCenter.removeListener("TutorialEnd",this.tutorialEnded);
         this.stopAutoCloseTimer();
         super.dispose();
      }
      
      override public function fullscreenChanged(param1:Boolean) : void
      {
         super.fullscreenChanged(param1);
         this.fullscreenOffButton.setVisible(DCGame.isFullScreen());
         this.fullscreenOnButton.setVisible(!DCGame.isFullScreen());
      }
      
      public function optionsCallback(param1:MouseEvent) : void
      {
         if(getVisible())
         {
            this.animOut();
         }
         else
         {
            this.animIn();
            this.startAutoCloseTimer();
         }
      }
      
      public function startAutoCloseTimer() : void
      {
         this.settingsOpenTimer = new Timer(5000,1);
         this.settingsOpenTimer.addEventListener("timer",this.closeSettings,false,0,true);
         this.settingsOpenTimer.reset();
         this.settingsOpenTimer.start();
      }
      
      public function stopAutoCloseTimer() : void
      {
         if(this.settingsOpenTimer)
         {
            this.settingsOpenTimer.stop();
            this.settingsOpenTimer.removeEventListener("timer",this.closeSettings);
         }
      }
      
      public function resetSettingsCloseTimer() : void
      {
         if(Boolean(this.settingsOpenTimer) && Boolean(this.settingsOpenTimer.running))
         {
            this.settingsOpenTimer.reset();
            this.settingsOpenTimer.start();
         }
      }
      
      public function disableFullScreenButtons() : void
      {
         this.fullscreenOnButton.setEnabled(false);
         this.fullscreenOffButton.setEnabled(false);
      }
      
      public function enableFullScreenButtons() : void
      {
         this.fullscreenOnButton.setEnabled(true);
         this.fullscreenOffButton.setEnabled(true);
      }
      
      public function disableExitButton() : void
      {
         this.exitButton.setEnabled(false);
      }
      
      public function enableExitButton() : void
      {
         this.exitButton.setEnabled(true);
      }
      
      private function closeSettings(param1:TimerEvent) : void
      {
         if(getVisible())
         {
            this.animOut();
         }
      }
      
      private function animIn() : void
      {
         setVisible(true);
         this.optionsContainer.mouseEnabled = true;
         this.optionsContainer.mouseChildren = true;
      }
      
      private function animOut() : void
      {
         this.stopAutoCloseTimer();
         setVisible(false);
         this.optionsContainer.mouseEnabled = false;
         this.optionsContainer.mouseChildren = false;
      }
      
      private function fullscreenOn(param1:MouseEvent) : void
      {
         this.resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","FullScreen on");
         DCGame.setFullScreen(true,"noScale");
         this.fullscreenOnButton.setVisible(false);
         this.fullscreenOffButton.setVisible(true);
         param1.stopImmediatePropagation();
      }
      
      private function fullscreenOff(param1:MouseEvent) : void
      {
         this.resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","FullScreen off");
         DCGame.setFullScreen(false,"showAll");
         this.fullscreenOnButton.setVisible(true);
         this.fullscreenOffButton.setVisible(false);
         param1.stopImmediatePropagation();
      }
      
      private function qualityOn(param1:MouseEvent) : void
      {
         this.resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","Quality low");
         DCGame.setQuality("low");
         this.qualityOffButton.setVisible(true);
         this.qualityOnButton.setVisible(false);
         param1.stopImmediatePropagation();
      }
      
      private function qualityOff(param1:MouseEvent) : void
      {
         this.resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","Quality high");
         DCGame.setQuality("high");
         this.qualityOffButton.setVisible(false);
         this.qualityOnButton.setVisible(true);
         param1.stopImmediatePropagation();
      }
      
      private function musicOn(param1:MouseEvent) : void
      {
         this.resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","Music off");
         this.musicOffButton.setVisible(true);
         this.musicOnButton.setVisible(false);
         DCSoundManager.getInstance().setMusicOn(false);
         param1.stopImmediatePropagation();
         SoundManager.saveMusicState();
      }
      
      private function musicOff(param1:MouseEvent) : void
      {
         this.resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","Music on");
         this.musicOffButton.setVisible(false);
         this.musicOnButton.setVisible(true);
         DCSoundManager.getInstance().setMusicOn(true);
         SoundManager.continueMusic();
         param1.stopImmediatePropagation();
         SoundManager.saveMusicState();
      }
      
      private function soundsOn(param1:MouseEvent) : void
      {
         this.resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","SoundFx off");
         this.soundsOffButton.setVisible(true);
         this.soundsOnButton.setVisible(false);
         DCSoundManager.getInstance().setSfxOn(false);
         SoundManager.clearSfxList();
         param1.stopImmediatePropagation();
         SoundManager.saveSfxState();
      }
      
      private function soundsOff(param1:MouseEvent) : void
      {
         this.resetSettingsCloseTimer();
         CRMService.sendEvent("Game","Settings_changed","Clicked","SoundFx on");
         this.soundsOffButton.setVisible(false);
         this.soundsOnButton.setVisible(true);
         DCSoundManager.getInstance().setSfxOn(true);
         param1.stopImmediatePropagation();
         SoundManager.saveSfxState();
      }
      
      private function exitCallback(param1:MouseEvent) : void
      {
         if(!BattleManager.isPracticeMode())
         {
            MessageCenter.sendEvent(new ChatMessage(game.player.id,null,"EXIT_PRESSED_INGAME"));
            MessageCenter.sendEvent(new ChickeningOutMessage(game.player.id,1));
            CRMService.sendEvent("Game","Battle_Ended","Clicked","PressExit");
         }
         if(!PopUpManager.instance)
         {
            PopUpManager.instance = new PopUpManager();
         }
         PopUpManager.instance.addPopup(new ExitQuestionPopUpSubState(game));
         if(!PopUpManager.instance)
         {
            PopUpManager.instance = new PopUpManager();
         }
         PopUpManager.instance.showPopUps(game.battleState);
      }
      
      private function tutorialEnded(param1:Message) : void
      {
         MessageCenter.removeListener("TutorialEnd",this.tutorialEnded);
         this.enableFullScreenButtons();
      }
   }
}

