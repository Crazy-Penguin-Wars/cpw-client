package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.BattleManager;
   
   public class JumpMessage extends BattleMessage
   {
       
      
      public function JumpMessage(x:int, y:int, id:String)
      {
         super({
            "t":4,
            "id":id,
            "x":x,
            "y":y
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
