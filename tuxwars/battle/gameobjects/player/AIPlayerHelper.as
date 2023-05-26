package tuxwars.battle.gameobjects.player
{
   public class AIPlayerHelper
   {
      
      private static const AI_CACHE:Object = {};
       
      
      public function AIPlayerHelper()
      {
         super();
      }
      
      public static function getAIPlayerReference(name:String) : AIPlayerReference
      {
         if(AI_CACHE.hasOwnProperty(name))
         {
            return AI_CACHE[name];
         }
         var _loc2_:AIPlayerReference = new AIPlayerReference(name);
         AI_CACHE[name] = _loc2_;
         return _loc2_;
      }
   }
}
