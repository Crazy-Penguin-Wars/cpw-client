package tuxwars.battle.states.player
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import tuxwars.battle.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.responses.ActionResponse;
   
   public class PlayerActiveWalkSubState extends PlayerState
   {
      public function PlayerActiveWalkSubState(param1:PlayerGameObject, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         LogUtils.log(player + " Entering PlayerActiveWalkSubState",null);
         super.enter();
         if(player.mode != "WalkMode")
         {
            player.mode = "WalkMode";
         }
         if(player.weapon)
         {
            player.changeWeapon(null);
            MessageCenter.addListener("WeaponPutAwayAnimPlayed",this.weaponPutAway);
         }
         else
         {
            this.init();
         }
      }
      
      override public function exit() : void
      {
         MessageCenter.removeListener("WeaponPutAwayAnimPlayed",this.weaponPutAway);
         player.moveControls.hideControls();
         super.exit();
      }
      
      override public function handleMessage(param1:ActionResponse) : void
      {
         super.handleMessage(param1);
         LogUtils.addDebugLine("HandleMessage","Handling response: " + param1.responseType,"PlayerActiveWalkSubState");
         switch(param1.responseType - 3)
         {
            case 0:
            case 1:
            case 2:
            case 4:
               player.moveControls.applyActionResponse(param1);
         }
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(BattleManager.isLocalPlayersTurn())
         {
            if(player.moveControls.leftKeyDown || player.moveControls.rightKeyDown)
            {
               if(player.moveControls.leftKeyDown)
               {
                  player.direction = 0;
               }
               if(player.moveControls.rightKeyDown)
               {
                  player.direction = 1;
               }
            }
            else if(player.container.mouseX < 0)
            {
               player.direction = 0;
            }
            else if(player.container.mouseX >= 0)
            {
               player.direction = 1;
            }
         }
      }
      
      private function weaponPutAway(param1:Message) : void
      {
         var _loc2_:PlayerGameObject = param1.data.player;
         if(_loc2_ == _loc2_)
         {
            this.init();
         }
      }
      
      private function init() : void
      {
         player.moveControls.showControls();
      }
   }
}

