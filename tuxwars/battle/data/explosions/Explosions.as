package tuxwars.battle.data.explosions
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   
   public class Explosions
   {
      
      private static const EXPLOSION_TABLE:String = "Explosion";
      
      private static const EXPLOSION_CACHE:Object = {};
      
      private static var explosionTable:Table;
       
      
      public function Explosions()
      {
         super();
         throw new Error("Explosions is a static class!");
      }
      
      public static function getExplosionData(name:String) : ExplosionData
      {
         if(EXPLOSION_CACHE.hasOwnProperty(name))
         {
            return EXPLOSION_CACHE[name];
         }
         var _loc4_:* = name;
         var _loc3_:* = getTable();
         §§push(§§findproperty(ExplosionData));
         if(!_loc3_._cache[_loc4_])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc4_);
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_._cache[_loc4_] = _loc5_;
         }
         var _loc2_:ExplosionData = new §§pop().ExplosionData(_loc3_._cache[_loc4_]);
         EXPLOSION_CACHE[name] = _loc2_;
         return _loc2_;
      }
      
      public static function getTable() : Table
      {
         if(!explosionTable)
         {
            var _loc1_:ProjectManager = ProjectManager;
            explosionTable = com.dchoc.projectdata.ProjectManager.projectData.findTable("Explosion");
         }
         return explosionTable;
      }
   }
}
