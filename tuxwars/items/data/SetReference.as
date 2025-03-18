package tuxwars.items.data
{
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.battle.data.follower.Followers;
   import tuxwars.items.Equippable;
   import tuxwars.items.references.SpecialReference;
   import tuxwars.items.references.StatBonusReference;
   
   public class SetReference
   {
      private static const STAT_BONUSES:String = "StatBonuses";
      
      private static const SPECIAL:String = "Special";
      
      private static const FOLLOWERS:String = "Followers";
      
      private static const STAT_BONUS_DESC_TEXT_OVERRIDE:String = "StatBonusDescTextOverride";
      
      private var _row:Row;
      
      private var _statBonuses:Stats;
      
      public function SetReference(row:Row)
      {
         super();
         _row = row;
      }
      
      public function get id() : String
      {
         return _row.id;
      }
      
      public function get statBonusDescTextOverride() : String
      {
         var _loc4_:String = "StatBonusDescTextOverride";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : "";
      }
      
      public function get statBonuses() : Stats
      {
         var _loc1_:Field = null;
         var bonusReference:StatBonusReference = null;
         if(!_statBonuses)
         {
            var _loc8_:String = "StatBonuses";
            var _loc4_:Row = _row;
            if(!_loc4_._cache[_loc8_])
            {
               _loc4_._cache[_loc8_] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name",_loc8_);
            }
            _loc1_ = _loc4_._cache[_loc8_];
            if(_loc1_)
            {
               var _loc5_:* = _loc1_;
               bonusReference = new StatBonusReference(_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value,"ClothingSet");
               if(bonusReference != null)
               {
                  _statBonuses = new Stats();
                  for each(var s in Equippable.EQUIPPABLE_BONUS_STATS)
                  {
                     if(bonusReference.getStat(s))
                     {
                        _statBonuses.setStat(s,bonusReference.getStat(s));
                     }
                  }
               }
            }
         }
         return _statBonuses;
      }
      
      public function get special() : SpecialReference
      {
         var _loc4_:String = "Special";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new SpecialReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         var _loc4_:String = "Followers";
         var _loc2_:Row = _row;
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

