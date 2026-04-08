package tuxwars.data.practice
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   
   public class PracticeLevels
   {
      private static const TABLE:String = "PracticeLevel";
      
      public function PracticeLevels()
      {
         super();
      }
      
      public static function getRandomLevel() : PracticeLevel
      {
         return new PracticeLevel(getRow(getRandomRowIndex()));
      }
      
      public static function getLevel(param1:String) : PracticeLevel
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
         return new PracticeLevel(_loc2_.getCache[param1]);
      }
      
      private static function getRandomRowIndex() : int
      {
         var _loc1_:Table = getTable();
         return Random.integer(0,_loc1_._rows.length - 1);
      }
      
      private static function getRow(param1:int) : Row
      {
         var _loc2_:Table = getTable();
         assert("Row index out of bounds.",true,param1 >= 0 && param1 < _loc2_.rows.length);
         return _loc2_.rows[param1];
      }
      
      private static function getTable() : Table
      {
         return ProjectManager.findTable(TABLE);
      }
   }
}

