package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.weapons.Weapon;
   
   public class ChallengeWeaponUsedMessage extends Message
   {
      public function ChallengeWeaponUsedMessage(param1:Weapon)
      {
         super("ChallengeWeaponUsed",param1);
      }
      
      public function get weapon() : Weapon
      {
         return data;
      }
   }
}

