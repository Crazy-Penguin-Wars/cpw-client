package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class StopMessage extends BattleMessage
   {
       
      
      public function StopMessage(id:String)
      {
         super({
            "t":3,
            "id":id
         });
      }
      
      override public function allowsOtherMessage(other:SocketMessage) : Boolean
      {
         return other.messageType != 7;
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
