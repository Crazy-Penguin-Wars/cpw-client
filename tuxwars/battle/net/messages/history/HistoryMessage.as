package tuxwars.battle.net.messages.history
{
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class HistoryMessage extends SocketMessage
   {
      
      public static const SCORE:String = "score";
      
      public static const GAINED_COINS:String = "coins";
      
      public static const GAINED_CASH:String = "cash";
      
      public static const GAINED_EXPERIENCE:String = "experience";
      
      public static const HIT_POINTS:String = "hitPoints";
      
      public static const EARNED_ITEMS:String = "earnedItems";
      
      public static const USED_ITEMS:String = "usedItems";
      
      public static const DEBUG_STR:String = "debugStr";
      
      public static const CHALLENGE_COUNTERS:String = "challengeCounters";
      
      public static const COMPLETED_CHALLENGES:String = "challenges";
      
      public static const STATISTICS:String = "statistics";
      
      public static const OS:String = "os";
       
      
      public function HistoryMessage(data:Object)
      {
         super({
            "t":14,
            "content":data
         });
      }
   }
}
