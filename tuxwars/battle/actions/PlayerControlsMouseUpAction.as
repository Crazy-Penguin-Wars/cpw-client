package tuxwars.battle.actions
{
   import flash.events.Event;
   import tuxwars.battle.input.PlayerMoveControls;
   
   public class PlayerControlsMouseUpAction extends PlayerControlsAction
   {
      public function PlayerControlsMouseUpAction(param1:PlayerMoveControls)
      {
         super("mouseUp",param1);
      }
      
      override public function execute(param1:Event) : void
      {
         moveControls.mouseDown = false;
      }
   }
}

