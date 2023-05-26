package tuxwars.battle
{
   import tuxwars.player.Player;
   
   public class PlayerResult
   {
       
      
      private var _player:Player;
      
      private var _score:int;
      
      private var _coinsGained:int;
      
      private var _expGained:int;
      
      public function PlayerResult(player:Player, score:int, coindGained:int, expGained:int)
      {
         super();
         _player = player;
         _score = score;
         _coinsGained = coindGained;
         _expGained = expGained;
      }
      
      public function get player() : Player
      {
         return _player;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function get coinsGained() : int
      {
         return _coinsGained;
      }
      
      public function get expGained() : int
      {
         return _expGained;
      }
   }
}
