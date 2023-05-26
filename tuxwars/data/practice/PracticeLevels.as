package tuxwars.data.practice
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import com.dchoc.utils.Random;
   
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
      
      public static function getLevel(id:String) : PracticeLevel
      {
         var _loc3_:* = id;
         var _loc2_:* = getTable();
         §§push(§§findproperty(PracticeLevel));
         if(!_loc2_._cache[_loc3_])
         {
            var _loc4_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id",_loc3_);
            if(!_loc4_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_._cache[_loc3_] = _loc4_;
         }
         return new §§pop().PracticeLevel(_loc2_._cache[_loc3_]);
      }
      
      private static function getRandomRowIndex() : int
      {
         var _loc1_:* = getTable();
         return Random.integer(0,_loc1_._rows.length - 1);
      }
      
      private static function getRow(index:int) : Row
      {
         var _loc3_:* = index;
         var _loc2_:* = getTable();
         no.olog.utilfunctions.assert("Row index out of bounds.",true,_loc3_ >= 0 && _loc3_ < _loc2_.rows.length);
         return _loc2_.rows[_loc3_];
      }
      
      private static function getTable() : Table
      {
         var _loc1_:ProjectManager = ProjectManager;
         return com.dchoc.projectdata.ProjectManager.projectData.findTable("PracticeLevel");
      }
   }
}
