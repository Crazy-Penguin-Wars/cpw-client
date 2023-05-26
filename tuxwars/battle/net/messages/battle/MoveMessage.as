package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.BattleManager;
   
   public class MoveMessage extends BattleMessage
   {
       
      
      public function MoveMessage(direction:int, id:String)
      {
         super({
            "t":7,
            "id":id,
            "d":direction
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
