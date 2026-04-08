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
      
      private var _players:Vector.<TournamentPlayer> = new Vector.<TournamentPlayer>();
      
      private var _rewardId:String;
      
      private var _rankReward:TournamentRewardItem;
      
      public function League(param1:TuxWarsGame, param2:LeagueData)
      {
         super();
         this._game = param1;
         this._id = param2.id;
         this._sortPriority = param2.sortPriority;
         this._name = param2.name;
         this._trophyGraphic = param2.trophyGraphic;
         this._promotedPlayers = param2.promotedPlayers;
         this._relegatedPlayers = param2.relegatedPlayers;
         this._pointReward = param2.pointReward;
         this._pointRewardMultiplier = param2.pointRewardMultiplier;
         this._score = "0";
         this._rank = 0;
         this._rewardId = null;
         this._divisionId = null;
         this._firstPositionReward = null;
         this._secondPositionReward = null;
         this._thirdPositionReward = null;
         this._fourthPositionReward = null;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get sortPriority() : int
      {
         return this._sortPriority;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get trophyGraphic() : String
      {
         return this._trophyGraphic;
      }
      
      public function get promotedPlayers() : int
      {
         return this._promotedPlayers;
      }
      
      public function get relegatedPlayers() : int
      {
         return this._relegatedPlayers;
      }
      
      public function get nextLeague() : League
      {
         return this._nextLeague;
      }
      
      public function get previousLeague() : League
      {
         return this._previousLeague;
      }
      
      public function get firstPositionReward() : TournamentRewardItem
      {
         return this._firstPositionReward;
      }
      
      public function set firstPositionReward(param1:TournamentRewardItem) : void
      {
         this._firstPositionReward = param1;
      }
      
      public function get secondPositionReward() : TournamentRewardItem
      {
         return this._secondPositionReward;
      }
      
      public function set secondPositionReward(param1:TournamentRewardItem) : void
      {
         this._secondPositionReward = param1;
      }
      
      public function get thirdPositionReward() : TournamentRewardItem
      {
         return this._thirdPositionReward;
      }
      
      public function set thirdPositionReward(param1:TournamentRewardItem) : void
      {
         this._thirdPositionReward = param1;
      }
      
      public function get fourthPositionReward() : TournamentRewardItem
      {
         return this._fourthPositionReward;
      }
      
      public function set fourthPositionReward(param1:TournamentRewardItem) : void
      {
         this._fourthPositionReward = param1;
      }
      
      public function getPositionReward(param1:int) : TournamentRewardItem
      {
         if(param1 == 1)
         {
            return this._firstPositionReward;
         }
         if(param1 == 2)
         {
            return this._secondPositionReward;
         }
         if(param1 == 3)
         {
            return this._thirdPositionReward;
         }
         if(param1 == 4)
         {
            return this._fourthPositionReward;
         }
         return null;
      }
      
      public function getPositionRewardsAmount() : int
      {
         var _loc1_:int = 0;
         _loc1_ += this._firstPositionReward != null ? 1 : 0;
         _loc1_ += this._secondPositionReward != null ? 1 : 0;
         _loc1_ += this._thirdPositionReward != null ? 1 : 0;
         return _loc1_ + (this._fourthPositionReward != null ? 1 : 0);
      }
      
      public function get playedGames() : int
      {
         return this._playedGames;
      }
      
      public function set playedGames(param1:int) : void
      {
         this._playedGames = param1;
      }
      
      public function get points() : int
      {
         return this._points;
      }
      
      public function set points(param1:int) : void
      {
         this._points = param1;
      }
      
      public function get score() : String
      {
         return this._score;
      }
      
      public function set score(param1:String) : void
      {
         this._score = param1;
      }
      
      public function get pointRewardMultiplier() : int
      {
         return this._pointRewardMultiplier;
      }
      
      public function get pointReward() : String
      {
         return this._pointReward;
      }
      
      public function get previousRank() : int
      {
         return this._previousRank;
      }
      
      public function set previousRank(param1:int) : void
      {
         this._previousRank = param1;
      }
      
      public function get rank() : int
      {
         return this._rank;
      }
      
      public function set rank(param1:int) : void
      {
         this._rank = param1;
      }
      
      public function get status() : int
      {
         return this._status;
      }
      
      public function set status(param1:int) : void
      {
         this._status = param1;
      }
      
      public function get rewardId() : String
      {
         return this._rewardId;
      }
      
      public function set rewardId(param1:String) : void
      {
         this._rewardId = param1;
      }
      
      public function isLeagueFinished() : Boolean
      {
         return Boolean(this._rewardId) && this._rewardId != "";
      }
      
      public function set rankReward(param1:TournamentRewardItem) : void
      {
         this._rankReward = param1;
      }
      
      public function get rankReward() : TournamentRewardItem
      {
         return this._rankReward;
      }
      
      public function get divisionId() : String
      {
         return this._divisionId;
      }
      
      public function set divisionId(param1:String) : void
      {
         this._divisionId = param1;
      }
      
      public function addPlayer(param1:TournamentPlayer) : void
      {
         this._players.push(param1);
      }
      
      public function clearPlayers() : void
      {
         if(this._players)
         {
            this._players.splice(0,this._players.length);
         }
      }
      
      public function organizePlayersByRank() : void
      {
         this._players.sort(this.sortByRank);
      }
      
      private function sortByRank(param1:TournamentPlayer, param2:TournamentPlayer) : int
      {
         if(param1.rank == param2.rank)
         {
            return 0;
         }
         if(param1.rank < param2.rank)
         {
            return -1;
         }
         return 1;
      }
      
      public function getPlayers() : Vector.<TournamentPlayer>
      {
         return this._players;
      }
      
      public function findMyIndex() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         for each(_loc2_ in this._players)
         {
            if(_loc2_.dcg_id == this._game.player.id)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function dispose() : void
      {
         this._players.splice(0,this._players.length);
         this._firstPositionReward = null;
         this._secondPositionReward = null;
         this._thirdPositionReward = null;
         this._fourthPositionReward = null;
         this._rewardId = null;
      }
   }
}

