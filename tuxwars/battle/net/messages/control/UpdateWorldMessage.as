package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.*;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class UpdateWorldMessage extends SocketMessage
   {
      public function UpdateWorldMessage(param1:int, param2:int = -2147483648, param3:Array = null, param4:Array = null, param5:String = null)
      {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc6_:Object = {
            "t":1,
            "ttl":param1
         };
         if(param2 != -2147483648)
         {
            _loc6_["mtl"] = param2;
         }
         if(Boolean(param3) && param3.length > 0)
         {
            _loc6_["respawn"] = [];
            for each(_loc7_ in param3)
            {
               _loc6_["respawn"].push(_loc7_);
            }
         }
         if(Boolean(param4) && param4.length > 0)
         {
            _loc6_["resume"] = [];
            for each(_loc8_ in param4)
            {
               _loc6_["resume"].push(_loc8_);
            }
         }
         if(param5 != null)
         {
            _loc6_["powerup"] = param5;
         }
         super(_loc6_);
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

