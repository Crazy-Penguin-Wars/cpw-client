package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.weapons.Weapon;
   
   public class ChallengeWeaponUsedMessage extends Message
   {
       
      
      public function ChallengeWeaponUsedMessage(weapon:Weapon)
      {
         super("ChallengeWeaponUsed",weapon);
      }
      
      public function get weapon() : Weapon
      {
         return data;
      }
   }
}
