package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.*;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class EndTurnMessage extends SocketMessage
   {
      public function EndTurnMessage(param1:String)
      {
         super({
            "t":16,
            "id":param1
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

