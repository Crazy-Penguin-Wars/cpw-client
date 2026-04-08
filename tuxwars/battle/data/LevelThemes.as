package tuxwars.battle.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
   public class LevelThemes
   {
      private static const TABLE_NAME:String = "LevelTheme";
      
      public function LevelThemes()
      {
         super();
         throw new Error("LevelThemes is a static class!");
      }
      
      public static function findTheme(param1:String) : LevelTheme
      {
         var _loc2_:Row = getRow(param1);
         return !!_loc2_ ? new LevelTheme(_loc2_) : null;
      }
      
      private static function getRow(param1:String) : Row
      {
         var _loc5_:Row = null;
         var _loc2_:String = "LevelTheme";
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

