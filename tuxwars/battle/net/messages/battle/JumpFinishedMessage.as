package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.BattleManager;
   
   public class JumpFinishedMessage extends BattleMessage
   {
       
      
      public function JumpFinishedMessage(id:String)
      {
         super({
            "t":5,
            "id":id
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
