package tuxwars.battle.net.responses
{
   public class AimModeResponse extends ActionResponse
   {
      public function AimModeResponse(param1:Object)
      {
         super(param1);
      }
      
      public function get weaponId() : String
      {
         return data.wid;
      }
   }
}

