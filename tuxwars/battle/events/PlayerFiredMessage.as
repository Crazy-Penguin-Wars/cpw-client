package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.weapons.Weapon;
   
   public class PlayerFiredMessage extends Message
   {
       
      
      private var _player:PlayerGameObject;
      
      private var _weapon:Weapon;
      
      public function PlayerFiredMessage(player:PlayerGameObject, weapon:Weapon)
      {
         super("PlayerFired");
         _player = player;
         _weapon = weapon;
      }
      
      public function get player() : PlayerGameObject
      {
         return _player;
      }
      
      public function get weapon() : Weapon
      {
         return _weapon;
      }
   }
}
