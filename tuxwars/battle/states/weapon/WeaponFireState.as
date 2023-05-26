package tuxwars.battle.states.weapon
{
   import com.dchoc.game.DCGame;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import tuxwars.battle.weapons.Weapon;
   
   public class WeaponFireState extends WeaponState
   {
       
      
      private var weaponClip:MovieClip;
      
      public function WeaponFireState(weapon:Weapon, game:DCGame, params:* = null)
      {
         super(weapon,game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         weaponClip = weapon.weaponClip;
         if(weaponClip)
         {
            weaponClip.addFrameScript(DCUtils.indexOfLabel(weaponClip,"out"),weaponFired);
            weaponClip.gotoAndPlay("fire");
            if(weapon.allowRotation)
            {
               weaponClip.rotation = weapon.weaponAngle;
            }
         }
      }
      
      override public function exit() : void
      {
         if(weaponClip)
         {
            weaponClip.addFrameScript(DCUtils.indexOfLabel(weaponClip,"out"),null);
            weaponClip.gotoAndStop("out");
            weaponClip = null;
         }
         super.exit();
      }
      
      private function weaponFired() : void
      {
         if(weaponClip)
         {
            weaponClip.addFrameScript(DCUtils.indexOfLabel(weaponClip,"out"),null);
            weaponClip.stop();
         }
      }
   }
}
