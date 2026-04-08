package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
   public class LeaderboardPopUpPriorities
   {
      private static var _table:Table;
      
      private static const TABLE:String = "LeaderboardPopUpPriority";
      
      private static const PRIORITY:String = "Priority";
      
      public function LeaderboardPopUpPriorities()
      {
         super();
         throw new Error("LeaderboardPopUpPriorities is a static class!");
      }
      
      public static function compare(param1:String, param2:String) : int
      {
         return findPriority(param1) - findPriority(param2);
      }
      
      private static function findPriority(param1:String) : int
      {
         var _loc6_:Row = null;
         var _loc7_:String = null;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc2_:Field = null;
         if(!LeaderboardPopUpPriorities.table)
         {
            LeaderboardPopUpPriorities.table = ProjectManager.findTable("LeaderboardPopUpPriority");
         }
         var _loc3_:* = param1;
         var _loc4_:* = LeaderboardPopUpPriorities.table;
         if(!_loc4_.getCache[_loc3_])
         {
            _loc6_ = DCUtils.find(_loc4_.rows,"id",_loc3_);
            if(!_loc6_)
            {
               LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_.getCache[_loc3_] = _loc6_;
         }
         var _loc5_:Row = _loc4_.getCache[_loc3_];
         if(_loc5_)
         {
            _loc7_ = "Priority";
            _loc8_ = _loc5_;
            if(!_loc8_.getCache[_loc7_])
            {
               _loc8_.getCache[_loc7_] = DCUtils.find(_loc8_.getFields(),"name",_loc7_);
            }
            _loc2_ = _loc8_.getCache[_loc7_];
            _loc9_ = _loc2_;
            return !!_loc2_ ? (_loc9_.overrideValue != null ? int(_loc9_.overrideValue) : int(_loc9_._value)) : 2147483647;
         }
         return 2147483647;
      }
      
      private static function get table() : Table
      {
         var _loc1_:String = null;
         if(!_table)
         {
            _loc1_ = "LeaderboardPopUpPriority";
            _table = ProjectManager.findTable(_loc1_);
         }
         return _table;
      }
   }
}

