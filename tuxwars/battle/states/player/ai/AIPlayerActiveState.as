package tuxwars.battle.states.player.ai
{
   import com.dchoc.messages.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.net.messages.battle.*;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.states.player.*;
   
   public class AIPlayerActiveState extends PlayerState
   {
      public function AIPlayerActiveState(param1:PlayerGameObject, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         (player as AIPlayerGameObject).target = null;
         var _loc1_:PlayerGameObject = player;
         MessageCenter.sendEvent(new WalkModeMessage(_loc1_._id));
         player.mode = "WalkMode";
      }
      
      override protected function changeToAimState(param1:String) : void
      {
         player.mode = "AimMode";
         changeState(new AIPlayerActiveAimSubState(player,param1));
      }
      
      override protected function changeToFireState() : void
      {
         player.mode = "FireMode";
         changeState(new AIPlayerActiveFireSubState(player));
      }
      
      override protected function changeToWalkState() : void
      {
         player.mode = "WalkMode";
         changeState(new AIPlayerActiveWalkSubState(player));
      }
      
      override public function handleMessage(param1:ActionResponse) : void
      {
         super.handleMessage(param1);
         var _loc2_:PlayerState = state as PlayerState;
         if(_loc2_)
         {
            _loc2_.handleMessage(param1);
         }
      }
   }
}

