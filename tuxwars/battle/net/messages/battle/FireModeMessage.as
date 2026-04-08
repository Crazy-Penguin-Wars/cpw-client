package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.*;
   
   public class FireModeMessage extends BattleMessage
   {
      public function FireModeMessage(param1:String)
      {
         super({
            "t":11,
            "id":param1
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

