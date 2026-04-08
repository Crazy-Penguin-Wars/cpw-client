package tuxwars.battle.states.weapon
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.weapons.Weapon;
   import tuxwars.data.*;
   
   public class WeaponDrawState extends WeaponState
   {
      private var weaponClip:MovieClip;
      
      public function WeaponDrawState(param1:Weapon, param2:DCGame, param3:* = null)
      {
         super(param1,param2,param3);
      }
      
      override public function enter() : void
      {
         super.enter();
         var _loc1_:SoundReference = Sounds.getSoundReference("Draw" + weapon.id);
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
         }
         this.weaponClip = weapon.weaponClip;
         this.weaponClip.addFrameScript(DCUtils.indexOfLabel(this.weaponClip,"aim") - 1,this.weaponDrawn);
         this.weaponClip.gotoAndPlay("draw");
         var _loc2_:TextEffect = tuxGame.tuxWorld.addTextEffect(2,weapon.name,weapon.player.container.x,weapon.player.container.y,false);
         tuxGame.tuxWorld.ignoreLevelSizeScale(_loc2_.movieClip,true,false);
      }
      
      override public function exit() : void
      {
         this.clearClip();
         super.exit();
      }
      
      private function weaponDrawn() : void
      {
         this.clearClip();
         if(weapon)
         {
            weapon.changeState(new WeaponAimState(weapon,tuxGame));
         }
      }
      
      private function clearClip() : void
      {
         if(this.weaponClip)
         {
            this.weaponClip.addFrameScript(DCUtils.indexOfLabel(this.weaponClip,"aim") - 1,null);
            this.weaponClip = null;
         }
      }
   }
}

