package tuxwars.battle.data.missiles
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   
   public class Missiles
   {
      
      private static const MISSILES_TABLE:String = "Missile";
      
      private static const MISSILES_CACHE:Object = {};
      
      private static var missilesTable:Table;
       
      
      public function Missiles()
      {
         super();
         throw new Error("Missiles is a static class!");
      }
      
      public static function getMissileData(name:String) : MissileData
      {
         if(MISSILES_CACHE.hasOwnProperty(name))
         {
            return MISSILES_CACHE[name];
         }
         var _loc4_:* = name;
         var _loc3_:* = getTable();
         §§push(§§findproperty(MissileData));
         if(!_loc3_._cache[_loc4_])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc4_);
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_._cache[_loc4_] = _loc5_;
         }
         var _loc2_:MissileData = new §§pop().MissileData(_loc3_._cache[_loc4_]);
         MISSILES_CACHE[name] = _loc2_;
         return _loc2_;
      }
      
      public static function getTable() : Table
      {
         if(!missilesTable)
         {
            var _loc1_:ProjectManager = ProjectManager;
            missilesTable = com.dchoc.projectdata.ProjectManager.projectData.findTable("Missile");
         }
         return missilesTable;
      }
   }
}
