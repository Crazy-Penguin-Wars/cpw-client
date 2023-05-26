package tuxwars.battle.data
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import com.dchoc.utils.DCUtils;
   
   public class Levels
   {
      
      private static const TABLE_NAME:String = "Level";
      
      private static const LEVELS:Vector.<LevelData> = new Vector.<LevelData>();
       
      
      public function Levels()
      {
         super();
         throw new Error("Levels is a static class!");
      }
      
      public static function findLevelData(levelName:String) : LevelData
      {
         return DCUtils.find(getLevels(),"id",levelName);
      }
      
      public static function getLevels() : Vector.<LevelData>
      {
         if(LEVELS.length == 0)
         {
            createLevels();
            sortById();
            sortByMinLevel();
         }
         return LEVELS;
      }
      
      private static function sortById() : void
      {
         LEVELS.sort(function(level1:LevelData, level2:LevelData):int
         {
            return level1.id.localeCompare(level2.id);
         });
      }
      
      private static function sortByMinLevel() : void
      {
         LEVELS.sort(function(level1:LevelData, level2:LevelData):int
         {
            return level1.minLevel - level2.minLevel;
         });
      }
      
      private static function createLevels() : void
      {
         var _loc1_:Table = getTable();
         var _loc3_:* = _loc1_;
         for each(var row in _loc3_._rows)
         {
            LEVELS.push(new LevelData(row));
         }
      }
      
      private static function getTable() : Table
      {
         var _loc1_:ProjectManager = ProjectManager;
         return com.dchoc.projectdata.ProjectManager.projectData.findTable("Level");
      }
      
      private static function getRow(rowName:String) : Row
      {
         var _loc3_:* = rowName;
         var _loc2_:* = getTable();
         if(!_loc2_._cache[_loc3_])
         {
            var _loc4_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id",_loc3_);
            if(!_loc4_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_._cache[_loc3_] = _loc4_;
         }
         return _loc2_._cache[_loc3_];
      }
   }
}
