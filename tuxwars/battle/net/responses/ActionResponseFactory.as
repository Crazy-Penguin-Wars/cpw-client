package tuxwars.battle.net.responses
{
   public class ActionResponseFactory
   {
       
      
      public function ActionResponseFactory()
      {
         super();
         throw new Error("ActionResponseFactory is a static class!");
      }
      
      public static function createActionResponse(data:Object) : ActionResponse
      {
         switch(data.t)
         {
            case 7:
               return new MoveResponse(data);
            case 4:
               return new JumpResponse(data);
            case 9:
               return new EmitResponse(data);
            case 6:
               return new ChangeWeaponResponse(data);
            case 2:
               return new AimResponse(data);
            case 34:
               return new UseBoosterResponse(data);
            case 10:
               return new FireWeaponResponse(data);
            case 12:
               return new AimModeResponse(data);
            case 35:
               return new DieResponse(data);
            case 55:
               return new SimpleScriptResponse(data);
            default:
               return new ActionResponse(data);
         }
      }
   }
}
