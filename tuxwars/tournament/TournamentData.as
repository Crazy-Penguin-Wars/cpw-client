package tuxwars.tournament
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   
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
         var _loc3_:* = row;
         if(!_loc3_._cache["ID"])
         {
            _loc3_._cache["ID"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","ID");
         }
         var _loc4_:* = _loc3_._cache["ID"];
         _id = _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
         var _loc5_:* = row;
         §§push(ProjectManager);
         if(!_loc5_._cache["Name"])
         {
            _loc5_._cache["Name"] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name","Name");
         }
         var _loc6_:* = _loc5_._cache["Name"];
         _name = §§pop().getText(_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value);
         var _loc7_:* = row;
         if(!_loc7_._cache["GamesMaxAmount"])
         {
            _loc7_._cache["GamesMaxAmount"] = com.dchoc.utils.DCUtils.find(_loc7_._fields,"name","GamesMaxAmount");
         }
         var _loc8_:* = _loc7_._cache["GamesMaxAmount"];
         _gameMaxAmount = _loc8_.overrideValue != null ? _loc8_.overrideValue : _loc8_._value;
         var _loc9_:* = row;
         if(!_loc9_._cache["RequiredLevel"])
         {
            _loc9_._cache["RequiredLevel"] = com.dchoc.utils.DCUtils.find(_loc9_._fields,"name","RequiredLevel");
         }
         var _loc10_:* = _loc9_._cache["RequiredLevel"];
         _requiredLevel = _loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value;
         var _loc11_:* = row;
         if(!_loc11_._cache["StartingLeague"])
         {
            _loc11_._cache["StartingLeague"] = com.dchoc.utils.DCUtils.find(_loc11_._fields,"name","StartingLeague");
         }
         var _loc12_:* = _loc11_._cache["StartingLeague"];
         var _loc2_:Row = _loc12_.overrideValue != null ? _loc12_.overrideValue : _loc12_._value;
         _startingLeague = _loc2_.id;
         var _loc13_:* = row;
         if(!_loc13_._cache["RequiredPlacementsForQueue"])
         {
            _loc13_._cache["RequiredPlacementsForQueue"] = com.dchoc.utils.DCUtils.find(_loc13_._fields,"name","RequiredPlacementsForQueue");
         }
         var _loc14_:* = _loc13_._cache["RequiredPlacementsForQueue"];
         _requiredPlacementForQueue = _loc14_.overrideValue != null ? _loc14_.overrideValue : _loc14_._value;
         var _loc15_:* = row;
         if(!_loc15_._cache["RequiredPlacementsForLeague"])
         {
            _loc15_._cache["RequiredPlacementsForLeague"] = com.dchoc.utils.DCUtils.find(_loc15_._fields,"name","RequiredPlacementsForLeague");
         }
         var _loc16_:* = _loc15_._cache["RequiredPlacementsForLeague"];
         _requiredPlacementForLeague = _loc16_.overrideValue != null ? _loc16_.overrideValue : _loc16_._value;
         var _loc17_:* = row;
         if(!_loc17_._cache["InitialLeagueSize"])
         {
            _loc17_._cache["InitialLeagueSize"] = com.dchoc.utils.DCUtils.find(_loc17_._fields,"name","InitialLeagueSize");
         }
         var _loc18_:* = _loc17_._cache["InitialLeagueSize"];
         _leagueInitialSize = _loc18_.overrideValue != null ? _loc18_.overrideValue : _loc18_._value;
         var _loc19_:* = row;
         if(!_loc19_._cache["FirstPositionPoints"])
         {
            _loc19_._cache["FirstPositionPoints"] = com.dchoc.utils.DCUtils.find(_loc19_._fields,"name","FirstPositionPoints");
         }
         var _loc20_:* = _loc19_._cache["FirstPositionPoints"];
         _firstPositionPoints = _loc20_.overrideValue != null ? _loc20_.overrideValue : _loc20_._value;
         var _loc21_:* = row;
         if(!_loc21_._cache["SecondPositionPoints"])
         {
            _loc21_._cache["SecondPositionPoints"] = com.dchoc.utils.DCUtils.find(_loc21_._fields,"name","SecondPositionPoints");
         }
         var _loc22_:* = _loc21_._cache["SecondPositionPoints"];
         _secondPositionPoints = _loc22_.overrideValue != null ? _loc22_.overrideValue : _loc22_._value;
         var _loc23_:* = row;
         if(!_loc23_._cache["ThirdPositionPoints"])
         {
            _loc23_._cache["ThirdPositionPoints"] = com.dchoc.utils.DCUtils.find(_loc23_._fields,"name","ThirdPositionPoints");
         }
         var _loc24_:* = _loc23_._cache["ThirdPositionPoints"];
         _thirdPositionPoints = _loc24_.overrideValue != null ? _loc24_.overrideValue : _loc24_._value;
         var _loc25_:* = row;
         if(!_loc25_._cache["FourthPositionPoints"])
         {
            _loc25_._cache["FourthPositionPoints"] = com.dchoc.utils.DCUtils.find(_loc25_._fields,"name","FourthPositionPoints");
         }
         var _loc26_:* = _loc25_._cache["FourthPositionPoints"];
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
