package tuxwars.battle.data.animationEmissions
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   
   public class AnimationEmissions
   {
      
      private static const ANIMATIONS_TABLE:String = "Animation";
      
      private static const ANIMATIONS_CACHE:Object = {};
      
      private static var animationsTable:Table;
       
      
      public function AnimationEmissions()
      {
         super();
         throw new Error("AnimationEmissions is a static class!");
      }
      
      public static function getAnimationEmissionData(name:String) : AnimationEmissionData
      {
         if(ANIMATIONS_CACHE.hasOwnProperty(name))
         {
            return ANIMATIONS_CACHE[name];
         }
         var _loc4_:* = name;
         var _loc3_:* = getTable();
         §§push(§§findproperty(AnimationEmissionData));
         if(!_loc3_._cache[_loc4_])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc4_);
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_._cache[_loc4_] = _loc5_;
         }
         var _loc2_:AnimationEmissionData = new §§pop().AnimationEmissionData(_loc3_._cache[_loc4_]);
         ANIMATIONS_CACHE[name] = _loc2_;
         return _loc2_;
      }
      
      public static function getTable() : Table
      {
         if(!animationsTable)
         {
            var _loc1_:ProjectManager = ProjectManager;
            animationsTable = com.dchoc.projectdata.ProjectManager.projectData.findTable("Animation");
         }
         return animationsTable;
      }
   }
}
