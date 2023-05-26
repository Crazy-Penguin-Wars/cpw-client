package tuxwars.battle.ui.logic.bets
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import tuxwars.items.data.BetData;
   
   public class BetManager
   {
      
      private static const BET_TABLE:String = "Bet";
      
      private static const BET_SETTINGS_TABLE:String = "BettingSettings";
      
      private static const BETTING_TIME:String = "BettingTime";
      
      private static const _bets:Vector.<BetData> = new Vector.<BetData>();
       
      
      public function BetManager()
      {
         super();
         throw new Error("GiftManager is a static class!");
      }
      
      public static function getBets() : Vector.<BetData>
      {
         var _loc1_:* = null;
         if(_bets.length <= 0)
         {
            var _loc3_:ProjectManager = ProjectManager;
            _loc1_ = com.dchoc.projectdata.ProjectManager.projectData.findTable("Bet");
            var _loc4_:* = _loc1_;
            for each(var row in _loc4_._rows)
            {
               _bets.push(new BetData(row));
            }
            _bets.sort(sortByPriority);
         }
         return _bets;
      }
      
      public static function getBet(id:String) : BetData
      {
         for each(var bet in _bets)
         {
            if(bet.id == id)
            {
               return bet;
            }
         }
         return null;
      }
      
      public static function getBetIndex(id:String) : int
      {
         var betIndex:int = 0;
         for(betIndex = 0; betIndex < _bets.length; )
         {
            if(_bets[betIndex].id == id)
            {
               return betIndex;
            }
            betIndex++;
         }
         return -1;
      }
      
      private static function sortByPriority(a:BetData, b:BetData) : int
      {
         if(a.sortPriority == b.sortPriority)
         {
            return 0;
         }
         if(a.sortPriority < b.sortPriority)
         {
            return -1;
         }
         return 1;
      }
      
      public static function getBetingTime() : int
      {
         var _loc4_:ProjectManager = ProjectManager;
         var _loc2_:Table = com.dchoc.projectdata.ProjectManager.projectData.findTable("BettingSettings");
         var _loc5_:* = _loc2_;
         no.olog.utilfunctions.assert("Row index out of bounds.",true,0 < _loc5_.rows.length);
         var _loc3_:Row = _loc5_.rows[0];
         var _loc6_:* = _loc3_;
         if(!_loc6_._cache["BettingTime"])
         {
            _loc6_._cache["BettingTime"] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name","BettingTime");
         }
         var field:Field = _loc6_._cache["BettingTime"];
         var _loc7_:*;
         return !!field ? (_loc7_ = field, _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) : 0;
      }
   }
}
