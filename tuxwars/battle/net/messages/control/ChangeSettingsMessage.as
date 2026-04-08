package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class ChangeSettingsMessage extends SocketMessage
   {
      public function ChangeSettingsMessage(param1:String, param2:int, param3:int)
      {
         super({
            "t":28,
            "map":param1,
            "battle_time":param2,
            "turn_time":param3
         });
      }
   }
}

