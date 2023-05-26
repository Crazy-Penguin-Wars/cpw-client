package tuxwars.items.data
{
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
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
         var _loc2_:Row = _row;
         if(!_loc2_._cache["StatBonusDescTextOverride"])
         {
            _loc2_._cache["StatBonusDescTextOverride"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","StatBonusDescTextOverride");
         }
         var _loc1_:Field = _loc2_._cache["StatBonusDescTextOverride"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : "";
      }
      
      public function get statBonuses() : Stats
      {
         var _loc1_:* = null;
         var bonusReference:* = null;
         if(!_statBonuses)
         {
            var _loc4_:Row = _row;
            if(!_loc4_._cache["StatBonuses"])
            {
               _loc4_._cache["StatBonuses"] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name","StatBonuses");
            }
            _loc1_ = _loc4_._cache["StatBonuses"];
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
         var _loc2_:Row = _row;
         if(!_loc2_._cache["Special"])
         {
            _loc2_._cache["Special"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Special");
         }
         var _loc1_:Field = _loc2_._cache["Special"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new SpecialReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         var _loc2_:Row = _row;
         if(!_loc2_._cache["Followers"])
         {
            _loc2_._cache["Followers"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Followers");
         }
         var _loc1_:Field = _loc2_._cache["Followers"];
         var _loc3_:*;
         return Followers.getFollowersData(!!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null);
      }
   }
}
