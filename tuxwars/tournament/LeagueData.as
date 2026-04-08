package tuxwars.tournament
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   
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
      
      public function LeagueData(param1:Row)
      {
         var _loc45_:Row = null;
         var _loc46_:Row = null;
         var _loc2_:Row = null;
         super();
         assert("Row is null.",true,param1 != null);
         var _loc3_:String = "ID";
         var _loc4_:* = param1;
         if(!_loc4_.getCache[_loc3_])
         {
            _loc4_.getCache[_loc3_] = DCUtils.find(_loc4_.getFields(),"name",_loc3_);
         }
         var _loc5_:* = _loc4_.getCache[_loc3_];
         this._id = _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value;
         var _loc6_:String = "SortPriority";
         var _loc7_:* = param1;
         if(!_loc7_.getCache[_loc6_])
         {
            _loc7_.getCache[_loc6_] = DCUtils.find(_loc7_.getFields(),"name",_loc6_);
         }
         var _loc8_:* = _loc7_.getCache[_loc6_];
         this._sortPriority = _loc8_.overrideValue != null ? int(_loc8_.overrideValue) : int(_loc8_._value);
         var _loc9_:String = "Name";
         var _loc10_:* = param1;
         if(!_loc10_.getCache[_loc9_])
         {
            _loc10_.getCache[_loc9_] = DCUtils.find(_loc10_.getFields(),"name",_loc9_);
         }
         var _loc11_:* = _loc10_.getCache[_loc9_];
         this._name = _loc11_.overrideValue != null ? _loc11_.overrideValue : _loc11_._value;
         var _loc12_:String = "TrophyGraphic";
         var _loc13_:* = param1;
         if(!_loc13_.getCache[_loc12_])
         {
            _loc13_.getCache[_loc12_] = DCUtils.find(_loc13_.getFields(),"name",_loc12_);
         }
         var _loc14_:* = _loc13_.getCache[_loc12_];
         this._trophyGraphic = _loc14_.overrideValue != null ? _loc14_.overrideValue : _loc14_._value;
         var _loc15_:String = "PromotedPlayers";
         var _loc16_:* = param1;
         if(!_loc16_.getCache[_loc15_])
         {
            _loc16_.getCache[_loc15_] = DCUtils.find(_loc16_.getFields(),"name",_loc15_);
         }
         var _loc17_:Field = null;
         if(!param1.getCache["PromotedPlayers"])
         {
            param1.getCache["PromotedPlayers"] = DCUtils.find(param1.getFields(),"name","PromotedPlayers");
         }
         _loc17_ = param1.getCache["PromotedPlayers"];
         this._promotedPlayers = !!_loc17_ ? int(_loc17_.overrideValue != null ? _loc17_.overrideValue : _loc17_._value) : 0;
         var _loc18_:String = "RelegatedPlayers";
         var _loc19_:* = param1;
         if(!_loc19_.getCache[_loc18_])
         {
            _loc19_.getCache[_loc18_] = DCUtils.find(_loc19_.getFields(),"name",_loc18_);
         }
         var _loc20_:Field = null;
         if(!param1.getCache["RelegatedPlayers"])
         {
            param1.getCache["RelegatedPlayers"] = DCUtils.find(param1.getFields(),"name","RelegatedPlayers");
         }
         _loc20_ = param1.getCache["RelegatedPlayers"];
         this._relegatedPlayers = !!_loc20_ ? int(_loc20_.overrideValue != null ? _loc20_.overrideValue : _loc20_._value) : 0;
         var _loc21_:String = "NextLeague";
         var _loc22_:* = param1;
         if(!_loc22_.getCache[_loc21_])
         {
            _loc22_.getCache[_loc21_] = DCUtils.find(_loc22_.getFields(),"name",_loc21_);
         }
         var _loc23_:Field = param1.getCache["NextLeague"];
         if(_loc23_)
         {
            _loc45_ = _loc23_.overrideValue != null ? _loc23_.overrideValue : _loc23_._value;
            this._nextLeague = !!_loc45_ ? _loc45_.id : null;
         }
         var _loc24_:String = "PreviousLeague";
         var _loc25_:* = param1;
         if(!_loc25_.getCache[_loc24_])
         {
            _loc25_.getCache[_loc24_] = DCUtils.find(_loc25_.getFields(),"name",_loc24_);
         }
         var _loc26_:Field = param1.getCache["PreviousLeague"];
         if(_loc26_)
         {
            _loc46_ = _loc26_.overrideValue != null ? _loc26_.overrideValue : _loc26_._value;
            this._previousLeague = !!_loc46_ ? _loc46_.id : null;
         }
         var _loc27_:String = "FirstPositionReward";
         var _loc28_:* = param1;
         if(!_loc28_.getCache[_loc27_])
         {
            _loc28_.getCache[_loc27_] = DCUtils.find(_loc28_.getFields(),"name",_loc27_);
         }
         var _loc29_:Field = param1.getCache["FirstPositionReward"];
         positionRewardRow = !!_loc29_ ? (_loc29_.overrideValue != null ? _loc29_.overrideValue : _loc29_._value) : null;
         this._firstPositionReward = !!positionRewardRow ? positionRewardRow.id : null;
         var _loc30_:String = "SecondPositionReward";
         var _loc31_:* = param1;
         if(!_loc31_.getCache[_loc30_])
         {
            _loc31_.getCache[_loc30_] = DCUtils.find(_loc31_.getFields(),"name",_loc30_);
         }
         var _loc32_:Field = param1.getCache["SecondPositionReward"];
         positionRewardRow = !!_loc32_ ? (_loc32_.overrideValue != null ? _loc32_.overrideValue : _loc32_._value) : null;
         this._secondPositionReward = !!positionRewardRow ? positionRewardRow.id : null;
         var _loc33_:String = "ThirdPositionReward";
         var _loc34_:* = param1;
         if(!_loc34_.getCache[_loc33_])
         {
            _loc34_.getCache[_loc33_] = DCUtils.find(_loc34_.getFields(),"name",_loc33_);
         }
         var _loc35_:Field = param1.getCache["ThirdPositionReward"];
         positionRewardRow = !!_loc35_ ? (_loc35_.overrideValue != null ? _loc35_.overrideValue : _loc35_._value) : null;
         this._thirdPositionReward = !!positionRewardRow ? positionRewardRow.id : null;
         var _loc36_:String = "FourthPositionReward";
         var _loc37_:* = param1;
         if(!_loc37_.getCache[_loc36_])
         {
            _loc37_.getCache[_loc36_] = DCUtils.find(_loc37_.getFields(),"name",_loc36_);
         }
         var _loc38_:Field = param1.getCache["FourthPositionReward"];
         positionRewardRow = !!_loc38_ ? (_loc38_.overrideValue != null ? _loc38_.overrideValue : _loc38_._value) : null;
         this._fourthPositionReward = !!positionRewardRow ? positionRewardRow.id : null;
         var _loc39_:String = "PointReward";
         var _loc40_:* = param1;
         if(!_loc40_.getCache[_loc39_])
         {
            _loc40_.getCache[_loc39_] = DCUtils.find(_loc40_.getFields(),"name","PointReward");
         }
         var _loc41_:Field = param1.getCache["PointReward"];
         this._pointReward = !!_loc41_ ? (_loc41_.overrideValue != null ? _loc41_.overrideValue : _loc41_._value) : null;
         var _loc42_:String = "PointRewardMultiplier";
         var _loc43_:* = param1;
         if(!_loc43_.getCache[_loc42_])
         {
            _loc43_.getCache[_loc42_] = DCUtils.find(_loc43_.getFields(),"name","PointRewardMultiplier");
         }
         var _loc44_:Field = param1.getCache["PointRewardMultiplier"];
         this._pointRewardMultiplier = !!_loc44_ ? int(_loc44_.overrideValue != null ? _loc44_.overrideValue : _loc44_._value) : 0;
      }
      
      public function get sortPriority() : int
      {
         return this._sortPriority;
      }
      
      public function get pointRewardMultiplier() : int
      {
         return this._pointRewardMultiplier;
      }
      
      public function get pointReward() : String
      {
         return this._pointReward;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return ProjectManager.getText(this._name);
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
      
      public function get nextLeague() : String
      {
         return this._nextLeague;
      }
      
      public function get previousLeague() : String
      {
         return this._previousLeague;
      }
      
      public function get firstPositionReward() : String
      {
         return this._firstPositionReward;
      }
      
      public function get secondPositionReward() : String
      {
         return this._secondPositionReward;
      }
      
      public function get thirdPositionReward() : String
      {
         return this._thirdPositionReward;
      }
      
      public function get fourthPositionReward() : String
      {
         return this._fourthPositionReward;
      }
   }
}

