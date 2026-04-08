package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.*;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class UseEmoticonMessage extends SocketMessage
   {
      public function UseEmoticonMessage(param1:String, param2:String)
      {
         super({
            "t":13,
            "id":param1,
            "emoticon_id":param2
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

