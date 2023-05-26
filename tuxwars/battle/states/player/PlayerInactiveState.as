package tuxwars.battle.states.player
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.states.State;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.responses.ActionResponse;
   
   public class PlayerInactiveState extends PlayerState
   {
       
      
      public function PlayerInactiveState(player:PlayerGameObject, params:* = null)
      {
         super(player,params);
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
      
      override public function changeState(state:State, force:Boolean = false) : void
      {
         super.changeState(state,force);
         LogUtils.log("Inactive player " + player + " tries to change state to " + state,"PlayerInactiveState",1,"HandleMessage",true,false,false);
      }
      
      override public function handleMessage(response:ActionResponse) : void
      {
         super.handleMessage(response);
         switch(response.responseType - 3)
         {
            case 0:
            case 2:
               player.moveControls.applyActionResponse(response);
               break;
            default:
               LogUtils.log("Inactive player " + player + " got message: " + response.responseType,"PlayerInactiveState",1,"HandleMessage",true,false,false);
         }
      }
      
      override protected function changeToAimState(weaponName:String) : void
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
