package tuxwars.data.challenges
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import tuxwars.data.TuxGameData;
   
   public class ChallengeData extends TuxGameData
   {
      
      private static const TYPE:String = "Type";
      
      private static const SCOPE:String = "Scope";
      
      private static const COUNTERS:String = "Counters";
      
      private static const TARGET_VALUES:String = "TargetValues";
      
      private static const NEXT_CHALLENGE_ID:String = "NextChallengeIds";
      
      private static const REWARD_CASH:String = "RewardCash";
      
      private static const REWARD_COINS:String = "RewardCoins";
      
      private static const REWARD_EXP:String = "RewardExp";
      
      private static const DESCRIPTION:String = "Description_TID";
      
      private static const CATEGORY:String = "Category_TID";
      
      private static const ICON:String = "Icon";
      
      private static const PARAMS:String = "Params";
       
      
      public function ChallengeData(row:Row)
      {
         super(row);
      }
      
      public function get type() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Type"])
         {
            _loc2_._cache["Type"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Type");
         }
         var _loc1_:Field = _loc2_._cache["Type"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get scope() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Scope"])
         {
            _loc2_._cache["Scope"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Scope");
         }
         var _loc1_:Field = _loc2_._cache["Scope"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get targetValues() : Array
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["TargetValues"])
         {
            _loc2_._cache["TargetValues"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","TargetValues");
         }
         var _loc1_:Field = _loc2_._cache["TargetValues"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : [];
      }
      
      public function get counters() : Array
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Counters"])
         {
            _loc2_._cache["Counters"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Counters");
         }
         var _loc1_:Field = _loc2_._cache["Counters"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : [];
      }
      
      public function get nextChallengeIds() : Array
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["NextChallengeIds"])
         {
            _loc2_._cache["NextChallengeIds"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","NextChallengeIds");
         }
         var _loc1_:Field = _loc2_._cache["NextChallengeIds"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : [];
      }
      
      public function get rewardCash() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["RewardCash"])
         {
            _loc2_._cache["RewardCash"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RewardCash");
         }
         var _loc1_:Field = _loc2_._cache["RewardCash"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get rewardCoins() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["RewardCoins"])
         {
            _loc2_._cache["RewardCoins"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RewardCoins");
         }
         var _loc1_:Field = _loc2_._cache["RewardCoins"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get rewardExp() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["RewardExp"])
         {
            _loc2_._cache["RewardExp"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RewardExp");
         }
         var _loc1_:Field = _loc2_._cache["RewardExp"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get description() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Description_TID"])
         {
            _loc2_._cache["Description_TID"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Description_TID");
         }
         var _loc1_:Field = _loc2_._cache["Description_TID"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get category() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Category_TID"])
         {
            _loc2_._cache["Category_TID"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Category_TID");
         }
         var _loc1_:Field = _loc2_._cache["Category_TID"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get icon() : GraphicsReference
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Icon"])
         {
            _loc2_._cache["Icon"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Icon");
         }
         var _loc1_:Field = _loc2_._cache["Icon"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new GraphicsReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get iconMC() : MovieClip
      {
         var _loc1_:GraphicsReference = icon;
         return DCResourceManager.instance.getFromSWF(_loc1_.swf,_loc1_.export);
      }
      
      public function get params() : Array
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Params"])
         {
            _loc2_._cache["Params"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Params");
         }
         var _loc1_:Field = _loc2_._cache["Params"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
   }
}
