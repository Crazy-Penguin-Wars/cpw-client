package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.*;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class StartTurnMessage extends SocketMessage
   {
      public function StartTurnMessage(param1:String)
      {
         super({
            "t":17,
            "id":param1
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

