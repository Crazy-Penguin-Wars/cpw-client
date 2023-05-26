package tuxwars.battle.states.player.ai
{
   import com.dchoc.messages.MessageCenter;
   import tuxwars.battle.gameobjects.player.AIPlayerGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.WalkModeMessage;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.states.player.PlayerState;
   
   public class AIPlayerActiveState extends PlayerState
   {
       
      
      public function AIPlayerActiveState(player:PlayerGameObject, params:* = null)
      {
         super(player,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         (player as AIPlayerGameObject).target = null;
         var _loc1_:PlayerGameObject = player;
         MessageCenter.sendEvent(new WalkModeMessage(_loc1_._id));
         player.mode = "WalkMode";
      }
      
      override protected function changeToAimState(weaponName:String) : void
      {
         player.mode = "AimMode";
         changeState(new AIPlayerActiveAimSubState(player,weaponName));
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
      
      override public function handleMessage(response:ActionResponse) : void
      {
         super.handleMessage(response);
         var _loc2_:PlayerState = state as PlayerState;
         if(_loc2_)
         {
            _loc2_.handleMessage(response);
         }
      }
   }
}
