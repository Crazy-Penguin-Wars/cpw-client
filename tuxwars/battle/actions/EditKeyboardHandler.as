package tuxwars.battle.actions
{
   import com.dchoc.input.AbstractKeyboardInputAction;
   import flash.events.*;
   import no.olog.*;
   import tuxwars.battle.editor.*;
   import tuxwars.battle.states.TuxBattleEditSubState;
   
   public class EditKeyboardHandler extends AbstractKeyboardInputAction
   {
      private var editState:TuxBattleEditSubState;
      
      public function EditKeyboardHandler(param1:TuxBattleEditSubState)
      {
         super("keyUp",-1);
         this.editState = param1;
      }
      
      override public function execute(param1:Event) : void
      {
         var _loc2_:KeyboardEvent = param1 as KeyboardEvent;
         switch(_loc2_.keyCode)
         {
            case 69:
               if(WorldPhysicsValueEditor.isShown())
               {
                  WorldPhysicsValueEditor.showWorldPhysicsEditScreen();
               }
               this.editState.parent.exitCurrentState();
               break;
            case 50:
               Olog.traceDisplayList();
         }
      }
   }
}

