package tuxwars.battle.data.levelobjects
{
   import com.dchoc.events.*;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
   public class LevelObjects
   {
      private static const TABLE_NAME:String = "LevelObject";
      
      public function LevelObjects()
      {
         super();
         throw new Error("LevelObjects is a static class!");
      }
      
      public static function findLevelObjectData(param1:String) : LevelObjectData
      {
         var _loc2_:Row = getRow(param1);
         if(_loc2_)
         {
            return new LevelObjectData(_loc2_);
         }
         MessageCenter.sendEvent(new ErrorMessage("Row Error",param1,"Row named " + param1 + " was not found",param1,new Error()));
         return null;
      }
      
      private static function getRow(param1:String) : Row
      {
         var _loc5_:Row = null;
         var _loc2_:String = "LevelObject";
         var _loc3_:* = param1;
         var _loc4_:* = ProjectManager.findTable(_loc2_);
         if(!_loc4_.getCache[_loc3_])
         {
            _loc5_ = DCUtils.find(_loc4_.rows,"id",_loc3_);
            if(!_loc5_)
            {
               LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_.getCache[_loc3_] = _loc5_;
         }
         return _loc4_.getCache[_loc3_];
      }
   }
}

