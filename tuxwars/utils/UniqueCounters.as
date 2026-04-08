package tuxwars.utils
{
   import com.dchoc.utils.*;
   
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
      
      public static function next(param1:String, param2:String) : uint
      {
         var _loc3_:uint = uint(getNextId(param2));
         LogUtils.log("Generated unique counter: " + _loc3_ + " for " + param1 + " from " + param2,"UniqueCounters",1,"Match",false,false,false);
         return _loc3_;
      }
      
      private static function getNextId(param1:String) : uint
      {
         var _loc2_:uint = uint(!!COUNTERS.hasOwnProperty(param1) ? COUNTERS[param1] : 0);
         COUNTERS[param1] = _loc2_ + 1;
         return _loc2_;
      }
   }
}

