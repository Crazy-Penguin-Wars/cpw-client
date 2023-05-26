package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class EnableBoostersMessage extends SocketMessage
   {
       
      
      public function EnableBoostersMessage(playerId:String)
      {
         super({
            "t":37,
            "id":playerId
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
