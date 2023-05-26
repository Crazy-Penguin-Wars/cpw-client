package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class StartTurnMessage extends SocketMessage
   {
       
      
      public function StartTurnMessage(id:String)
      {
         super({
            "t":17,
            "id":id
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
