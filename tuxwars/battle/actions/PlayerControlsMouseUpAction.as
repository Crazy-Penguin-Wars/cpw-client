package tuxwars.battle.actions
{
   import flash.events.Event;
   import tuxwars.battle.input.PlayerMoveControls;
   
   public class PlayerControlsMouseUpAction extends PlayerControlsAction
   {
       
      
      public function PlayerControlsMouseUpAction(moveControls:PlayerMoveControls)
      {
         super("mouseUp",moveControls);
      }
      
      override public function execute(event:Event) : void
      {
         moveControls.mouseDown = false;
      }
   }
}
