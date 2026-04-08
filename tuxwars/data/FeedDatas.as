package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class FeedDatas
   {
      private static var table:Table;
      
      private static const TABLE_NAME:String = "Feed";
      
      public function FeedDatas()
      {
         super();
         throw new Error("FeedDatas is a static class!");
      }
      
      public static function findFeedData(param1:String) : FeedData
      {
         var _loc3_:Row = null;
         var _loc2_:Table = getTable();
         if(!_loc2_.getCache[param1])
         {
            _loc3_ = DCUtils.find(_loc2_.rows,"id",param1);
            if(!_loc3_)
            {
               LogUtils.log("No row with name: \'" + param1 + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[param1] = _loc3_;
         }
         return new FeedData(_loc2_.getCache[param1]);
      }
      
      public static function getFeedDatas() : Array
      {
         var _loc1_:* = getTable();
         return _loc1_._rows;
      }
      
      private static function getTable() : Table
      {
         var _loc1_:String = null;
         if(!table)
         {
            _loc1_ = "Feed";
            table = ProjectManager.findTable(_loc1_);
         }
         return table;
      }
   }
}

