package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class PlayerScoreChanged extends Message
   {
       
      
      private var _amount:int;
      
      public function PlayerScoreChanged(player:PlayerGameObject, amount:int)
      {
         super("ScoreChanged",player);
         _amount = amount;
      }
      
      public function get player() : PlayerGameObject
      {
         return data;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
   }
}
