package tuxwars.data.challenges
{
   import com.dchoc.data.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.DCUtils;
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
      
      public function ChallengeData(param1:Row)
      {
         super(param1);
      }
      
      public function get type() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Type";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get scope() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Scope";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get targetValues() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "TargetValues";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : [];
      }
      
      public function get counters() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Counters";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : [];
      }
      
      public function get nextChallengeIds() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "NextChallengeIds";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : [];
      }
      
      public function get rewardCash() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "RewardCash";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get rewardCoins() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "RewardCoins";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get rewardExp() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "RewardExp";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get description() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Description_TID";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, ProjectManager.getText(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
      
      public function get category() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Category_TID";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, ProjectManager.getText(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
      
      public function get icon() : GraphicsReference
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Icon";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, new GraphicsReference(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
      
      public function get iconMC() : MovieClip
      {
         var _loc1_:GraphicsReference = this.icon;
         return DCResourceManager.instance.getFromSWF(_loc1_.swf,_loc1_.export);
      }
      
      public function get params() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Params";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
   }
}

