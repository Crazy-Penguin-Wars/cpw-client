package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.*;
   
   public class JumpMessage extends BattleMessage
   {
      public function JumpMessage(param1:int, param2:int, param3:String)
      {
         super({
            "t":4,
            "id":param3,
            "x":param1,
            "y":param2
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

