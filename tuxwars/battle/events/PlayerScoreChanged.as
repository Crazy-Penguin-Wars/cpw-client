package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class PlayerScoreChanged extends Message
   {
      private var _amount:int;
      
      public function PlayerScoreChanged(param1:PlayerGameObject, param2:int)
      {
         super("ScoreChanged",param1);
         this._amount = param2;
      }
      
      public function get player() : PlayerGameObject
      {
         return data;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
   }
}

