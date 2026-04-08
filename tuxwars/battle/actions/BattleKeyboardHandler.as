package tuxwars.battle.actions
{
   import com.dchoc.game.*;
   import com.dchoc.input.AbstractKeyboardInputAction;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.events.*;
   import no.olog.*;
   import tuxwars.battle.editor.*;
   import tuxwars.battle.states.*;
   import tuxwars.data.*;
   
   public class BattleKeyboardHandler extends AbstractKeyboardInputAction
   {
      private var battleState:TuxBattleState;
      
      private var movieMonitor:MovieMonitor;
      
      public function BattleKeyboardHandler(param1:TuxBattleState)
      {
         super("keyUp",-1);
         this.battleState = param1;
      }
      
      override public function execute(param1:Event) : void
      {
         var _loc3_:* = undefined;
         LogUtils.log("Action executed.",this,1,"Player",false,false,false);
         var _loc2_:KeyboardEvent = param1 as KeyboardEvent;
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
                  this.battleState.tuxGame.tuxWorld.physicsWorld.toggleDebugMode();
               }
               break;
            case 2:
               if(Config.debugMode)
               {
                  if(!_loc2_.ctrlKey && !_loc2_.shiftKey && !_loc2_.altKey && Boolean(this.battleState.state))
                  {
                     this.battleState.state.changeState(new TuxBattleEditSubState(this.battleState.tuxGame));
                     WorldPhysicsValueEditor.setBattleState(this.battleState);
                  }
                  else if(_loc2_.ctrlKey && _loc2_.shiftKey && _loc2_.altKey)
                  {
                     this.battleState.state.changeState(new TuxBattleIdleSubState(this.battleState.tuxGame));
                  }
               }
               break;
            case 4:
               if(Config.debugMode && _loc2_.ctrlKey)
               {
                  _loc3_ = this.battleState.tuxGame.tuxWorld;
                  _loc3_._gameObjects.listGameObjects();
               }
               break;
            case 5:
               if(Config.debugMode && _loc2_.ctrlKey)
               {
                  this.battleState.changeState(new TuxBattleEditSubState(this.battleState.tuxGame));
                  WorldPhysicsValueEditor.setBattleState(this.battleState);
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
                  if(this.movieMonitor)
                  {
                     this.movieMonitor.dispose();
                     DCGame.getMainMovieClip().removeChild(this.movieMonitor);
                     this.movieMonitor = null;
                  }
                  else
                  {
                     this.movieMonitor = new MovieMonitor();
                     DCGame.getMainMovieClip().addChild(this.movieMonitor);
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

