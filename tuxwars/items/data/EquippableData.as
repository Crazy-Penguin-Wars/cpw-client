package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.battle.data.follower.*;
   import tuxwars.data.TuxGameData;
   import tuxwars.items.references.*;
   
   public class EquippableData extends TuxGameData
   {
      private static const DESCRIPTION:String = "Description";
      
      private static const TYPE:String = "Type";
      
      private static const SORT_PRIORITY:String = "SortPriority";
      
      private static const SLOT:String = "Slot";
      
      private static const STAT_BONUSES:String = "StatBonuses";
      
      private static const FOLLOWERS:String = "Followers";
      
      public function EquippableData(param1:Row)
      {
         super(param1);
      }
      
      public function get description() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Description";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, ProjectManager.getText(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
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
      
      public function get sortPriority() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "SortPriority";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get slot() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Slot";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get statBonuses() : StatBonusReference
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "StatBonuses";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, new StatBonusReference(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value,this.type)) : null;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Followers";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return Followers.getFollowersData(!!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null);
      }
   }
}

