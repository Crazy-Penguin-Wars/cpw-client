package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.*;
   
   public class WalkModeMessage extends BattleMessage
   {
      public function WalkModeMessage(param1:String)
      {
         super({
            "t":8,
            "id":param1
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

