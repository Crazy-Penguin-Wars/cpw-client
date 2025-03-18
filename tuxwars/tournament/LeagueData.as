package tuxwars.tournament
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import no.olog.utilfunctions.assert;
   
   public class LeagueData
   {
      private static const FIELD_ID:String = "ID";
      
      private static const SORT_PRIORITY:String = "SortPriority";
      
      private static const FIELD_NAME:String = "Name";
      
      private static const FIELD_TROPHY_GRAPHIC:String = "TrophyGraphic";
      
      private static const FIELD_NEXT_LEAGUE:String = "NextLeague";
      
      private static const FIELD_PREVIOUS_LEAGUE:String = "PreviousLeague";
      
      private static const FIELD_PROMOTED_PLAYERS:String = "PromotedPlayers";
      
      private static const FIELD_RELEGATED_PLAYERS:String = "RelegatedPlayers";
      
      private static const FIELD_FIRST_POSITION_REWARD:String = "FirstPositionReward";
      
      private static const FIELD_SECOND_POSITION_REWARD:String = "SecondPositionReward";
      
      private static const FIELD_THIRD_POSITION_REWARD:String = "ThirdPositionReward";
      
      private static const FIELD_FOURTH_POSITION_REWARD:String = "FourthPositionReward";
      
      private static const POINT_REWARD_MULTIPLIER:String = "PointRewardMultiplier";
      
      private static const POINT_REWARD:String = "PointReward";
      
      private var _id:String;
      
      private var _sortPriority:int;
      
      private var _name:String;
      
      private var _trophyGraphic:String;
      
      private var _nextLeague:String;
      
      private var _previousLeague:String;
      
      private var _promotedPlayers:int;
      
      private var _relegatedPlayers:int;
      
      private var _firstPositionReward:String;
      
      private var _secondPositionReward:String;
      
      private var _thirdPositionReward:String;
      
      private var _fourthPositionReward:String;
      
      private var _pointReward:String;
      
      private var _pointRewardMultiplier:int;
      
      public function LeagueData(row:Row)
      {
         var tempRow:Row = null;
         super();
         assert("Row is null.",true,row != null);
         var _loc40_:String = "ID";
         var _loc4_:* = row;
         if(!_loc4_._cache[_loc40_])
         {
            _loc4_._cache[_loc40_] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name",_loc40_);
         }
         var _loc5_:* = _loc4_._cache[_loc40_];
         _id = _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value;
         var _loc41_:String = "SortPriority";
         var _loc6_:* = row;
         if(!_loc6_._cache[_loc41_])
         {
            _loc6_._cache[_loc41_] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name",_loc41_);
         }
         var _loc7_:* = _loc6_._cache[_loc41_];
         _sortPriority = _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value;
         var _loc42_:String = "Name";
         var _loc8_:* = row;
         if(!_loc8_._cache[_loc42_])
         {
            _loc8_._cache[_loc42_] = com.dchoc.utils.DCUtils.find(_loc8_._fields,"name",_loc42_);
         }
         var _loc9_:* = _loc8_._cache[_loc42_];
         _name = _loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value;
         var _loc43_:String = "TrophyGraphic";
         var _loc10_:* = row;
         if(!_loc10_._cache[_loc43_])
         {
            _loc10_._cache[_loc43_] = com.dchoc.utils.DCUtils.find(_loc10_._fields,"name",_loc43_);
         }
         var _loc11_:* = _loc10_._cache[_loc43_];
         _trophyGraphic = _loc11_.overrideValue != null ? _loc11_.overrideValue : _loc11_._value;
         var _loc44_:String = "PromotedPlayers";
         var _loc12_:* = row;
         if(!_loc12_._cache[_loc44_])
         {
            _loc12_._cache[_loc44_] = com.dchoc.utils.DCUtils.find(_loc12_._fields,"name",_loc44_);
         }
         if(_loc12_._cache[_loc44_])
         {
            var _loc45_:String = "PromotedPlayers";
            var _loc13_:* = row;
            if(!_loc13_._cache[_loc45_])
            {
               _loc13_._cache[_loc45_] = com.dchoc.utils.DCUtils.find(_loc13_._fields,"name",_loc45_);
            }
            var _loc14_:* = _loc13_._cache[_loc45_];
            §§push(_loc14_.overrideValue != null ? _loc14_.overrideValue : _loc14_._value);
         }
         else
         {
            §§push(0);
         }
         _promotedPlayers = §§pop();
         var _loc46_:String = "RelegatedPlayers";
         var _loc15_:* = row;
         if(!_loc15_._cache[_loc46_])
         {
            _loc15_._cache[_loc46_] = com.dchoc.utils.DCUtils.find(_loc15_._fields,"name",_loc46_);
         }
         if(_loc15_._cache[_loc46_])
         {
            var _loc47_:String = "RelegatedPlayers";
            var _loc16_:* = row;
            if(!_loc16_._cache[_loc47_])
            {
               _loc16_._cache[_loc47_] = com.dchoc.utils.DCUtils.find(_loc16_._fields,"name",_loc47_);
            }
            var _loc17_:* = _loc16_._cache[_loc47_];
            §§push(_loc17_.overrideValue != null ? _loc17_.overrideValue : _loc17_._value);
         }
         else
         {
            §§push(0);
         }
         _relegatedPlayers = §§pop();
         var _loc48_:String = "NextLeague";
         var _loc18_:* = row;
         if(!_loc18_._cache[_loc48_])
         {
            _loc18_._cache[_loc48_] = com.dchoc.utils.DCUtils.find(_loc18_._fields,"name",_loc48_);
         }
         if(_loc18_._cache[_loc48_])
         {
            var _loc49_:String = "NextLeague";
            var _loc19_:* = row;
            if(!_loc19_._cache[_loc49_])
            {
               _loc19_._cache[_loc49_] = com.dchoc.utils.DCUtils.find(_loc19_._fields,"name",_loc49_);
            }
            var _loc20_:* = _loc19_._cache[_loc49_];
            tempRow = _loc20_.overrideValue != null ? _loc20_.overrideValue : _loc20_._value;
            _nextLeague = tempRow.id;
         }
         var _loc50_:String = "PreviousLeague";
         var _loc21_:* = row;
         if(!_loc21_._cache[_loc50_])
         {
            _loc21_._cache[_loc50_] = com.dchoc.utils.DCUtils.find(_loc21_._fields,"name",_loc50_);
         }
         if(_loc21_._cache[_loc50_])
         {
            var _loc51_:String = "PreviousLeague";
            var _loc22_:* = row;
            if(!_loc22_._cache[_loc51_])
            {
               _loc22_._cache[_loc51_] = com.dchoc.utils.DCUtils.find(_loc22_._fields,"name",_loc51_);
            }
            var _loc23_:* = _loc22_._cache[_loc51_];
            tempRow = _loc23_.overrideValue != null ? _loc23_.overrideValue : _loc23_._value;
            _previousLeague = tempRow.id;
         }
         var _loc52_:String = "FirstPositionReward";
         var _loc24_:* = row;
         if(!_loc24_._cache[_loc52_])
         {
            _loc24_._cache[_loc52_] = com.dchoc.utils.DCUtils.find(_loc24_._fields,"name",_loc52_);
         }
         if(_loc24_._cache[_loc52_])
         {
            var _loc53_:String = "FirstPositionReward";
            var _loc25_:* = row;
            if(!_loc25_._cache[_loc53_])
            {
               _loc25_._cache[_loc53_] = com.dchoc.utils.DCUtils.find(_loc25_._fields,"name",_loc53_);
            }
            var _loc26_:* = _loc25_._cache[_loc53_];
            §§push(_loc26_.overrideValue != null ? _loc26_.overrideValue : _loc26_._value);
         }
         else
         {
            §§push(null);
         }
         var positionRewardRow:Row = §§pop();
         _firstPositionReward = !!positionRewardRow ? positionRewardRow.id : null;
         var _loc54_:String = "SecondPositionReward";
         var _loc27_:* = row;
         if(!_loc27_._cache[_loc54_])
         {
            _loc27_._cache[_loc54_] = com.dchoc.utils.DCUtils.find(_loc27_._fields,"name",_loc54_);
         }
         if(_loc27_._cache[_loc54_])
         {
            var _loc55_:String = "SecondPositionReward";
            var _loc28_:* = row;
            if(!_loc28_._cache[_loc55_])
            {
               _loc28_._cache[_loc55_] = com.dchoc.utils.DCUtils.find(_loc28_._fields,"name",_loc55_);
            }
            var _loc29_:* = _loc28_._cache[_loc55_];
            §§push(_loc29_.overrideValue != null ? _loc29_.overrideValue : _loc29_._value);
         }
         else
         {
            §§push(null);
         }
         positionRewardRow = §§pop();
         _secondPositionReward = !!positionRewardRow ? positionRewardRow.id : null;
         var _loc56_:String = "ThirdPositionReward";
         var _loc30_:* = row;
         if(!_loc30_._cache[_loc56_])
         {
            _loc30_._cache[_loc56_] = com.dchoc.utils.DCUtils.find(_loc30_._fields,"name",_loc56_);
         }
         if(_loc30_._cache[_loc56_])
         {
            var _loc57_:String = "ThirdPositionReward";
            var _loc31_:* = row;
            if(!_loc31_._cache[_loc57_])
            {
               _loc31_._cache[_loc57_] = com.dchoc.utils.DCUtils.find(_loc31_._fields,"name",_loc57_);
            }
            var _loc32_:* = _loc31_._cache[_loc57_];
            §§push(_loc32_.overrideValue != null ? _loc32_.overrideValue : _loc32_._value);
         }
         else
         {
            §§push(null);
         }
         positionRewardRow = §§pop();
         _thirdPositionReward = !!positionRewardRow ? positionRewardRow.id : null;
         var _loc58_:String = "FourthPositionReward";
         var _loc33_:* = row;
         if(!_loc33_._cache[_loc58_])
         {
            _loc33_._cache[_loc58_] = com.dchoc.utils.DCUtils.find(_loc33_._fields,"name",_loc58_);
         }
         if(_loc33_._cache[_loc58_])
         {
            var _loc59_:String = "FourthPositionReward";
            var _loc34_:* = row;
            if(!_loc34_._cache[_loc59_])
            {
               _loc34_._cache[_loc59_] = com.dchoc.utils.DCUtils.find(_loc34_._fields,"name",_loc59_);
            }
            var _loc35_:* = _loc34_._cache[_loc59_];
            §§push(_loc35_.overrideValue != null ? _loc35_.overrideValue : _loc35_._value);
         }
         else
         {
            §§push(null);
         }
         positionRewardRow = §§pop();
         _fourthPositionReward = !!positionRewardRow ? positionRewardRow.id : null;
         var _loc60_:String = "PointReward";
         var _loc36_:* = row;
         if(!_loc36_._cache[_loc60_])
         {
            _loc36_._cache[_loc60_] = com.dchoc.utils.DCUtils.find(_loc36_._fields,"name",_loc60_);
         }
         var _loc37_:* = _loc36_._cache[_loc60_];
         _pointReward = _loc37_.overrideValue != null ? _loc37_.overrideValue : _loc37_._value;
         var _loc61_:String = "PointRewardMultiplier";
         var _loc38_:* = row;
         if(!_loc38_._cache[_loc61_])
         {
            _loc38_._cache[_loc61_] = com.dchoc.utils.DCUtils.find(_loc38_._fields,"name",_loc61_);
         }
         var _loc39_:* = _loc38_._cache[_loc61_];
         _pointRewardMultiplier = _loc39_.overrideValue != null ? _loc39_.overrideValue : _loc39_._value;
      }
      
      public function get sortPriority() : int
      {
         return _sortPriority;
      }
      
      public function get pointRewardMultiplier() : int
      {
         return _pointRewardMultiplier;
      }
      
      public function get pointReward() : String
      {
         return _pointReward;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get name() : String
      {
         return ProjectManager.getText(_name);
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
      
      public function get nextLeague() : String
      {
         return _nextLeague;
      }
      
      public function get previousLeague() : String
      {
         return _previousLeague;
      }
      
      public function get firstPositionReward() : String
      {
         return _firstPositionReward;
      }
      
      public function get secondPositionReward() : String
      {
         return _secondPositionReward;
      }
      
      public function get thirdPositionReward() : String
      {
         return _thirdPositionReward;
      }
      
      public function get fourthPositionReward() : String
      {
         return _fourthPositionReward;
      }
   }
}

