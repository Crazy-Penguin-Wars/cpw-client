package tuxwars.battle.actions
{
   import com.dchoc.input.AbstractKeyboardInputAction;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import no.olog.Olog;
   import tuxwars.battle.editor.WorldPhysicsValueEditor;
   import tuxwars.battle.states.TuxBattleEditSubState;
   
   public class EditKeyboardHandler extends AbstractKeyboardInputAction
   {
       
      
      private var editState:TuxBattleEditSubState;
      
      public function EditKeyboardHandler(battleState:TuxBattleEditSubState)
      {
         super("keyUp",-1);
         editState = battleState;
      }
      
      override public function execute(event:Event) : void
      {
         var _loc2_:KeyboardEvent = event as KeyboardEvent;
         switch(_loc2_.keyCode)
         {
            case 69:
               if(WorldPhysicsValueEditor.isShown())
               {
                  WorldPhysicsValueEditor.showWorldPhysicsEditScreen();
               }
               editState.parent.exitCurrentState();
               break;
            case 50:
               Olog.traceDisplayList();
         }
      }
   }
}
