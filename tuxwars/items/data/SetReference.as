package tuxwars.items.data
{
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.battle.data.follower.*;
   import tuxwars.items.*;
   import tuxwars.items.references.*;
   
   public class SetReference
   {
      private static const STAT_BONUSES:String = "StatBonuses";
      
      private static const SPECIAL:String = "Special";
      
      private static const FOLLOWERS:String = "Followers";
      
      private static const STAT_BONUS_DESC_TEXT_OVERRIDE:String = "StatBonusDescTextOverride";
      
      private var _row:Row;
      
      private var _statBonuses:Stats;
      
      public function SetReference(param1:Row)
      {
         super();
         this._row = param1;
      }
      
      public function get id() : String
      {
         return this._row.id;
      }
      
      public function get statBonusDescTextOverride() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "StatBonusDescTextOverride";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, ProjectManager.getText(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : "";
      }
      
      public function get statBonuses() : Stats
      {
         var _loc3_:String = null;
         var _loc4_:Row = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc1_:Field = null;
         var _loc2_:StatBonusReference = null;
         if(!this._statBonuses)
         {
            _loc3_ = "StatBonuses";
            _loc4_ = this._row;
            if(!_loc4_.getCache[_loc3_])
            {
               _loc4_.getCache[_loc3_] = DCUtils.find(_loc4_.getFields(),"name",_loc3_);
            }
            _loc1_ = _loc4_.getCache[_loc3_];
            if(_loc1_)
            {
               _loc5_ = _loc1_;
               _loc2_ = new StatBonusReference(_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value,"ClothingSet");
               if(_loc2_ != null)
               {
                  this._statBonuses = new Stats();
                  for each(_loc6_ in Equippable.EQUIPPABLE_BONUS_STATS)
                  {
                     if(_loc2_.getStat(_loc6_))
                     {
                        this._statBonuses.setStat(_loc6_,_loc2_.getStat(_loc6_));
                     }
                  }
               }
            }
         }
         return this._statBonuses;
      }
      
      public function get special() : SpecialReference
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Special";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, new SpecialReference(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Followers";
         var _loc2_:Row = this._row;
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

