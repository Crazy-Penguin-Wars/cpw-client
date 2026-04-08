package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.*;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class ChickeningOutMessage extends SocketMessage
   {
      public static const STATUS_CANCEL:int = 0;
      
      public static const STATUS_CHICKENING_OUT:int = 1;
      
      public static const STATUS_CHICKENED_OUT:int = 2;
      
      public function ChickeningOutMessage(param1:String, param2:int)
      {
         super({
            "t":60,
            "id":param1,
            "status":param2
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

