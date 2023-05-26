package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.BattleManager;
   
   public class WalkModeMessage extends BattleMessage
   {
       
      
      public function WalkModeMessage(id:String)
      {
         super({
            "t":8,
            "id":id
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
