package tuxwars.battle.net.responses
{
   public class ChangeWeaponResponse extends ActionResponse
   {
      public function ChangeWeaponResponse(param1:Object)
      {
         super(param1);
      }
      
      public function get weaponId() : String
      {
         return data.wid;
      }
   }
}

