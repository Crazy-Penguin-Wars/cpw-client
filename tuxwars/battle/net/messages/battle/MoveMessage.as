package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.*;
   
   public class MoveMessage extends BattleMessage
   {
      public function MoveMessage(param1:int, param2:String)
      {
         super({
            "t":7,
            "id":param2,
            "d":param1
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

