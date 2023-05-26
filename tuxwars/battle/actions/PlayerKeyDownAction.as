package tuxwars.battle.actions
{
   import com.dchoc.input.AbstractKeyboardInputAction;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class PlayerKeyDownAction extends AbstractKeyboardInputAction
   {
       
      
      private var player:PlayerGameObject;
      
      public function PlayerKeyDownAction(player:PlayerGameObject)
      {
         super("keyDown",-1);
         this.player = player;
      }
      
      override public function execute(event:Event) : void
      {
         var _loc2_:* = null;
         if(BattleManager.getTurnTimeLeft() > 0)
         {
            _loc2_ = event as KeyboardEvent;
            switch(_loc2_.keyCode)
            {
               case 37:
               case 65:
                  player.moveControls.leftKeyDown = true;
                  break;
               case 38:
               case 87:
               case 32:
                  player.moveControls.upKeyDown = true;
                  break;
               case 39:
               case 68:
                  player.moveControls.rightKeyDown = true;
            }
         }
      }
   }
}
