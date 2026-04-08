package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.PowerUpGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class PowerUpPickedUpMessage extends Message
   {
      private var _player:PlayerGameObject;
      
      private var _powerUp:PowerUpGameObject;
      
      public function PowerUpPickedUpMessage(param1:PlayerGameObject, param2:PowerUpGameObject)
      {
         super("PowerUpPickedUp");
         this._player = param1;
         this._powerUp = param2;
      }
      
      public function get player() : PlayerGameObject
      {
         return this._player;
      }
      
      public function get powerUp() : PowerUpGameObject
      {
         return this._powerUp;
      }
   }
}

