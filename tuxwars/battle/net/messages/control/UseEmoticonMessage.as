package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class UseEmoticonMessage extends SocketMessage
   {
       
      
      public function UseEmoticonMessage(playerId:String, emoticonId:String)
      {
         super({
            "t":13,
            "id":playerId,
            "emoticon_id":emoticonId
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
