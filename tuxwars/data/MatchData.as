package tuxwars.data
{
   import tuxwars.battle.data.BattleOptions;
   
   public class MatchData
   {
      
      public static const RANDOM_MAP:String = "RANDOM";
       
      
      private var _mapId:String;
      
      private var _matchTime:int;
      
      private var _turnTime:int;
      
      public function MatchData(mapId:String, matchTime:int, turnTime:int)
      {
         super();
         _mapId = mapId;
         _matchTime = matchTime;
         _turnTime = turnTime;
      }
      
      public static function getDefaultMatchData() : MatchData
      {
         return new MatchData("RANDOM",BattleOptions.getMatchTime(),BattleOptions.getTurnTime());
      }
      
      public function get mapId() : String
      {
         return _mapId;
      }
      
      public function set mapId(value:String) : void
      {
         _mapId = value;
      }
      
      public function get matchTime() : int
      {
         return _matchTime;
      }
      
      public function set matchTime(value:int) : void
      {
         _matchTime = value;
      }
      
      public function get turnTime() : int
      {
         return _turnTime;
      }
      
      public function set turnTime(value:int) : void
      {
         _turnTime = value;
      }
      
      public function update(data:Object) : void
      {
         _mapId = !!data.map ? data.map : _mapId;
         _matchTime = !!data.battle_time ? Number(data.battle_time) / 60 : _matchTime;
         _turnTime = !!data.turn_time ? data.turn_time : _turnTime;
      }
   }
}
