package tuxwars.battle.states.weapon
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.weapons.Weapon;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   
   public class WeaponDrawState extends WeaponState
   {
       
      
      private var weaponClip:MovieClip;
      
      public function WeaponDrawState(weapon:Weapon, game:DCGame, params:* = null)
      {
         super(weapon,game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         var _loc1_:SoundReference = Sounds.getSoundReference("Draw" + weapon.id);
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
         }
         weaponClip = weapon.weaponClip;
         weaponClip.addFrameScript(DCUtils.indexOfLabel(weaponClip,"aim") - 1,weaponDrawn);
         weaponClip.gotoAndPlay("draw");
         var _loc2_:TextEffect = tuxGame.tuxWorld.addTextEffect(2,weapon.name,weapon.player.container.x,weapon.player.container.y,false);
         tuxGame.tuxWorld.ignoreLevelSizeScale(_loc2_.movieClip,true,false);
      }
      
      override public function exit() : void
      {
         clearClip();
         super.exit();
      }
      
      private function weaponDrawn() : void
      {
         clearClip();
         if(weapon)
         {
            weapon.changeState(new WeaponAimState(weapon,tuxGame));
         }
      }
      
      private function clearClip() : void
      {
         if(weaponClip)
         {
            weaponClip.addFrameScript(DCUtils.indexOfLabel(weaponClip,"aim") - 1,null);
            weaponClip = null;
         }
      }
   }
}
