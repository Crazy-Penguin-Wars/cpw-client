package tuxwars.battle.states
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.game.GameWorld;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.FpsCounter;
   import com.dchoc.utils.LogUtils;
   import flash.events.Event;
   import starling.core.Starling;
   import tuxwars.BattleLoader;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.EmissioTracker;
   import tuxwars.battle.actions.BattleKeyboardHandler;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.emitters.Emitters;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.net.messages.control.ClientReadyMessage;
   import tuxwars.battle.ui.BattleHud;
   import tuxwars.battle.utils.PerformanceTuner;
   import tuxwars.battle.world.DynamicBodyManagerPreLoader;
   import tuxwars.battle.world.PhysicsUpdater;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.data.SoundManager;
   import tuxwars.net.CRMService;
   import tuxwars.player.Player;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.Tutorial;
   
   public class TuxBattleState extends TuxState
   {
      
      private static var _performanceTuner:PerformanceTuner;
       
      
      private const _emissioTracker:EmissioTracker = new EmissioTracker();
      
      private const _frameCounter:FpsCounter = new FpsCounter();
      
      private var keyboardHandler:BattleKeyboardHandler;
      
      private var _hud:BattleHud;
      
      private var _initialized:Boolean;
      
      private var _textEffect:TextEffect;
      
      public function TuxBattleState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
         var _loc3_:* = game.world;
         _loc3_._objectContainer.addEventListener("enterFrame",frameRendered);
         if(Config.debugMode)
         {
            keyboardHandler = new BattleKeyboardHandler(this);
         }
         if(_performanceTuner == null)
         {
            _performanceTuner = new PerformanceTuner(_game);
         }
      }
      
      override public function enter() : void
      {
         super.enter();
         var _loc2_:ChallengeManager = ChallengeManager;
         if(!tuxwars.challenges.ChallengeManager._instance)
         {
            tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
         }
         tuxwars.challenges.ChallengeManager._instance.reinit();
         var _loc3_:ChallengeManager = ChallengeManager;
         if(!tuxwars.challenges.ChallengeManager._instance)
         {
            tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
         }
         if(tuxwars.challenges.ChallengeManager._instance.getLocalPlayersChallenges())
         {
            var _loc4_:ChallengeManager = ChallengeManager;
            if(!tuxwars.challenges.ChallengeManager._instance)
            {
               tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
            }
            tuxwars.challenges.ChallengeManager._instance.getLocalPlayersChallenges().reset();
         }
         tuxGame.world.addToStage();
         SoundManager.init();
         _hud = new BattleHud(tuxGame);
         var _loc5_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
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
            GameWorld.getInputSystem().addInputAction(keyboardHandler);
         }
         Emitters.addListeners();
         _emissioTracker.init();
         MessageCenter.addListener("MatchEnded",matchEndCallback);
         tuxGame.tuxWorld.ready();
         sendClientReadyMessages();
         var _loc1_:String = tuxGame.tuxWorld.physicsWorld.level.id;
         _frameCounter.reset();
         _frameCounter.levelName = _loc1_;
         _performanceTuner.resetFrameRate(_loc1_);
      }
      
      public function set textEffect(value:TextEffect) : void
      {
         _textEffect = value;
      }
      
      override public function exit() : void
      {
         var _loc1_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","ResultScreen","Close Result");
            Tutorial.saveTutorialStep("TutorialMatchPlayed");
            tuxGame.player.initChallenges();
         }
         var _loc2_:* = game.world;
         _loc2_._objectContainer.removeEventListener("enterFrame",frameRendered);
         MessageCenter.sendEvent(new Message("SendFps",_frameCounter));
         _frameCounter.dispose();
         MessageCenter.removeListener("MatchEnded",matchEndCallback);
         if(Config.debugMode)
         {
            GameWorld.getInputSystem().removeInputAction(keyboardHandler);
         }
         var _loc3_:ChallengeManager = ChallengeManager;
         if(!tuxwars.challenges.ChallengeManager._instance)
         {
            tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
         }
         tuxwars.challenges.ChallengeManager._instance.dispose();
         var _loc4_:ChallengeManager = ChallengeManager;
         if(!tuxwars.challenges.ChallengeManager._instance)
         {
            tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
         }
         if(tuxwars.challenges.ChallengeManager._instance.getLocalPlayersChallenges())
         {
            var _loc5_:ChallengeManager = ChallengeManager;
            if(!tuxwars.challenges.ChallengeManager._instance)
            {
               tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
            }
            tuxwars.challenges.ChallengeManager._instance.getLocalPlayersChallenges().reset();
         }
         tuxGame.world.dispose();
         tuxGame.world = null;
         BattleManager.dispose();
         BattleLoader.dispose();
         SoundManager.dispose();
         if(_hud)
         {
            _hud.dispose();
            _hud = null;
         }
         Emitters.dispose();
         _emissioTracker.dispose();
         PhysicsUpdater.dispose();
         DynamicBodyManagerPreLoader.dispose();
         tuxGame.disposeStarling();
         super.exit();
      }
      
      override public function logicUpdate(time:int) : void
      {
         if(!Starling.current.isStarted)
         {
            Starling.current.start();
         }
         try
         {
            super.logicUpdate(time);
            _frameCounter.logicUpdate(time);
            if(_textEffect && _textEffect.isFinished())
            {
               if(BattleManager.isBattleInProgress())
               {
                  changeState(new TuxBattleIdleSubState(tuxGame));
               }
               _textEffect.dispose();
               _textEffect = null;
            }
            if(_hud)
            {
               _hud.logicUpdate(time);
            }
         }
         catch(e:Error)
         {
            LogUtils.log(e.getStackTrace(),this,3,"ErrorLogging",false);
            MessageCenter.sendEvent(new ErrorMessage("Battle Exception","logicUpdate",e.message.toString(),null,e));
         }
      }
      
      public function get hud() : BattleHud
      {
         return _hud;
      }
      
      public function set hud(value:BattleHud) : void
      {
         _hud = value;
      }
      
      public function get emissionTracker() : EmissioTracker
      {
         return _emissioTracker;
      }
      
      private function matchEndCallback(msg:MatchEndedMessage) : void
      {
         _hud.screenHandler.stopUpdate();
      }
      
      private function sendClientReadyMessages() : void
      {
         if(BattleLoader.isPracticeMode())
         {
            for each(var player in BattleLoader.getPlayers())
            {
               MessageCenter.sendEvent(new ClientReadyMessage(player.id));
            }
         }
         else
         {
            MessageCenter.sendEvent(new ClientReadyMessage(tuxGame.player.id));
         }
      }
      
      public function frameRendered(e:Event) : void
      {
         var _loc2_:int = _frameCounter.frameRendered();
         if(_loc2_ >= 0)
         {
            _performanceTuner.setFrameRate(_loc2_);
         }
      }
      
      public function get fps() : FpsCounter
      {
         return _frameCounter;
      }
   }
}
