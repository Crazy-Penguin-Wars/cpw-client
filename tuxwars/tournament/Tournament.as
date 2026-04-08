package tuxwars.tournament
{
   public class Tournament
   {
      public static const STATUS_NOT_STARTED:int = 0;
      
      public static const STATUS_PLAYING:int = 10;
      
      public static const STATUS_REPARTITIONING:int = 20;
      
      public static const STATUS_FINISHING:int = 30;
      
      public static const STATUS_FINISHED:int = 40;
      
      public static const STATUS_UNKNOWN:int = 99;
      
      public static const ACCOUNT_STATUS_PRE_QUEUE:int = 0;
      
      public static const ACCOUNT_STATUS_IN_QUEUE:int = 10;
      
      public static const ACCOUNT_STATUS_RESERVED:int = 20;
      
      public static const ACCOUNT_STATUS_READY:int = 30;
      
      public static const ACCOUNT_STATUS_FINISHED:int = 40;
      
      public static const ACCOUNT_STATUS_REWARDED:int = 50;
      
      public static const ACCOUNT_STATUS_UNKNOWN:int = 99;
      
      private var _id:String;
      
      private var _status:int;
      
      private var _name:String;
      
      private var _gameMaxAmount:int;
      
      private var _requiredLevel:int;
      
      private var _startingLeague:String;
      
      private var _requiredPlacementForQueue:int;
      
      private var _requiredPlacementForLeague:int;
      
      private var _leagueSize:int;
      
      private var _firstPositionPoints:int;
      
      private var _secondPositionPoints:int;
      
      private var _thirdPositionPoints:int;
      
      private var _fourthPositionPoints:int;
      
      private var _tournamentTime:int;
      
      private var _league:League;
      
      public function Tournament(param1:TournamentData)
      {
         super();
         this._id = param1.id;
         this._name = param1.name;
         this._gameMaxAmount = param1.gameMaxAmount;
         this._requiredLevel = param1.requiredLevel;
         this._startingLeague = param1.startingLeague;
         this._requiredPlacementForQueue = param1.requiredPlacementForQueue;
         this._requiredPlacementForLeague = param1.requiredPlacementForLeague;
         this._leagueSize = param1.leagueInitialSize;
         this._firstPositionPoints = param1.firstPositionPoints;
         this._secondPositionPoints = param1.secondPositionPoints;
         this._thirdPositionPoints = param1.thirdPositionPoints;
         this._fourthPositionPoints = param1.fourthPositionPoints;
      }
      
      public function set league(param1:League) : void
      {
         this._league = param1;
      }
      
      public function get league() : League
      {
         return this._league;
      }
      
      public function set status(param1:int) : void
      {
         this._status = param1;
      }
      
      public function get status() : int
      {
         return this._status;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get gameMaxAmount() : int
      {
         return this._gameMaxAmount;
      }
      
      public function get requiredLevel() : int
      {
         return this._requiredLevel;
      }
      
      public function get startingLeague() : String
      {
         return this._startingLeague;
      }
      
      public function get requiredPlacementForQueue() : int
      {
         return this._requiredPlacementForQueue;
      }
      
      public function get requiredPlacementForLeague() : int
      {
         return this._requiredPlacementForLeague;
      }
      
      public function set leagueSize(param1:int) : void
      {
         this._leagueSize = param1;
      }
      
      public function get leagueSize() : int
      {
         return this._leagueSize;
      }
      
      public function get firstPositionPoints() : int
      {
         return this._firstPositionPoints;
      }
      
      public function get secondPositionPoints() : int
      {
         return this._secondPositionPoints;
      }
      
      public function get thirdPositionPoints() : int
      {
         return this._thirdPositionPoints;
      }
      
      public function get fourthPositionPoints() : int
      {
         return this._fourthPositionPoints;
      }
      
      public function set tournamentTime(param1:int) : void
      {
         this._tournamentTime = param1;
      }
      
      public function getTournamentTimeInSeconds() : int
      {
         return this._tournamentTime / 1000;
      }
      
      public function updateTournamentTime(param1:int) : void
      {
         this._tournamentTime -= param1;
         if(this._tournamentTime < 0)
         {
            this._tournamentTime = 0;
         }
      }
      
      public function isTournamentOver() : Boolean
      {
         return this._tournamentTime <= 0;
      }
      
      public function dispose() : void
      {
         if(this._league)
         {
            this._league.dispose();
         }
      }
   }
}

