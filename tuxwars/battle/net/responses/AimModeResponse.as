package tuxwars.battle.net.responses
{
   public class AimModeResponse extends ActionResponse
   {
       
      
      public function AimModeResponse(data:Object)
      {
         super(data);
      }
      
      public function get weaponId() : String
      {
         return data.wid;
      }
   }
}
