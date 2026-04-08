package tuxwars.battle.states.player
{
   import com.dchoc.gameobjects.states.GameObjectState;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.net.responses.*;
   
   public class PlayerState extends GameObjectState
   {
      public function PlayerState(param1:PlayerGameObject, param2:* = null)
      {
         super(param1,param2);
      }
      
      public function physicsUpdate(param1:int) : void
      {
         var _loc2_:PlayerState = state as PlayerState;
         if(_loc2_)
         {
            _loc2_.physicsUpdate(param1);
         }
      }
      
      public function get player() : PlayerGameObject
      {
         return getGameObject() as PlayerGameObject;
      }
      
      public function handleMessage(param1:ActionResponse) : void
      {
         switch(param1.responseType - 8)
         {
            case 0:
               this.changeToWalkState();
               break;
            case 3:
               this.changeToFireState();
               break;
            case 4:
               this.changeToAimState(AimModeResponse(param1).weaponId);
         }
      }
      
      protected function changeToAimState(param1:String) : void
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

