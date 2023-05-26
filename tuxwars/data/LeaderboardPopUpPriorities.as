package tuxwars.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   
   public class LeaderboardPopUpPriorities
   {
      
      private static const TABLE:String = "LeaderboardPopUpPriority";
      
      private static const PRIORITY:String = "Priority";
      
      private static var _table:Table;
       
      
      public function LeaderboardPopUpPriorities()
      {
         super();
         throw new Error("LeaderboardPopUpPriorities is a static class!");
      }
      
      public static function compare(stat1:String, stat2:String) : int
      {
         return findPriority(stat1) - findPriority(stat2);
      }
      
      private static function findPriority(stat:String) : int
      {
         var _loc2_:* = null;
         if(!tuxwars.data.LeaderboardPopUpPriorities._table)
         {
            tuxwars.data.LeaderboardPopUpPriorities._table = com.dchoc.projectdata.ProjectManager.findTable("LeaderboardPopUpPriority");
         }
         var _loc7_:* = stat;
         var _loc4_:* = tuxwars.data.LeaderboardPopUpPriorities._table;
         if(!_loc4_._cache[_loc7_])
         {
            var _loc8_:Row = com.dchoc.utils.DCUtils.find(_loc4_.rows,"id",_loc7_);
            if(!_loc8_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc7_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_._cache[_loc7_] = _loc8_;
         }
         var _loc3_:Row = _loc4_._cache[_loc7_];
         if(_loc3_)
         {
            var _loc5_:* = _loc3_;
            if(!_loc5_._cache["Priority"])
            {
               _loc5_._cache["Priority"] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name","Priority");
            }
            _loc2_ = _loc5_._cache["Priority"];
            var _loc6_:*;
            return !!_loc2_ ? (_loc6_ = _loc2_, _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : 2147483647;
         }
         return 2147483647;
      }
      
      private static function get table() : Table
      {
         if(!_table)
         {
            var _loc1_:ProjectManager = ProjectManager;
            _table = com.dchoc.projectdata.ProjectManager.projectData.findTable("LeaderboardPopUpPriority");
         }
         return _table;
      }
   }
}
