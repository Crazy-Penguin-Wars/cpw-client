package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class PlayerTurnEndedMessage extends Message
   {
       
      
      private var turnDuration:int;
      
      public function PlayerTurnEndedMessage(player:PlayerGameObject, turnDuration:int)
      {
         super("PlayerTurnEnded",player);
         this.turnDuration = turnDuration;
      }
      
      public function get player() : PlayerGameObject
      {
         return data;
      }
      
      public function getTurnDuration() : int
      {
         return turnDuration;
      }
   }
}
