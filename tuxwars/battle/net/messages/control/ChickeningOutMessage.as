package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class ChickeningOutMessage extends SocketMessage
   {
      
      public static const STATUS_CANCEL:int = 0;
      
      public static const STATUS_CHICKENING_OUT:int = 1;
      
      public static const STATUS_CHICKENED_OUT:int = 2;
       
      
      public function ChickeningOutMessage(playerId:String, status:int)
      {
         super({
            "t":60,
            "id":playerId,
            "status":status
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
