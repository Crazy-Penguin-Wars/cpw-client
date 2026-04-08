package tuxwars.items
{
   import com.dchoc.avatar.WearableItem;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.weapons.*;
   import tuxwars.items.definitions.*;
   
   public class WeaponItem extends Item
   {
      private var weaponDef:WeaponDef;
      
      public function WeaponItem()
      {
         super();
      }
      
      override public function load(param1:EquippableDef) : void
      {
         super.load(param1);
         assert("data is not WeaponDef",true,param1 is WeaponDef);
         this.weaponDef = param1 as WeaponDef;
      }
      
      override public function getAsWearableItem() : WearableItem
      {
         return new Weapon(this.weaponDef);
      }
   }
}

