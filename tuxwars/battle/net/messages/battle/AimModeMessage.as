package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.*;
   
   public class AimModeMessage extends BattleMessage
   {
      public function AimModeMessage(param1:String, param2:String)
      {
         super({
            "t":12,
            "id":param1,
            "wid":param2
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

