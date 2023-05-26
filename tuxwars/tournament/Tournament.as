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
      
      public function Tournament(data:TournamentData)
      {
         super();
         _id = data.id;
         _name = data.name;
         _gameMaxAmount = data.gameMaxAmount;
         _requiredLevel = data.requiredLevel;
         _startingLeague = data.startingLeague;
         _requiredPlacementForQueue = data.requiredPlacementForQueue;
         _requiredPlacementForLeague = data.requiredPlacementForLeague;
         _leagueSize = data.leagueInitialSize;
         _firstPositionPoints = data.firstPositionPoints;
         _secondPositionPoints = data.secondPositionPoints;
         _thirdPositionPoints = data.thirdPositionPoints;
         _fourthPositionPoints = data.fourthPositionPoints;
      }
      
      public function set league(newLeague:League) : void
      {
         _league = newLeague;
      }
      
      public function get league() : League
      {
         return _league;
      }
      
      public function set status(value:int) : void
      {
         _status = value;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get gameMaxAmount() : int
      {
         return _gameMaxAmount;
      }
      
      public function get requiredLevel() : int
      {
         return _requiredLevel;
      }
      
      public function get startingLeague() : String
      {
         return _startingLeague;
      }
      
      public function get requiredPlacementForQueue() : int
      {
         return _requiredPlacementForQueue;
      }
      
      public function get requiredPlacementForLeague() : int
      {
         return _requiredPlacementForLeague;
      }
      
      public function set leagueSize(value:int) : void
      {
         _leagueSize = value;
      }
      
      public function get leagueSize() : int
      {
         return _leagueSize;
      }
      
      public function get firstPositionPoints() : int
      {
         return _firstPositionPoints;
      }
      
      public function get secondPositionPoints() : int
      {
         return _secondPositionPoints;
      }
      
      public function get thirdPositionPoints() : int
      {
         return _thirdPositionPoints;
      }
      
      public function get fourthPositionPoints() : int
      {
         return _fourthPositionPoints;
      }
      
      public function set tournamentTime(value:int) : void
      {
         _tournamentTime = value;
      }
      
      public function getTournamentTimeInSeconds() : int
      {
         return _tournamentTime / 1000;
      }
      
      public function updateTournamentTime(deltaTime:int) : void
      {
         _tournamentTime -= deltaTime;
         if(_tournamentTime < 0)
         {
            _tournamentTime = 0;
         }
      }
      
      public function isTournamentOver() : Boolean
      {
         return _tournamentTime <= 0;
      }
      
      public function dispose() : void
      {
         if(_league)
         {
            _league.dispose();
         }
      }
   }
}
