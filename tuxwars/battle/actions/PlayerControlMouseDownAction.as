package tuxwars.battle.actions
{
   import flash.events.Event;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.input.PlayerMoveControls;
   
   public class PlayerControlMouseDownAction extends PlayerControlsAction
   {
       
      
      public function PlayerControlMouseDownAction(moveControls:PlayerMoveControls)
      {
         super("mouseDown",moveControls);
      }
      
      override public function execute(event:Event) : void
      {
         if(BattleManager.getTurnTimeLeft() > 0)
         {
            moveControls.mouseDown = true;
         }
      }
   }
}
