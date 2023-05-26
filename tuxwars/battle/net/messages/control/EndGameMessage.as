package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class EndGameMessage extends SocketMessage
   {
       
      
      public function EndGameMessage()
      {
         super({"t":19});
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
