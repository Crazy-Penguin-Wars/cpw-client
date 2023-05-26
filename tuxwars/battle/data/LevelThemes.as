package tuxwars.battle.data
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   
   public class LevelThemes
   {
      
      private static const TABLE_NAME:String = "LevelTheme";
       
      
      public function LevelThemes()
      {
         super();
         throw new Error("LevelThemes is a static class!");
      }
      
      public static function findTheme(themeName:String) : LevelTheme
      {
         var _loc2_:Row = getRow(themeName);
         return !!_loc2_ ? new LevelTheme(_loc2_) : null;
      }
      
      private static function getRow(rowName:String) : Row
      {
         var _loc2_:ProjectManager = ProjectManager;
         var _loc5_:* = rowName;
         var _loc3_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("LevelTheme");
         if(!_loc3_._cache[_loc5_])
         {
            var _loc6_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc5_);
            if(!_loc6_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc5_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_._cache[_loc5_] = _loc6_;
         }
         return _loc3_._cache[_loc5_];
      }
   }
}
