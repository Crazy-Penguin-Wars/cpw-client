package tuxwars.battle.data.animationEmissions
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class AnimationEmissions
   {
      private static var animationsTable:Table;
      
      private static const ANIMATIONStable:String = "Animation";
      
      private static const ANIMATIONS_CACHE:Object = {};
      
      public function AnimationEmissions()
      {
         super();
         throw new Error("AnimationEmissions is a static class!");
      }
      
      public static function getAnimationEmissionData(param1:String) : AnimationEmissionData
      {
         var _loc4_:Row = null;
         if(ANIMATIONS_CACHE.hasOwnProperty(param1))
         {
            return ANIMATIONS_CACHE[param1];
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
         var _loc3_:AnimationEmissionData = new AnimationEmissionData(_loc2_.getCache[param1]);
         ANIMATIONS_CACHE[param1] = _loc3_;
         return _loc3_;
      }
      
      public static function getTable() : Table
      {
         var _loc1_:String = null;
         if(!animationsTable)
         {
            _loc1_ = "Animation";
            animationsTable = ProjectManager.findTable(_loc1_);
         }
         return animationsTable;
      }
   }
}

