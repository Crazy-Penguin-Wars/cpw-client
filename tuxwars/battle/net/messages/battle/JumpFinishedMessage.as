package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.*;
   
   public class JumpFinishedMessage extends BattleMessage
   {
      public function JumpFinishedMessage(param1:String)
      {
         super({
            "t":5,
            "id":param1
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

