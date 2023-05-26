package tuxwars.battle.states.weapon
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.MessageCenter;
   import flash.display.MovieClip;
   import tuxwars.battle.weapons.Weapon;
   
   public class WeaponPutAwayState extends WeaponState
   {
       
      
      private var weaponClip:MovieClip;
      
      private var newWeapon:String;
      
      public function WeaponPutAwayState(weapon:Weapon, game:DCGame, params:* = null)
      {
         super(weapon,game,params);
         newWeapon = params;
      }
      
      override public function enter() : void
      {
         super.enter();
         weapon.location = null;
         weaponClip = weapon.weaponClip;
         if(weaponClip)
         {
            weaponClip.addFrameScript(weaponClip.totalFrames - 1,weaponPutAway);
            weaponClip.gotoAndPlay("out");
         }
         else
         {
            weaponPutAway();
         }
      }
      
      override public function exit() : void
      {
         weaponPutAway();
         super.exit();
      }
      
      private function weaponPutAway() : void
      {
         if(weaponClip)
         {
            weaponClip.addFrameScript(weaponClip.totalFrames - 1,null);
            weaponClip.stop();
            weaponClip = null;
         }
         MessageCenter.sendMessage("WeaponPutAwayAnimPlayed",{
            "player":weapon.player,
            "weapon":newWeapon
         });
      }
   }
}
