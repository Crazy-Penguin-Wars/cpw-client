package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.*;
   
   public class AddPowerUpMessage extends BattleMessage
   {
      public function AddPowerUpMessage(param1:String)
      {
         super({
            "t":36,
            "pid":param1
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

