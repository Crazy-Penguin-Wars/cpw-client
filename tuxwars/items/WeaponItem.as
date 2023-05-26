package tuxwars.items
{
   import com.dchoc.avatar.WearableItem;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.weapons.Weapon;
   import tuxwars.items.definitions.EquippableDef;
   import tuxwars.items.definitions.WeaponDef;
   
   public class WeaponItem extends Item
   {
       
      
      private var weaponDef:WeaponDef;
      
      public function WeaponItem()
      {
         super();
      }
      
      override public function load(data:EquippableDef) : void
      {
         super.load(data);
         assert("data is not WeaponDef",true,data is WeaponDef);
         weaponDef = data as WeaponDef;
      }
      
      override public function getAsWearableItem() : WearableItem
      {
         return new Weapon(weaponDef);
      }
   }
}
