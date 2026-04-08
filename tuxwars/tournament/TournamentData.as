package tuxwars.tournament
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
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
      
      public function TournamentData(param1:Row)
      {
         super();
         var _loc2_:String = "ID";
         var _loc3_:* = param1;
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         var _loc4_:* = _loc3_.getCache[_loc2_];
         this._id = _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
         var _loc5_:String = "Name";
         if(!param1.getCache[_loc5_])
         {
            param1.getCache[_loc5_] = DCUtils.find(param1.getFields(),"name",_loc5_);
         }
         var _loc6_:Field = param1.getCache[_loc5_];
         this._name = ProjectManager.getText(_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value);
         var _loc7_:String = "GamesMaxAmount";
         var _loc8_:* = param1;
         if(!_loc8_.getCache[_loc7_])
         {
            _loc8_.getCache[_loc7_] = DCUtils.find(_loc8_.getFields(),"name",_loc7_);
         }
         var _loc9_:* = _loc8_.getCache[_loc7_];
         this._gameMaxAmount = _loc9_.overrideValue != null ? int(_loc9_.overrideValue) : int(_loc9_._value);
         var _loc10_:String = "RequiredLevel";
         var _loc11_:* = param1;
         if(!_loc11_.getCache[_loc10_])
         {
            _loc11_.getCache[_loc10_] = DCUtils.find(_loc11_.getFields(),"name",_loc10_);
         }
         var _loc12_:* = _loc11_.getCache[_loc10_];
         this._requiredLevel = _loc12_.overrideValue != null ? int(_loc12_.overrideValue) : int(_loc12_._value);
         var _loc13_:String = "StartingLeague";
         var _loc14_:* = param1;
         if(!_loc14_.getCache[_loc13_])
         {
            _loc14_.getCache[_loc13_] = DCUtils.find(_loc14_.getFields(),"name",_loc13_);
         }
         var _loc15_:* = _loc14_.getCache[_loc13_];
         var _loc16_:Row = _loc15_.overrideValue != null ? _loc15_.overrideValue : _loc15_._value;
         this._startingLeague = _loc16_.id;
         var _loc17_:String = "RequiredPlacementsForQueue";
         var _loc18_:* = param1;
         if(!_loc18_.getCache[_loc17_])
         {
            _loc18_.getCache[_loc17_] = DCUtils.find(_loc18_.getFields(),"name",_loc17_);
         }
         var _loc19_:* = _loc18_.getCache[_loc17_];
         this._requiredPlacementForQueue = _loc19_.overrideValue != null ? int(_loc19_.overrideValue) : int(_loc19_._value);
         var _loc20_:String = "RequiredPlacementsForLeague";
         var _loc21_:* = param1;
         if(!_loc21_.getCache[_loc20_])
         {
            _loc21_.getCache[_loc20_] = DCUtils.find(_loc21_.getFields(),"name",_loc20_);
         }
         var _loc22_:* = _loc21_.getCache[_loc20_];
         this._requiredPlacementForLeague = _loc22_.overrideValue != null ? int(_loc22_.overrideValue) : int(_loc22_._value);
         var _loc23_:String = "InitialLeagueSize";
         var _loc24_:* = param1;
         if(!_loc24_.getCache[_loc23_])
         {
            _loc24_.getCache[_loc23_] = DCUtils.find(_loc24_.getFields(),"name",_loc23_);
         }
         var _loc25_:* = _loc24_.getCache[_loc23_];
         this._leagueInitialSize = _loc25_.overrideValue != null ? int(_loc25_.overrideValue) : int(_loc25_._value);
         var _loc26_:String = "FirstPositionPoints";
         var _loc27_:* = param1;
         if(!_loc27_.getCache[_loc26_])
         {
            _loc27_.getCache[_loc26_] = DCUtils.find(_loc27_.getFields(),"name",_loc26_);
         }
         var _loc28_:* = _loc27_.getCache[_loc26_];
         this._firstPositionPoints = _loc28_.overrideValue != null ? int(_loc28_.overrideValue) : int(_loc28_._value);
         var _loc29_:String = "SecondPositionPoints";
         var _loc30_:* = param1;
         if(!_loc30_.getCache[_loc29_])
         {
            _loc30_.getCache[_loc29_] = DCUtils.find(_loc30_.getFields(),"name",_loc29_);
         }
         var _loc31_:* = _loc30_.getCache[_loc29_];
         this._secondPositionPoints = _loc31_.overrideValue != null ? int(_loc31_.overrideValue) : int(_loc31_._value);
         var _loc32_:String = "ThirdPositionPoints";
         var _loc33_:* = param1;
         if(!_loc33_.getCache[_loc32_])
         {
            _loc33_.getCache[_loc32_] = DCUtils.find(_loc33_.getFields(),"name",_loc32_);
         }
         var _loc34_:* = _loc33_.getCache[_loc32_];
         this._thirdPositionPoints = _loc34_.overrideValue != null ? int(_loc34_.overrideValue) : int(_loc34_._value);
         var _loc35_:String = "FourthPositionPoints";
         var _loc36_:* = param1;
         if(!_loc36_.getCache[_loc35_])
         {
            _loc36_.getCache[_loc35_] = DCUtils.find(_loc36_.getFields(),"name",_loc35_);
         }
         var _loc37_:* = _loc36_.getCache[_loc35_];
         this._fourthPositionPoints = _loc37_.overrideValue != null ? int(_loc37_.overrideValue) : int(_loc37_._value);
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
      
      public function get leagueInitialSize() : int
      {
         return this._leagueInitialSize;
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
   }
}

