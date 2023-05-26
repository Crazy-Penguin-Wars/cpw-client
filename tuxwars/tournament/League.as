package tuxwars.tournament
{
   import tuxwars.TuxWarsGame;
   import tuxwars.items.TournamentRewardItem;
   
   public class League
   {
       
      
      private var _game:TuxWarsGame;
      
      private var _id:String;
      
      private var _sortPriority:int;
      
      private var _name:String;
      
      private var _trophyGraphic:String;
      
      private var _nextLeague:League;
      
      private var _previousLeague:League;
      
      private var _promotedPlayers:int;
      
      private var _relegatedPlayers:int;
      
      private var _firstPositionReward:TournamentRewardItem;
      
      private var _secondPositionReward:TournamentRewardItem;
      
      private var _thirdPositionReward:TournamentRewardItem;
      
      private var _fourthPositionReward:TournamentRewardItem;
      
      private var _playedGames:int;
      
      private var _points:int;
      
      private var _score:String;
      
      private var _pointReward:String;
      
      private var _pointRewardMultiplier:int;
      
      private var _rank:int;
      
      private var _previousRank:int;
      
      private var _status:int;
      
      private var _divisionId:String;
      
      private var _players:Vector.<TournamentPlayer>;
      
      private var _rewardId:String;
      
      private var _rankReward:TournamentRewardItem;
      
      public function League(game:TuxWarsGame, data:LeagueData)
      {
         _players = new Vector.<TournamentPlayer>();
         super();
         _game = game;
         _id = data.id;
         _sortPriority = data.sortPriority;
         _name = data.name;
         _trophyGraphic = data.trophyGraphic;
         _promotedPlayers = data.promotedPlayers;
         _relegatedPlayers = data.relegatedPlayers;
         _pointReward = data.pointReward;
         _pointRewardMultiplier = data.pointRewardMultiplier;
         _score = "0";
         _rank = 0;
         _rewardId = null;
         _divisionId = null;
         _firstPositionReward = null;
         _secondPositionReward = null;
         _thirdPositionReward = null;
         _fourthPositionReward = null;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get sortPriority() : int
      {
         return _sortPriority;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get trophyGraphic() : String
      {
         return _trophyGraphic;
      }
      
      public function get promotedPlayers() : int
      {
         return _promotedPlayers;
      }
      
      public function get relegatedPlayers() : int
      {
         return _relegatedPlayers;
      }
      
      public function get nextLeague() : League
      {
         return _nextLeague;
      }
      
      public function get previousLeague() : League
      {
         return _previousLeague;
      }
      
      public function get firstPositionReward() : TournamentRewardItem
      {
         return _firstPositionReward;
      }
      
      public function set firstPositionReward(reward:TournamentRewardItem) : void
      {
         _firstPositionReward = reward;
      }
      
      public function get secondPositionReward() : TournamentRewardItem
      {
         return _secondPositionReward;
      }
      
      public function set secondPositionReward(reward:TournamentRewardItem) : void
      {
         _secondPositionReward = reward;
      }
      
      public function get thirdPositionReward() : TournamentRewardItem
      {
         return _thirdPositionReward;
      }
      
      public function set thirdPositionReward(reward:TournamentRewardItem) : void
      {
         _thirdPositionReward = reward;
      }
      
      public function get fourthPositionReward() : TournamentRewardItem
      {
         return _fourthPositionReward;
      }
      
      public function set fourthPositionReward(reward:TournamentRewardItem) : void
      {
         _fourthPositionReward = reward;
      }
      
      public function getPositionReward(position:int) : TournamentRewardItem
      {
         if(position == 1)
         {
            return _firstPositionReward;
         }
         if(position == 2)
         {
            return _secondPositionReward;
         }
         if(position == 3)
         {
            return _thirdPositionReward;
         }
         if(position == 4)
         {
            return _fourthPositionReward;
         }
         return null;
      }
      
      public function getPositionRewardsAmount() : int
      {
         var count:int = 0;
         count += _firstPositionReward != null ? 1 : 0;
         count += _secondPositionReward != null ? 1 : 0;
         count += _thirdPositionReward != null ? 1 : 0;
         return count + (_fourthPositionReward != null ? 1 : 0);
      }
      
      public function get playedGames() : int
      {
         return _playedGames;
      }
      
      public function set playedGames(value:int) : void
      {
         _playedGames = value;
      }
      
      public function get points() : int
      {
         return _points;
      }
      
      public function set points(value:int) : void
      {
         _points = value;
      }
      
      public function get score() : String
      {
         return _score;
      }
      
      public function set score(value:String) : void
      {
         _score = value;
      }
      
      public function get pointRewardMultiplier() : int
      {
         return _pointRewardMultiplier;
      }
      
      public function get pointReward() : String
      {
         return _pointReward;
      }
      
      public function get previousRank() : int
      {
         return _previousRank;
      }
      
      public function set previousRank(value:int) : void
      {
         _previousRank = value;
      }
      
      public function get rank() : int
      {
         return _rank;
      }
      
      public function set rank(value:int) : void
      {
         _rank = value;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function set status(value:int) : void
      {
         _status = value;
      }
      
      public function get rewardId() : String
      {
         return _rewardId;
      }
      
      public function set rewardId(value:String) : void
      {
         _rewardId = value;
      }
      
      public function isLeagueFinished() : Boolean
      {
         return _rewardId && _rewardId != "";
      }
      
      public function set rankReward(value:TournamentRewardItem) : void
      {
         _rankReward = value;
      }
      
      public function get rankReward() : TournamentRewardItem
      {
         return _rankReward;
      }
      
      public function get divisionId() : String
      {
         return _divisionId;
      }
      
      public function set divisionId(value:String) : void
      {
         _divisionId = value;
      }
      
      public function addPlayer(p:TournamentPlayer) : void
      {
         _players.push(p);
      }
      
      public function clearPlayers() : void
      {
         if(_players)
         {
            _players.splice(0,_players.length);
         }
      }
      
      public function organizePlayersByRank() : void
      {
         _players.sort(sortByRank);
      }
      
      private function sortByRank(a:TournamentPlayer, b:TournamentPlayer) : int
      {
         if(a.rank == b.rank)
         {
            return 0;
         }
         if(a.rank < b.rank)
         {
            return -1;
         }
         return 1;
      }
      
      public function getPlayers() : Vector.<TournamentPlayer>
      {
         return _players;
      }
      
      public function findMyIndex() : int
      {
         var index:int = 0;
         for each(var p in _players)
         {
            if(p.dcg_id == _game.player.id)
            {
               return index;
            }
            index++;
         }
         return -1;
      }
      
      public function dispose() : void
      {
         _players.splice(0,_players.length);
         _firstPositionReward = null;
         _secondPositionReward = null;
         _thirdPositionReward = null;
         _fourthPositionReward = null;
         _rewardId = null;
      }
   }
}
