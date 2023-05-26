package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class ChangeSettingsMessage extends SocketMessage
   {
       
      
      public function ChangeSettingsMessage(map:String, matchTime:int, turnTime:int)
      {
         super({
            "t":28,
            "map":map,
            "battle_time":matchTime,
            "turn_time":turnTime
         });
      }
   }
}
