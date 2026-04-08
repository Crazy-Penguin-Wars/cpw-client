package tuxwars.battle.states
{
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.events.Event;
   import starling.core.*;
   import tuxwars.*;
   import tuxwars.battle.*;
   import tuxwars.battle.actions.*;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.emitters.*;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.battle.ui.*;
   import tuxwars.battle.utils.*;
   import tuxwars.battle.world.*;
   import tuxwars.challenges.*;
   import tuxwars.data.*;
   import tuxwars.net.*;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.*;
   
   public class TuxBattleState extends TuxState
   {
      private static var _performanceTuner:PerformanceTuner;
      
      private static const TIME_OF_SILENCE:int = 1000;
      
      private const _emissioTracker:EmissioTracker = new EmissioTracker();
      
      private const _frameCounter:FpsCounter = new FpsCounter();
      
      private var keyboardHandler:BattleKeyboardHandler;
      
      private var _hud:BattleHud;
      
      private var _initialized:Boolean;
      
      private var _textEffect:TextEffect;
      
      private var startTime:int;
      
      private var locationArrowMessageSent:Boolean = false;
      
      private var messageSent:Boolean;
      
      private var endMusicFlag:Boolean;
      
      private var endTurnFlag:Boolean;
      
      private var sendHelpMoveCheck:Boolean = true;
      
      public function TuxBattleState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
         trace("Ducktape fix: merged TuxBattleIdleSubState into this because i couldn\'t figure out why it was leaving that state when it wasn\'t supposed to lmao");
         var _loc3_:* = param1.world;
         _loc3_._objectContainer.addEventListener("enterFrame",this.frameRendered);
         if(Config.debugMode)
         {
            this.keyboardHandler = new BattleKeyboardHandler(this);
         }
         if(_performanceTuner == null)
         {
            _performanceTuner = new PerformanceTuner(_game);
         }
      }
      
      override public function enter() : void
      {
         super.enter();
         this.startTime = DCGame.getTime();
         if(!ChallengeManager.instance)
         {
            ChallengeManager.instance = new ChallengeManager();
         }
         ChallengeManager.instance.reinit();
         if(!ChallengeManager.instance)
         {
            ChallengeManager.instance = new ChallengeManager();
         }
         if(ChallengeManager.instance.getLocalPlayersChallenges())
         {
            if(!ChallengeManager.instance)
            {
               ChallengeManager.instance = new ChallengeManager();
            }
            ChallengeManager.instance.getLocalPlayersChallenges().reset();
         }
         tuxGame.world.addToStage();
         SoundManager.init();
         this._hud = new BattleHud(tuxGame);
         if(Tutorial._tutorial)
         {
            tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(false);
            tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.setEnabled(false);
            tuxGame.battleState.hud.screen.controlsElement.boosterButton.setEnabled(false);
            tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.setEnabled(false);
            tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.setEnabled(false);
            tuxGame.battleState.hud.screen.controlsElement.emoteButton.setEnabled(false);
         }
         BattleManager.addLoadingIndicator();
         if(Config.debugMode)
         {
            GameWorld.getInputSystem().addInputAction(this.keyboardHandler);
         }
         Emitters.addListeners();
         this._emissioTracker.init();
         MessageCenter.addListener("MatchEnded",this.matchEndCallback);
         tuxGame.tuxWorld.ready();
         this.sendClientReadyMessages();
         var _loc1_:String = tuxGame.tuxWorld.physicsWorld.level.id;
         this._frameCounter.reset();
         this._frameCounter.levelName = _loc1_;
         _performanceTuner.resetFrameRate(_loc1_);
         MessageCenter.addListener("HelpHudStartMoveTimer",this.setHelpMoveStatus);
         MessageCenter.addListener("HelpHudCancelMoveTimer",this.removeHelpMoveStatus);
      }
      
      public function set textEffect(param1:TextEffect) : void
      {
         this._textEffect = param1;
      }
      
      override public function exit() : void
      {
         if(Tutorial._tutorial)
         {
            CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","ResultScreen","Close Result");
            Tutorial.saveTutorialStep("TutorialMatchPlayed");
            tuxGame.player.initChallenges();
         }
         var _loc1_:* = game.world;
         _loc1_._objectContainer.removeEventListener("enterFrame",this.frameRendered);
         MessageCenter.sendEvent(new Message("SendFps",this._frameCounter));
         this._frameCounter.dispose();
         MessageCenter.removeListener("MatchEnded",this.matchEndCallback);
         if(Config.debugMode)
         {
            GameWorld.getInputSystem().removeInputAction(this.keyboardHandler);
         }
         if(!ChallengeManager.instance)
         {
            ChallengeManager.instance = new ChallengeManager();
         }
         ChallengeManager.instance.dispose();
         if(!ChallengeManager.instance)
         {
            ChallengeManager.instance = new ChallengeManager();
         }
         if(ChallengeManager.instance.getLocalPlayersChallenges())
         {
            if(!ChallengeManager.instance)
            {
               ChallengeManager.instance = new ChallengeManager();
            }
            ChallengeManager.instance.getLocalPlayersChallenges().reset();
         }
         tuxGame.world.dispose();
         tuxGame.world = null;
         BattleManager.dispose();
         BattleLoader.dispose();
         SoundManager.dispose();
         if(this._hud)
         {
            this._hud.dispose();
            this._hud = null;
         }
         Emitters.dispose();
         this._emissioTracker.dispose();
         PhysicsUpdater.dispose();
         DynamicBodyManagerPreLoader.dispose();
         tuxGame.disposeStarling();
         MessageCenter.removeListener("HelpHudStartMoveTimer",this.setHelpMoveStatus);
         MessageCenter.removeListener("HelpHudCancelMoveTimer",this.removeHelpMoveStatus);
         super.exit();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         if(!Starling.current.isStarted)
         {
            Starling.current.start();
         }
         super.logicUpdate(param1);
         if(!this.messageSent && this.startTime + 1000 < DCGame.getTime())
         {
            MessageCenter.sendMessage("StartCollisionPlayback");
            this.messageSent = true;
         }
         if(this.locationArrowMessageSent == true && BattleManager.getTurnTimeUsed() < 500)
         {
            this.locationArrowMessageSent = false;
         }
         if(!this.endMusicFlag && BattleManager.getMatchTimeLeft() < 13000 && BattleManager.getMatchTimeLeft() > 12500)
         {
            this.endMusicFlag = true;
            if(Sounds.getSoundReference("BattleMusic"))
            {
               this.sendSoundMessage("StopSound",Sounds.getSoundReference("BattleMusic"),"LoopSound");
            }
            if(Sounds.getSoundReference("GameAlmostOver"))
            {
               this.sendSoundMessage("PlaySound",Sounds.getSoundReference("GameAlmostOver"),"PlaySound");
            }
         }
         if(BattleManager.getTurnTimeLeft() < 7000 && BattleManager.getTurnTimeLeft() > 6800)
         {
            if(Sounds.getSoundReference("TurnEnd"))
            {
               this.sendSoundMessage("PlaySound",Sounds.getSoundReference("TurnEnd"),"PlaySound");
            }
         }
         var _loc2_:PlayerGameObject = BattleManager.getCurrentActivePlayer();
         if(_loc2_)
         {
            if(!this.locationArrowMessageSent && BattleManager.getTurnDuration() - BattleManager.getTurnTimeLeft() > 2000)
            {
               this.locationArrowMessageSent = true;
               MessageCenter.sendMessage("HelpHudEndInfoArrow");
            }
            if(Boolean(this.sendHelpMoveCheck) && BattleManager.getTurnDuration() - BattleManager.getTurnTimeLeft() > 9000)
            {
               this.sendHelpMoveCheck = false;
               MessageCenter.sendMessage("HelpHudStartMove");
            }
            if(!_loc2_.fired && Boolean(BattleManager.isLocalPlayersTurn()))
            {
               _loc2_.infoContainer.playCountDownTimer(BattleManager.getTurnTimeLeft());
            }
         }
         this._frameCounter.logicUpdate(param1);
         if(Boolean(this._textEffect) && Boolean(this._textEffect.isFinished()))
         {
            if(BattleManager.isBattleInProgress())
            {
               changeState(new TuxBattleIdleSubState(tuxGame));
            }
            this._textEffect.dispose();
            this._textEffect = null;
         }
         if(this._hud)
         {
            this._hud.logicUpdate(param1);
         }
      }
      
      public function get hud() : BattleHud
      {
         return this._hud;
      }
      
      public function set hud(param1:BattleHud) : void
      {
         this._hud = param1;
      }
      
      public function get emissionTracker() : EmissioTracker
      {
         return this._emissioTracker;
      }
      
      private function matchEndCallback(param1:MatchEndedMessage) : void
      {
         this._hud.screenHandler.stopUpdate();
      }
      
      private function sendClientReadyMessages() : void
      {
         var _loc1_:* = undefined;
         if(BattleLoader.isPracticeMode())
         {
            for each(_loc1_ in BattleLoader.getPlayers())
            {
               MessageCenter.sendEvent(new ClientReadyMessage(_loc1_.id));
            }
         }
         else
         {
            MessageCenter.sendEvent(new ClientReadyMessage(tuxGame.player.id));
         }
      }
      
      public function frameRendered(param1:Event) : void
      {
         var _loc2_:int = int(this._frameCounter.frameRendered());
         if(_loc2_ >= 0)
         {
            _performanceTuner.setFrameRate(_loc2_);
         }
      }
      
      private function setHelpMoveStatus(param1:Message) : void
      {
         this.sendHelpMoveCheck = true;
      }
      
      private function removeHelpMoveStatus(param1:Message) : void
      {
         this.sendHelpMoveCheck = false;
         MessageCenter.sendMessage("HelpHudEndMove");
      }
      
      public function get fps() : FpsCounter
      {
         return this._frameCounter;
      }
      
      private function sendSoundMessage(param1:String, param2:SoundReference, param3:String) : void
      {
         MessageCenter.sendEvent(new SoundMessage(param1,param2.getMusicID(),param2.getLoop(),param2.getType(),param3));
      }
   }
}

