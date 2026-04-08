package tuxwars.battle.states.weapon
{
   import com.dchoc.game.DCGame;
   import tuxwars.battle.weapons.Weapon;
   
   public class WeaponAimState extends WeaponState
   {
      public function WeaponAimState(param1:Weapon, param2:DCGame, param3:* = null)
      {
         super(param1,param2,param3);
      }
      
      override public function enter() : void
      {
         super.enter();
         weapon.weaponClip.gotoAndStop("aim");
      }
   }
}

