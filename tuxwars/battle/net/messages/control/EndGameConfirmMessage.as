package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class EndGameConfirmMessage extends SocketMessage
   {
       
      
      public function EndGameConfirmMessage()
      {
         super({"t":20});
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
