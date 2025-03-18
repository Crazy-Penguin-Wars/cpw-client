package tuxwars.tournament
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class TournamentData
   {
      private static const ID:String = "ID";
      
      private static const NAME:String = "Name";
      
      private static const GAMES_MAX_AMOUNT:String = "GamesMaxAmount";
      
      private static const REQUIRED_LEVEL:String = "RequiredLevel";
      
      private static const STARTING_LEAGUE:String = "StartingLeague";
      
      private static const REQUIRED_PLACEMENTS_FOR_QUEUE:String = "RequiredPlacementsForQueue";
      
      private static const REQUIRED_PLACEMENTS_FOR_LEAGUE:String = "RequiredPlacementsForLeague";
      
      private static const INITIAL_LEAGUE_SIZE:String = "InitialLeagueSize";
      
      private static const FIRST_POSITION_POINTS:String = "FirstPositionPoints";
      
      private static const SECOND_POSITION_POINTS:String = "SecondPositionPoints";
      
      private static const THIRD_POSITION_POINTS:String = "ThirdPositionPoints";
      
      private static const FOURTH_POSITION_POINTS:String = "FourthPositionPoints";
      
      private var _id:String;
      
      private var _name:String;
      
      private var _gameMaxAmount:int;
      
      private var _requiredLevel:int;
      
      private var _startingLeague:String;
      
      private var _requiredPlacementForQueue:int;
      
      private var _requiredPlacementForLeague:int;
      
      private var _leagueInitialSize:int;
      
      private var _firstPositionPoints:int;
      
      private var _secondPositionPoints:int;
      
      private var _thirdPositionPoints:int;
      
      private var _fourthPositionPoints:int;
      
      public function TournamentData(row:Row)
      {
         super();
         var _loc27_:String = "ID";
         var _loc3_:* = row;
         if(!_loc3_._cache[_loc27_])
         {
            _loc3_._cache[_loc27_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc27_);
         }
         var _loc4_:* = _loc3_._cache[_loc27_];
         _id = _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
         var _loc28_:String = "Name";
         var _loc5_:* = row;
         §§push(ProjectManager);
         if(!_loc5_._cache[_loc28_])
         {
            _loc5_._cache[_loc28_] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name",_loc28_);
         }
         var _loc6_:* = _loc5_._cache[_loc28_];
         _name = §§pop().getText(_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value);
         var _loc29_:String = "GamesMaxAmount";
         var _loc7_:* = row;
         if(!_loc7_._cache[_loc29_])
         {
            _loc7_._cache[_loc29_] = com.dchoc.utils.DCUtils.find(_loc7_._fields,"name",_loc29_);
         }
         var _loc8_:* = _loc7_._cache[_loc29_];
         _gameMaxAmount = _loc8_.overrideValue != null ? _loc8_.overrideValue : _loc8_._value;
         var _loc30_:String = "RequiredLevel";
         var _loc9_:* = row;
         if(!_loc9_._cache[_loc30_])
         {
            _loc9_._cache[_loc30_] = com.dchoc.utils.DCUtils.find(_loc9_._fields,"name",_loc30_);
         }
         var _loc10_:* = _loc9_._cache[_loc30_];
         _requiredLevel = _loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value;
         var _loc31_:String = "StartingLeague";
         var _loc11_:* = row;
         if(!_loc11_._cache[_loc31_])
         {
            _loc11_._cache[_loc31_] = com.dchoc.utils.DCUtils.find(_loc11_._fields,"name",_loc31_);
         }
         var _loc12_:* = _loc11_._cache[_loc31_];
         var _loc2_:Row = _loc12_.overrideValue != null ? _loc12_.overrideValue : _loc12_._value;
         _startingLeague = _loc2_.id;
         var _loc32_:String = "RequiredPlacementsForQueue";
         var _loc13_:* = row;
         if(!_loc13_._cache[_loc32_])
         {
            _loc13_._cache[_loc32_] = com.dchoc.utils.DCUtils.find(_loc13_._fields,"name",_loc32_);
         }
         var _loc14_:* = _loc13_._cache[_loc32_];
         _requiredPlacementForQueue = _loc14_.overrideValue != null ? _loc14_.overrideValue : _loc14_._value;
         var _loc33_:String = "RequiredPlacementsForLeague";
         var _loc15_:* = row;
         if(!_loc15_._cache[_loc33_])
         {
            _loc15_._cache[_loc33_] = com.dchoc.utils.DCUtils.find(_loc15_._fields,"name",_loc33_);
         }
         var _loc16_:* = _loc15_._cache[_loc33_];
         _requiredPlacementForLeague = _loc16_.overrideValue != null ? _loc16_.overrideValue : _loc16_._value;
         var _loc34_:String = "InitialLeagueSize";
         var _loc17_:* = row;
         if(!_loc17_._cache[_loc34_])
         {
            _loc17_._cache[_loc34_] = com.dchoc.utils.DCUtils.find(_loc17_._fields,"name",_loc34_);
         }
         var _loc18_:* = _loc17_._cache[_loc34_];
         _leagueInitialSize = _loc18_.overrideValue != null ? _loc18_.overrideValue : _loc18_._value;
         var _loc35_:String = "FirstPositionPoints";
         var _loc19_:* = row;
         if(!_loc19_._cache[_loc35_])
         {
            _loc19_._cache[_loc35_] = com.dchoc.utils.DCUtils.find(_loc19_._fields,"name",_loc35_);
         }
         var _loc20_:* = _loc19_._cache[_loc35_];
         _firstPositionPoints = _loc20_.overrideValue != null ? _loc20_.overrideValue : _loc20_._value;
         var _loc36_:String = "SecondPositionPoints";
         var _loc21_:* = row;
         if(!_loc21_._cache[_loc36_])
         {
            _loc21_._cache[_loc36_] = com.dchoc.utils.DCUtils.find(_loc21_._fields,"name",_loc36_);
         }
         var _loc22_:* = _loc21_._cache[_loc36_];
         _secondPositionPoints = _loc22_.overrideValue != null ? _loc22_.overrideValue : _loc22_._value;
         var _loc37_:String = "ThirdPositionPoints";
         var _loc23_:* = row;
         if(!_loc23_._cache[_loc37_])
         {
            _loc23_._cache[_loc37_] = com.dchoc.utils.DCUtils.find(_loc23_._fields,"name",_loc37_);
         }
         var _loc24_:* = _loc23_._cache[_loc37_];
         _thirdPositionPoints = _loc24_.overrideValue != null ? _loc24_.overrideValue : _loc24_._value;
         var _loc38_:String = "FourthPositionPoints";
         var _loc25_:* = row;
         if(!_loc25_._cache[_loc38_])
         {
            _loc25_._cache[_loc38_] = com.dchoc.utils.DCUtils.find(_loc25_._fields,"name",_loc38_);
         }
         var _loc26_:* = _loc25_._cache[_loc38_];
         _fourthPositionPoints = _loc26_.overrideValue != null ? _loc26_.overrideValue : _loc26_._value;
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
      
      public function get leagueInitialSize() : int
      {
         return _leagueInitialSize;
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
   }
}

