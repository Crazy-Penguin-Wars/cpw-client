package tuxwars.battle.actions
{
   import com.dchoc.game.DCGame;
   import com.dchoc.input.AbstractKeyboardInputAction;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.MovieMonitor;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import no.olog.Olog;
   import tuxwars.battle.editor.WorldPhysicsValueEditor;
   import tuxwars.battle.states.TuxBattleEditSubState;
   import tuxwars.battle.states.TuxBattleIdleSubState;
   import tuxwars.battle.states.TuxBattleState;
   import tuxwars.data.SoundManager;
   
   public class BattleKeyboardHandler extends AbstractKeyboardInputAction
   {
      private var battleState:TuxBattleState;
      
      private var movieMonitor:MovieMonitor;
      
      public function BattleKeyboardHandler(battleState:TuxBattleState)
      {
         super("keyUp",-1);
         this.battleState = battleState;
      }
      
      override public function execute(event:Event) : void
      {
         LogUtils.log("Action executed.",this,1,"Player",false,false,false);
         var _loc2_:KeyboardEvent = event as KeyboardEvent;
         switch(int(_loc2_.keyCode) - 67)
         {
            case 0:
               if(Config.debugMode && _loc2_.ctrlKey)
               {
                  SoundManager.showChannels();
               }
               break;
            case 1:
               if(Config.debugMode && _loc2_.ctrlKey)
               {
                  battleState.tuxGame.tuxWorld.physicsWorld.toggleDebugMode();
               }
               break;
            case 2:
               if(Config.debugMode)
               {
                  if(!_loc2_.ctrlKey && !_loc2_.shiftKey && !_loc2_.altKey && battleState.state)
                  {
                     battleState.state.changeState(new TuxBattleEditSubState(battleState.tuxGame));
                     WorldPhysicsValueEditor.setBattleState(battleState);
                  }
                  else if(_loc2_.ctrlKey && _loc2_.shiftKey && _loc2_.altKey)
                  {
                     battleState.state.changeState(new TuxBattleIdleSubState(battleState.tuxGame));
                  }
               }
               break;
            case 4:
               if(Config.debugMode && _loc2_.ctrlKey)
               {
                  var _loc3_:* = battleState.tuxGame.tuxWorld;
                  _loc3_._gameObjects.listGameObjects();
               }
               break;
            case 5:
               if(Config.debugMode && _loc2_.ctrlKey)
               {
                  battleState.changeState(new TuxBattleEditSubState(battleState.tuxGame));
                  WorldPhysicsValueEditor.setBattleState(battleState);
               }
            case 9:
               if(Config.debugMode && _loc2_.ctrlKey)
               {
                  MessageCenter.displayListeners();
               }
               break;
            case 10:
               if(Config.debugMode)
               {
                  if(movieMonitor)
                  {
                     movieMonitor.dispose();
                     DCGame.getMainMovieClip().removeChild(movieMonitor);
                     movieMonitor = null;
                  }
                  else
                  {
                     movieMonitor = new MovieMonitor();
                     DCGame.getMainMovieClip().addChild(movieMonitor);
                  }
               }
               break;
            case 16:
               if(Config.debugMode && _loc2_.ctrlKey)
               {
                  Olog.traceDisplayList();
               }
         }
      }
   }
}

