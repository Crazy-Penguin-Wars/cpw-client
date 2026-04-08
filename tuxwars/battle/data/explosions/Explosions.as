package tuxwars.battle.data.explosions
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class Explosions
   {
      private static var explosionTable:Table;
      
      private static const EXPLOSIONtable:String = "Explosion";
      
      private static const EXPLOSION_CACHE:Object = {};
      
      public function Explosions()
      {
         super();
         throw new Error("Explosions is a static class!");
      }
      
      public static function getExplosionData(param1:String) : ExplosionData
      {
         var _loc4_:Row = null;
         if(EXPLOSION_CACHE.hasOwnProperty(param1))
         {
            return EXPLOSION_CACHE[param1];
         }
         var _loc2_:Table = getTable();
         if(!_loc2_.getCache[param1])
         {
            _loc4_ = DCUtils.find(_loc2_.rows,"id",param1);
            if(!_loc4_)
            {
               LogUtils.log("No row with name: \'" + param1 + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[param1] = _loc4_;
         }
         var _loc3_:ExplosionData = new ExplosionData(_loc2_.getCache[param1]);
         EXPLOSION_CACHE[param1] = _loc3_;
         return _loc3_;
      }
      
      public static function getTable() : Table
      {
         var _loc1_:String = null;
         if(!explosionTable)
         {
            _loc1_ = "Explosion";
            explosionTable = ProjectManager.findTable(_loc1_);
         }
         return explosionTable;
      }
   }
}

