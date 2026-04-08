package tuxwars.battle
{
   import tuxwars.player.Player;
   
   public class PlayerResult
   {
      private var _player:Player;
      
      private var _score:int;
      
      private var _coinsGained:int;
      
      private var _expGained:int;
      
      public function PlayerResult(param1:Player, param2:int, param3:int, param4:int)
      {
         super();
         this._player = param1;
         this._score = param2;
         this._coinsGained = param3;
         this._expGained = param4;
      }
      
      public function get player() : Player
      {
         return this._player;
      }
      
      public function get score() : int
      {
         return this._score;
      }
      
      public function get coinsGained() : int
      {
         return this._coinsGained;
      }
      
      public function get expGained() : int
      {
         return this._expGained;
      }
   }
}

