package tuxwars.battle.net.responses
{
   public class ActionResponseFactory
   {
      public function ActionResponseFactory()
      {
         super();
         throw new Error("ActionResponseFactory is a static class!");
      }
      
      public static function createActionResponse(param1:Object) : ActionResponse
      {
         switch(param1.t)
         {
            case 7:
               return new MoveResponse(param1);
            case 4:
               return new JumpResponse(param1);
            case 9:
               return new EmitResponse(param1);
            case 6:
               return new ChangeWeaponResponse(param1);
            case 2:
               return new AimResponse(param1);
            case 34:
               return new UseBoosterResponse(param1);
            case 10:
               return new FireWeaponResponse(param1);
            case 12:
               return new AimModeResponse(param1);
            case 35:
               return new DieResponse(param1);
            case 55:
               return new SimpleScriptResponse(param1);
            default:
               return new ActionResponse(param1);
         }
      }
   }
}

