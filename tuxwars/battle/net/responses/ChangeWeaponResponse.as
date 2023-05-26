package tuxwars.battle.net.responses
{
   public class ChangeWeaponResponse extends ActionResponse
   {
       
      
      public function ChangeWeaponResponse(data:Object)
      {
         super(data);
      }
      
      public function get weaponId() : String
      {
         return data.wid;
      }
   }
}
