package tuxwars.battle.states.player
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.responses.ActionResponse;
   
   public class PlayerActiveWalkSubState extends PlayerState
   {
       
      
      public function PlayerActiveWalkSubState(player:PlayerGameObject, params:* = null)
      {
         super(player,params);
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
            MessageCenter.addListener("WeaponPutAwayAnimPlayed",weaponPutAway);
         }
         else
         {
            init();
         }
      }
      
      override public function exit() : void
      {
         MessageCenter.removeListener("WeaponPutAwayAnimPlayed",weaponPutAway);
         player.moveControls.hideControls();
         super.exit();
      }
      
      override public function handleMessage(response:ActionResponse) : void
      {
         super.handleMessage(response);
         LogUtils.addDebugLine("HandleMessage","Handling response: " + response.responseType,"PlayerActiveWalkSubState");
         switch(response.responseType - 3)
         {
            case 0:
            case 1:
            case 2:
            case 4:
               player.moveControls.applyActionResponse(response);
         }
      }
      
      override public function logicUpdate(time:int) : void
      {
         super.logicUpdate(time);
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
      
      private function weaponPutAway(msg:Message) : void
      {
         var _loc2_:PlayerGameObject = msg.data.player;
         if(_loc2_ == _loc2_)
         {
            init();
         }
      }
      
      private function init() : void
      {
         player.moveControls.showControls();
      }
   }
}
