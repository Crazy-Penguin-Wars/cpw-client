package tuxwars.battle.actions
{
   import com.dchoc.input.AbstractKeyboardInputAction;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class PlayerKeyUpAction extends AbstractKeyboardInputAction
   {
       
      
      private var player:PlayerGameObject;
      
      public function PlayerKeyUpAction(player:PlayerGameObject)
      {
         super("keyUp",-1);
         this.player = player;
      }
      
      override public function execute(event:Event) : void
      {
         var _loc2_:KeyboardEvent = event as KeyboardEvent;
         switch(_loc2_.keyCode)
         {
            case 37:
            case 65:
               player.moveControls.leftKeyDown = false;
               break;
            case 39:
            case 68:
               player.moveControls.rightKeyDown = false;
               break;
            case 38:
            case 87:
            case 32:
               player.moveControls.upKeyDown = false;
         }
      }
   }
}
