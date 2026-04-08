package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class PlayerTurnEndedMessage extends Message
   {
      private var turnDuration:int;
      
      public function PlayerTurnEndedMessage(param1:PlayerGameObject, param2:int)
      {
         super("PlayerTurnEnded",param1);
         this.turnDuration = param2;
      }
      
      public function get player() : PlayerGameObject
      {
         return data;
      }
      
      public function getTurnDuration() : int
      {
         return this.turnDuration;
      }
   }
}

