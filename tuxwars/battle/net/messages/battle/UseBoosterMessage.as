package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.BattleManager;
   
   public class UseBoosterMessage extends BattleMessage
   {
       
      
      public function UseBoosterMessage(boosterId:String, playerId:String)
      {
         super({
            "t":34,
            "bid":boosterId,
            "id":playerId
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
