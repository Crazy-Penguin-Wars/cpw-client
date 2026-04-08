package tuxwars.battle.actions
{
   import com.dchoc.input.AbstractKeyboardInputAction;
   import flash.events.*;
   import tuxwars.battle.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class PlayerKeyDownAction extends AbstractKeyboardInputAction
   {
      private var player:PlayerGameObject;
      
      public function PlayerKeyDownAction(param1:PlayerGameObject)
      {
         super("keyDown",-1);
         this.player = param1;
      }
      
      override public function execute(param1:Event) : void
      {
         var _loc2_:KeyboardEvent = null;
         if(BattleManager.getTurnTimeLeft() > 0)
         {
            _loc2_ = param1 as KeyboardEvent;
            switch(_loc2_.keyCode)
            {
               case 37:
               case 65:
                  this.player.moveControls.leftKeyDown = true;
                  break;
               case 38:
               case 87:
               case 32:
                  this.player.moveControls.upKeyDown = true;
                  break;
               case 39:
               case 68:
                  this.player.moveControls.rightKeyDown = true;
            }
         }
      }
   }
}

