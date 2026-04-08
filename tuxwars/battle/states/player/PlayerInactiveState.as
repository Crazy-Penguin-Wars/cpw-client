package tuxwars.battle.states.player
{
   import com.dchoc.messages.*;
   import com.dchoc.states.State;
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.responses.ActionResponse;
   
   public class PlayerInactiveState extends PlayerState
   {
      public function PlayerInactiveState(param1:PlayerGameObject, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         LogUtils.log(player + " Entering PlayerInactiveState",null);
         super.enter();
         player.body.allowRotation = false;
         player.moveControls.hideControls();
         player.moveControls.upKeyDown = false;
         player.moveControls.leftKeyDown = false;
         player.moveControls.rightKeyDown = false;
         MessageCenter.sendMessage("WeaponPutAwayAnimPlayed",{"player":player});
         player.idleMode = true;
      }
      
      override public function changeState(param1:State, param2:Boolean = false) : void
      {
         super.changeState(param1,param2);
         LogUtils.log("Inactive player " + player + " tries to change state to " + param1,"PlayerInactiveState",1,"HandleMessage",true,false,false);
      }
      
      override public function handleMessage(param1:ActionResponse) : void
      {
         super.handleMessage(param1);
         switch(param1.responseType - 3)
         {
            case 0:
            case 2:
               player.moveControls.applyActionResponse(param1);
               break;
            default:
               LogUtils.log("Inactive player " + player + " got message: " + param1.responseType,"PlayerInactiveState",1,"HandleMessage",true,false,false);
         }
      }
      
      override protected function changeToAimState(param1:String) : void
      {
         LogUtils.log("Inactive player " + player + " tries to change to aim state.","PlayerInactiveState",1,"HandleMessage",true,false,false);
      }
      
      override protected function changeToWalkState() : void
      {
         LogUtils.log("Inactive player " + player + " tries to change to walk state.","PlayerInactiveState",1,"HandleMessage",true,false,false);
      }
      
      override protected function changeToFireState() : void
      {
         LogUtils.log("Inactive player " + player + " tries to change to fire state.","PlayerInactiveState",1,"HandleMessage",true,false,false);
      }
   }
}

