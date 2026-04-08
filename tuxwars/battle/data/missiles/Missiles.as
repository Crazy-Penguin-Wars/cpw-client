package tuxwars.battle.data.missiles
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class Missiles
   {
      private static var missilesTable:Table;
      
      private static const MISSILEStable:String = "Missile";
      
      private static const MISSILES_CACHE:Object = {};
      
      public function Missiles()
      {
         super();
         throw new Error("Missiles is a static class!");
      }
      
      public static function getMissileData(param1:String) : MissileData
      {
         var _loc4_:Row = null;
         if(MISSILES_CACHE.hasOwnProperty(param1))
         {
            return MISSILES_CACHE[param1];
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
         var _loc3_:MissileData = new MissileData(_loc2_.getCache[param1]);
         MISSILES_CACHE[param1] = _loc3_;
         return _loc3_;
      }
      
      public static function getTable() : Table
      {
         var _loc1_:String = null;
         if(!missilesTable)
         {
            _loc1_ = "Missile";
            missilesTable = ProjectManager.findTable(_loc1_);
         }
         return missilesTable;
      }
   }
}

