package tuxwars.battle.data.levelobjects
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   
   public class LevelObjects
   {
      
      private static const TABLE_NAME:String = "LevelObject";
       
      
      public function LevelObjects()
      {
         super();
         throw new Error("LevelObjects is a static class!");
      }
      
      public static function findLevelObjectData(name:String) : LevelObjectData
      {
         var row:Row = getRow(name);
         if(row)
         {
            return new LevelObjectData(row);
         }
         MessageCenter.sendEvent(new ErrorMessage("Row Error",name,"Row named " + name + " was not found",name,new Error()));
         return null;
      }
      
      private static function getRow(rowName:String) : Row
      {
         var _loc2_:ProjectManager = ProjectManager;
         var _loc5_:* = rowName;
         var _loc3_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("LevelObject");
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
