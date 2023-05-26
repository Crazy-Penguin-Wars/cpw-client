package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class EndTurnMessage extends SocketMessage
   {
       
      
      public function EndTurnMessage(id:String)
      {
         super({
            "t":16,
            "id":id
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
