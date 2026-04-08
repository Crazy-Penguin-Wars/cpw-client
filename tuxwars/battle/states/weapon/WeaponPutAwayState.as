package tuxwars.battle.states.weapon
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.*;
   import flash.display.MovieClip;
   import tuxwars.battle.weapons.Weapon;
   
   public class WeaponPutAwayState extends WeaponState
   {
      private var weaponClip:MovieClip;
      
      private var newWeapon:String;
      
      public function WeaponPutAwayState(param1:Weapon, param2:DCGame, param3:* = null)
      {
         super(param1,param2,param3);
         this.newWeapon = param3;
      }
      
      override public function enter() : void
      {
         super.enter();
         weapon.location = null;
         this.weaponClip = weapon.weaponClip;
         if(this.weaponClip)
         {
            this.weaponClip.addFrameScript(this.weaponClip.totalFrames - 1,this.weaponPutAway);
            this.weaponClip.gotoAndPlay("out");
         }
         else
         {
            this.weaponPutAway();
         }
      }
      
      override public function exit() : void
      {
         this.weaponPutAway();
         super.exit();
      }
      
      private function weaponPutAway() : void
      {
         if(this.weaponClip)
         {
            this.weaponClip.addFrameScript(this.weaponClip.totalFrames - 1,null);
            this.weaponClip.stop();
            this.weaponClip = null;
         }
         MessageCenter.sendMessage("WeaponPutAwayAnimPlayed",{
            "player":weapon.player,
            "weapon":this.newWeapon
         });
      }
   }
}

