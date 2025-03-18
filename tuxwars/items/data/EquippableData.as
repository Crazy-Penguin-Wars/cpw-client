package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.battle.data.follower.Followers;
   import tuxwars.data.TuxGameData;
   import tuxwars.items.references.StatBonusReference;
   
   public class EquippableData extends TuxGameData
   {
      private static const DESCRIPTION:String = "Description";
      
      private static const TYPE:String = "Type";
      
      private static const SORT_PRIORITY:String = "SortPriority";
      
      private static const SLOT:String = "Slot";
      
      private static const STAT_BONUSES:String = "StatBonuses";
      
      private static const FOLLOWERS:String = "Followers";
      
      public function EquippableData(row:Row)
      {
         super(row);
      }
      
      public function get description() : String
      {
         var _loc4_:String = "Description";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get type() : String
      {
         var _loc4_:String = "Type";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get sortPriority() : int
      {
         var _loc4_:String = "SortPriority";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get slot() : String
      {
         var _loc4_:String = "Slot";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get statBonuses() : StatBonusReference
      {
         var _loc4_:String = "StatBonuses";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new StatBonusReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value,type)) : null;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         var _loc4_:String = "Followers";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return Followers.getFollowersData(!!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null);
      }
   }
}

