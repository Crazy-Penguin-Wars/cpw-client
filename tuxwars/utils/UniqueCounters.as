package tuxwars.utils
{
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
   public class UniqueCounters
   {
      
      private static const COUNTERS:Object = {};
       
      
      public function UniqueCounters()
      {
         super();
         throw new Error("UniqueCounters is a static class!");
      }
      
      public static function reset() : void
      {
         DCUtils.deleteProperties(COUNTERS);
      }
      
      public static function next(id:String, from:String) : uint
      {
         var _loc3_:uint = getNextId(from);
         LogUtils.log("Generated unique counter: " + _loc3_ + " for " + id + " from " + from,"UniqueCounters",1,"Match",false,false,false);
         return _loc3_;
      }
      
      private static function getNextId(from:String) : uint
      {
         var _loc2_:uint = uint(COUNTERS.hasOwnProperty(from) ? COUNTERS[from] : 0);
         COUNTERS[from] = _loc2_ + 1;
         return _loc2_;
      }
   }
}
