package tuxwars.battle.ui.logic.result
{
   import tuxwars.battle.*;
   
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
      
      public static function getBragFeedId(param1:Vector.<PlayerResult>) : String
      {
         if(totalPoints(param1) > 2000)
         {
            return "2000Game";
         }
         var _loc2_:* = BattleManager.getLocalPlayer();
         var _loc3_:* = _loc2_._id == param1[0].player.id;
         if(_loc3_ && param1.length > 1 && param1[0].score - param1[1].score > 250)
         {
            return "250Spread";
         }
         if(param1[0].score > 500)
         {
            return "500Points";
         }
         if(_loc3_)
         {
            return "First";
         }
         return null;
      }
      
      private static function totalPoints(param1:Vector.<PlayerResult>) : int
      {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc2_ += _loc3_.score;
         }
         return _loc2_;
      }
   }
}

