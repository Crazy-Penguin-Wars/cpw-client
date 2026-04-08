package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.*;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class StopMessage extends BattleMessage
   {
      public function StopMessage(param1:String)
      {
         super({
            "t":3,
            "id":param1
         });
      }
      
      override public function allowsOtherMessage(param1:SocketMessage) : Boolean
      {
         return param1.messageType != 7;
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

