package tuxwars.items.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
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
         var _loc2_:Row = row;
         if(!_loc2_._cache["Description"])
         {
            _loc2_._cache["Description"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Description");
         }
         var _loc1_:Field = _loc2_._cache["Description"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
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
      
      public function get sortPriority() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["SortPriority"])
         {
            _loc2_._cache["SortPriority"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","SortPriority");
         }
         var _loc1_:Field = _loc2_._cache["SortPriority"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get slot() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Slot"])
         {
            _loc2_._cache["Slot"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Slot");
         }
         var _loc1_:Field = _loc2_._cache["Slot"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get statBonuses() : StatBonusReference
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["StatBonuses"])
         {
            _loc2_._cache["StatBonuses"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","StatBonuses");
         }
         var _loc1_:Field = _loc2_._cache["StatBonuses"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new StatBonusReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value,type)) : null;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         var _loc2_:Row = row;
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
