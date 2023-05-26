package tuxwars.data
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   
   public class FeedDatas
   {
      
      private static const TABLE_NAME:String = "Feed";
      
      private static var table:Table;
       
      
      public function FeedDatas()
      {
         super();
         throw new Error("FeedDatas is a static class!");
      }
      
      public static function findFeedData(id:String) : FeedData
      {
         var _loc3_:* = id;
         var _loc2_:* = getTable();
         §§push(§§findproperty(FeedData));
         if(!_loc2_._cache[_loc3_])
         {
            var _loc4_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id",_loc3_);
            if(!_loc4_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_._cache[_loc3_] = _loc4_;
         }
         return new §§pop().FeedData(_loc2_._cache[_loc3_]);
      }
      
      public static function getFeedDatas() : Array
      {
         var _loc1_:* = getTable();
         return _loc1_._rows;
      }
      
      private static function getTable() : Table
      {
         if(!table)
         {
            var _loc1_:ProjectManager = ProjectManager;
            table = com.dchoc.projectdata.ProjectManager.projectData.findTable("Feed");
         }
         return table;
      }
   }
}
