package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.weapons.Weapon;
   
   public class PlayerFiredMessage extends Message
   {
      private var _player:PlayerGameObject;
      
      private var _weapon:Weapon;
      
      public function PlayerFiredMessage(param1:PlayerGameObject, param2:Weapon)
      {
         super("PlayerFired");
         this._player = param1;
         this._weapon = param2;
      }
      
      public function get player() : PlayerGameObject
      {
         return this._player;
      }
      
      public function get weapon() : Weapon
      {
         return this._weapon;
      }
   }
}

