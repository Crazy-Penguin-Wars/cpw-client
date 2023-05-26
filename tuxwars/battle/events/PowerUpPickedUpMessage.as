package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.PowerUpGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class PowerUpPickedUpMessage extends Message
   {
       
      
      private var _player:PlayerGameObject;
      
      private var _powerUp:PowerUpGameObject;
      
      public function PowerUpPickedUpMessage(player:PlayerGameObject, powerUp:PowerUpGameObject)
      {
         super("PowerUpPickedUp");
         _player = player;
         _powerUp = powerUp;
      }
      
      public function get player() : PlayerGameObject
      {
         return _player;
      }
      
      public function get powerUp() : PowerUpGameObject
      {
         return _powerUp;
      }
   }
}
