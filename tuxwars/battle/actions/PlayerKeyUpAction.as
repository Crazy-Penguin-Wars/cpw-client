package tuxwars.battle.actions
{
   import com.dchoc.input.AbstractKeyboardInputAction;
   import flash.events.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class PlayerKeyUpAction extends AbstractKeyboardInputAction
   {
      private var player:PlayerGameObject;
      
      public function PlayerKeyUpAction(param1:PlayerGameObject)
      {
         super("keyUp",-1);
         this.player = param1;
      }
      
      override public function execute(param1:Event) : void
      {
         var _loc2_:KeyboardEvent = param1 as KeyboardEvent;
         switch(_loc2_.keyCode)
         {
            case 37:
            case 65:
               this.player.moveControls.leftKeyDown = false;
               break;
            case 39:
            case 68:
               this.player.moveControls.rightKeyDown = false;
               break;
            case 38:
            case 87:
            case 32:
               this.player.moveControls.upKeyDown = false;
         }
      }
   }
}

