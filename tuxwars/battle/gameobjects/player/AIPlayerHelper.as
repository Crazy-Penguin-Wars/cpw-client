package tuxwars.battle.gameobjects.player
{
   public class AIPlayerHelper
   {
      private static const AI_CACHE:Object = {};
      
      public function AIPlayerHelper()
      {
         super();
      }
      
      public static function getAIPlayerReference(param1:String) : AIPlayerReference
      {
         if(AI_CACHE.hasOwnProperty(param1))
         {
            return AI_CACHE[param1];
         }
         var _loc2_:AIPlayerReference = new AIPlayerReference(param1);
         AI_CACHE[param1] = _loc2_;
         return _loc2_;
      }
   }
}

