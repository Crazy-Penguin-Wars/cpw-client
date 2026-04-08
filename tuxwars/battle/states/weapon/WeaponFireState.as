package tuxwars.battle.states.weapon
{
   import com.dchoc.game.DCGame;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import tuxwars.battle.weapons.Weapon;
   
   public class WeaponFireState extends WeaponState
   {
      private var weaponClip:MovieClip;
      
      public function WeaponFireState(param1:Weapon, param2:DCGame, param3:* = null)
      {
         super(param1,param2,param3);
      }
      
      override public function enter() : void
      {
         super.enter();
         this.weaponClip = weapon.weaponClip;
         if(this.weaponClip)
         {
            this.weaponClip.addFrameScript(DCUtils.indexOfLabel(this.weaponClip,"out"),this.weaponFired);
            this.weaponClip.gotoAndPlay("fire");
            if(weapon.allowRotation)
            {
               this.weaponClip.rotation = weapon.weaponAngle;
            }
         }
      }
      
      override public function exit() : void
      {
         if(this.weaponClip)
         {
            this.weaponClip.addFrameScript(DCUtils.indexOfLabel(this.weaponClip,"out"),null);
            this.weaponClip.gotoAndStop("out");
            this.weaponClip = null;
         }
         super.exit();
      }
      
      private function weaponFired() : void
      {
         if(this.weaponClip)
         {
            this.weaponClip.addFrameScript(DCUtils.indexOfLabel(this.weaponClip,"out"),null);
            this.weaponClip.stop();
         }
      }
   }
}

