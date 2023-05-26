package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.BattleManager;
   
   public class AddPowerUpMessage extends BattleMessage
   {
       
      
      public function AddPowerUpMessage(powerUpId:String)
      {
         super({
            "t":36,
            "pid":powerUpId
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
