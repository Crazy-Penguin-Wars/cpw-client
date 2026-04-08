package tuxwars.battle.actions
{
   import flash.events.Event;
   import tuxwars.battle.*;
   import tuxwars.battle.input.PlayerMoveControls;
   
   public class PlayerControlMouseDownAction extends PlayerControlsAction
   {
      public function PlayerControlMouseDownAction(param1:PlayerMoveControls)
      {
         super("mouseDown",param1);
      }
      
      override public function execute(param1:Event) : void
      {
         if(BattleManager.getTurnTimeLeft() > 0)
         {
            moveControls.mouseDown = true;
         }
      }
   }
}

