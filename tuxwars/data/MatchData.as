package tuxwars.data
{
   import tuxwars.battle.data.*;
   
   public class MatchData
   {
      public static const RANDOM_MAP:String = "RANDOM";
      
      private var _mapId:String;
      
      private var _matchTime:int;
      
      private var _turnTime:int;
      
      public function MatchData(param1:String, param2:int, param3:int)
      {
         super();
         this._mapId = param1;
         this._matchTime = param2;
         this._turnTime = param3;
      }
      
      public static function getDefaultMatchData() : MatchData
      {
         return new MatchData("RANDOM",BattleOptions.getMatchTime(),BattleOptions.getTurnTime());
      }
      
      public function get mapId() : String
      {
         return this._mapId;
      }
      
      public function set mapId(param1:String) : void
      {
         this._mapId = param1;
      }
      
      public function get matchTime() : int
      {
         return this._matchTime;
      }
      
      public function set matchTime(param1:int) : void
      {
         this._matchTime = param1;
      }
      
      public function get turnTime() : int
      {
         return this._turnTime;
      }
      
      public function set turnTime(param1:int) : void
      {
         this._turnTime = param1;
      }
      
      public function update(param1:Object) : void
      {
         this._mapId = !!param1.map ? param1.map : this._mapId;
         this._matchTime = !!param1.battle_time ? int(param1.battle_time / 60) : int(this._matchTime);
         this._turnTime = !!param1.turn_time ? int(param1.turn_time) : int(this._turnTime);
      }
   }
}

