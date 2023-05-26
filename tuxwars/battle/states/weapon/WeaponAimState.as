package tuxwars.battle.states.weapon
{
   import com.dchoc.game.DCGame;
   import tuxwars.battle.weapons.Weapon;
   
   public class WeaponAimState extends WeaponState
   {
       
      
      public function WeaponAimState(weapon:Weapon, game:DCGame, params:* = null)
      {
         super(weapon,game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         weapon.weaponClip.gotoAndStop("aim");
      }
   }
}
