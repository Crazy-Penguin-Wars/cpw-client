package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.BattleManager;
   
   public class FireModeMessage extends BattleMessage
   {
       
      
      public function FireModeMessage(id:String)
      {
         super({
            "t":11,
            "id":id
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
