package tuxwars.battle.states.player
{
   import com.dchoc.gameobjects.states.GameObjectState;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.net.responses.AimModeResponse;
   
   public class PlayerState extends GameObjectState
   {
       
      
      public function PlayerState(player:PlayerGameObject, params:* = null)
      {
         super(player,params);
      }
      
      public function physicsUpdate(deltaTime:int) : void
      {
         var _loc2_:PlayerState = state as PlayerState;
         if(_loc2_)
         {
            _loc2_.physicsUpdate(deltaTime);
         }
      }
      
      public function get player() : PlayerGameObject
      {
         return getGameObject() as PlayerGameObject;
      }
      
      public function handleMessage(response:ActionResponse) : void
      {
         switch(response.responseType - 8)
         {
            case 0:
               changeToWalkState();
               break;
            case 3:
               changeToFireState();
               break;
            case 4:
               changeToAimState(AimModeResponse(response).weaponId);
         }
      }
      
      protected function changeToAimState(weaponName:String) : void
      {
      }
      
      protected function changeToFireState() : void
      {
      }
      
      protected function changeToWalkState() : void
      {
      }
   }
}
