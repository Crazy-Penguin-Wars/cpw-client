package tuxwars.tournament
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
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
         var tempRow:* = null;
         super();
         assert("Row is null.",true,row != null);
         var _loc4_:* = row;
         if(!_loc4_._cache["ID"])
         {
            _loc4_._cache["ID"] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name","ID");
         }
         var _loc5_:* = _loc4_._cache["ID"];
         _id = _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value;
         var _loc6_:* = row;
         if(!_loc6_._cache["SortPriority"])
         {
            _loc6_._cache["SortPriority"] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name","SortPriority");
         }
         var _loc7_:* = _loc6_._cache["SortPriority"];
         _sortPriority = _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value;
         var _loc8_:* = row;
         if(!_loc8_._cache["Name"])
         {
            _loc8_._cache["Name"] = com.dchoc.utils.DCUtils.find(_loc8_._fields,"name","Name");
         }
         var _loc9_:* = _loc8_._cache["Name"];
         _name = _loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value;
         var _loc10_:* = row;
         if(!_loc10_._cache["TrophyGraphic"])
         {
            _loc10_._cache["TrophyGraphic"] = com.dchoc.utils.DCUtils.find(_loc10_._fields,"name","TrophyGraphic");
         }
         var _loc11_:* = _loc10_._cache["TrophyGraphic"];
         _trophyGraphic = _loc11_.overrideValue != null ? _loc11_.overrideValue : _loc11_._value;
         var _loc12_:* = row;
         if(!_loc12_._cache["PromotedPlayers"])
         {
            _loc12_._cache["PromotedPlayers"] = com.dchoc.utils.DCUtils.find(_loc12_._fields,"name","PromotedPlayers");
         }
         if(_loc12_._cache["PromotedPlayers"])
         {
            var _loc13_:* = row;
            if(!_loc13_._cache["PromotedPlayers"])
            {
               _loc13_._cache["PromotedPlayers"] = com.dchoc.utils.DCUtils.find(_loc13_._fields,"name","PromotedPlayers");
            }
            var _loc14_:* = _loc13_._cache["PromotedPlayers"];
            §§push(_loc14_.overrideValue != null ? _loc14_.overrideValue : _loc14_._value);
         }
         else
         {
            §§push(0);
         }
         _promotedPlayers = §§pop();
         var _loc15_:* = row;
         if(!_loc15_._cache["RelegatedPlayers"])
         {
            _loc15_._cache["RelegatedPlayers"] = com.dchoc.utils.DCUtils.find(_loc15_._fields,"name","RelegatedPlayers");
         }
         if(_loc15_._cache["RelegatedPlayers"])
         {
            var _loc16_:* = row;
            if(!_loc16_._cache["RelegatedPlayers"])
            {
               _loc16_._cache["RelegatedPlayers"] = com.dchoc.utils.DCUtils.find(_loc16_._fields,"name","RelegatedPlayers");
            }
            var _loc17_:* = _loc16_._cache["RelegatedPlayers"];
            §§push(_loc17_.overrideValue != null ? _loc17_.overrideValue : _loc17_._value);
         }
         else
         {
            §§push(0);
         }
         _relegatedPlayers = §§pop();
         var _loc18_:* = row;
         if(!_loc18_._cache["NextLeague"])
         {
            _loc18_._cache["NextLeague"] = com.dchoc.utils.DCUtils.find(_loc18_._fields,"name","NextLeague");
         }
         if(_loc18_._cache["NextLeague"])
         {
            var _loc19_:* = row;
            if(!_loc19_._cache["NextLeague"])
            {
               _loc19_._cache["NextLeague"] = com.dchoc.utils.DCUtils.find(_loc19_._fields,"name","NextLeague");
            }
            var _loc20_:* = _loc19_._cache["NextLeague"];
            tempRow = _loc20_.overrideValue != null ? _loc20_.overrideValue : _loc20_._value;
            _nextLeague = tempRow.id;
         }
         var _loc21_:* = row;
         if(!_loc21_._cache["PreviousLeague"])
         {
            _loc21_._cache["PreviousLeague"] = com.dchoc.utils.DCUtils.find(_loc21_._fields,"name","PreviousLeague");
         }
         if(_loc21_._cache["PreviousLeague"])
         {
            var _loc22_:* = row;
            if(!_loc22_._cache["PreviousLeague"])
            {
               _loc22_._cache["PreviousLeague"] = com.dchoc.utils.DCUtils.find(_loc22_._fields,"name","PreviousLeague");
            }
            var _loc23_:* = _loc22_._cache["PreviousLeague"];
            tempRow = _loc23_.overrideValue != null ? _loc23_.overrideValue : _loc23_._value;
            _previousLeague = tempRow.id;
         }
         var _loc24_:* = row;
         if(!_loc24_._cache["FirstPositionReward"])
         {
            _loc24_._cache["FirstPositionReward"] = com.dchoc.utils.DCUtils.find(_loc24_._fields,"name","FirstPositionReward");
         }
         if(_loc24_._cache["FirstPositionReward"])
         {
            var _loc25_:* = row;
            if(!_loc25_._cache["FirstPositionReward"])
            {
               _loc25_._cache["FirstPositionReward"] = com.dchoc.utils.DCUtils.find(_loc25_._fields,"name","FirstPositionReward");
            }
            var _loc26_:* = _loc25_._cache["FirstPositionReward"];
            §§push(_loc26_.overrideValue != null ? _loc26_.overrideValue : _loc26_._value);
         }
         else
         {
            §§push(null);
         }
         var positionRewardRow:Row = §§pop();
         _firstPositionReward = !!positionRewardRow ? positionRewardRow.id : null;
         var _loc27_:* = row;
         if(!_loc27_._cache["SecondPositionReward"])
         {
            _loc27_._cache["SecondPositionReward"] = com.dchoc.utils.DCUtils.find(_loc27_._fields,"name","SecondPositionReward");
         }
         if(_loc27_._cache["SecondPositionReward"])
         {
            var _loc28_:* = row;
            if(!_loc28_._cache["SecondPositionReward"])
            {
               _loc28_._cache["SecondPositionReward"] = com.dchoc.utils.DCUtils.find(_loc28_._fields,"name","SecondPositionReward");
            }
            var _loc29_:* = _loc28_._cache["SecondPositionReward"];
            §§push(_loc29_.overrideValue != null ? _loc29_.overrideValue : _loc29_._value);
         }
         else
         {
            §§push(null);
         }
         positionRewardRow = §§pop();
         _secondPositionReward = !!positionRewardRow ? positionRewardRow.id : null;
         var _loc30_:* = row;
         if(!_loc30_._cache["ThirdPositionReward"])
         {
            _loc30_._cache["ThirdPositionReward"] = com.dchoc.utils.DCUtils.find(_loc30_._fields,"name","ThirdPositionReward");
         }
         if(_loc30_._cache["ThirdPositionReward"])
         {
            var _loc31_:* = row;
            if(!_loc31_._cache["ThirdPositionReward"])
            {
               _loc31_._cache["ThirdPositionReward"] = com.dchoc.utils.DCUtils.find(_loc31_._fields,"name","ThirdPositionReward");
            }
            var _loc32_:* = _loc31_._cache["ThirdPositionReward"];
            §§push(_loc32_.overrideValue != null ? _loc32_.overrideValue : _loc32_._value);
         }
         else
         {
            §§push(null);
         }
         positionRewardRow = §§pop();
         _thirdPositionReward = !!positionRewardRow ? positionRewardRow.id : null;
         var _loc33_:* = row;
         if(!_loc33_._cache["FourthPositionReward"])
         {
            _loc33_._cache["FourthPositionReward"] = com.dchoc.utils.DCUtils.find(_loc33_._fields,"name","FourthPositionReward");
         }
         if(_loc33_._cache["FourthPositionReward"])
         {
            var _loc34_:* = row;
            if(!_loc34_._cache["FourthPositionReward"])
            {
               _loc34_._cache["FourthPositionReward"] = com.dchoc.utils.DCUtils.find(_loc34_._fields,"name","FourthPositionReward");
            }
            var _loc35_:* = _loc34_._cache["FourthPositionReward"];
            §§push(_loc35_.overrideValue != null ? _loc35_.overrideValue : _loc35_._value);
         }
         else
         {
            §§push(null);
         }
         positionRewardRow = §§pop();
         _fourthPositionReward = !!positionRewardRow ? positionRewardRow.id : null;
         var _loc36_:* = row;
         if(!_loc36_._cache["PointReward"])
         {
            _loc36_._cache["PointReward"] = com.dchoc.utils.DCUtils.find(_loc36_._fields,"name","PointReward");
         }
         var _loc37_:* = _loc36_._cache["PointReward"];
         _pointReward = _loc37_.overrideValue != null ? _loc37_.overrideValue : _loc37_._value;
         var _loc38_:* = row;
         if(!_loc38_._cache["PointRewardMultiplier"])
         {
            _loc38_._cache["PointRewardMultiplier"] = com.dchoc.utils.DCUtils.find(_loc38_._fields,"name","PointRewardMultiplier");
         }
         var _loc39_:* = _loc38_._cache["PointRewardMultiplier"];
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
