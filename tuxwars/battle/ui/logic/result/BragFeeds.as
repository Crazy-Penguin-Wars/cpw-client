package tuxwars.battle.ui.logic.result
{
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.PlayerResult;
   
   public class BragFeeds
   {
      
      public static const FIRST:String = "First";
      
      public static const FIVE_HUNDRED_POINTS:String = "500Points";
      
      public static const FIRST_AND_250_SPREAD:String = "250Spread";
      
      public static const TWO_THOUSAND_TOTAL:String = "2000Game";
       
      
      public function BragFeeds()
      {
         super();
         throw new Error("BragFeeds is a static class!");
      }
      
      public static function getBragFeedId(playerResults:Vector.<PlayerResult>) : String
      {
         if(totalPoints(playerResults) > 2000)
         {
            return "2000Game";
         }
         var _loc3_:* = BattleManager.getLocalPlayer();
         var _loc2_:Boolean = _loc3_._id == playerResults[0].player.id;
         if(_loc2_ && playerResults.length > 1 && playerResults[0].score - playerResults[1].score > 250)
         {
            return "250Spread";
         }
         if(playerResults[0].score > 500)
         {
            return "500Points";
         }
         if(_loc2_)
         {
            return "First";
         }
         return null;
      }
      
      private static function totalPoints(playerResults:Vector.<PlayerResult>) : int
      {
         var total:int = 0;
         for each(var result in playerResults)
         {
            total += result.score;
         }
         return total;
      }
   }
}
