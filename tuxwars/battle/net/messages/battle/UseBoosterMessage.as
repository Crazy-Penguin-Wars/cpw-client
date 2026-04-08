package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.*;
   
   public class UseBoosterMessage extends BattleMessage
   {
      public function UseBoosterMessage(param1:String, param2:String)
      {
         super({
            "t":34,
            "bid":param1,
            "id":param2
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

