package tuxwars.battle.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class Levels
   {
      private static const TABLE_NAME:String = "Level";
      
      private static const LEVELS:Vector.<LevelData> = new Vector.<LevelData>();
      
      public function Levels()
      {
         super();
         throw new Error("Levels is a static class!");
      }
      
      public static function findLevelData(param1:String) : LevelData
      {
         return DCUtils.find(getLevels(),"id",param1);
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
         LEVELS.sort(function(param1:LevelData, param2:LevelData):int
         {
            return param1.id.localeCompare(param2.id);
         });
      }
      
      private static function sortByMinLevel() : void
      {
         LEVELS.sort(function(param1:LevelData, param2:LevelData):int
         {
            return param1.minLevel - param2.minLevel;
         });
      }
      
      private static function createLevels() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:Table = getTable();
         var _loc2_:* = _loc1_;
         for each(_loc3_ in _loc2_._rows)
         {
            LEVELS.push(new LevelData(_loc3_));
         }
      }
      
      private static function getTable() : Table
      {
         var _loc1_:String = "Level";
         return ProjectManager.findTable(_loc1_);
      }
      
      private static function getRow(param1:String) : Row
      {
         var _loc4_:Row = null;
         var _loc2_:* = param1;
         var _loc3_:* = getTable();
         if(!_loc3_.getCache[_loc2_])
         {
            _loc4_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
            if(!_loc4_)
            {
               LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc2_] = _loc4_;
         }
         return _loc3_.getCache[_loc2_];
      }
   }
}

