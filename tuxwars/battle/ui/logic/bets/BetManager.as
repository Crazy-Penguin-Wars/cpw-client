package tuxwars.battle.ui.logic.bets
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import no.olog.utilfunctions.assert;
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
         var _loc1_:Table = null;
         if(_bets.length <= 0)
         {
            var _loc7_:String = "Bet";
            var _loc3_:ProjectManager = ProjectManager;
            _loc1_ = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc7_);
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
         var _loc8_:String = "BettingSettings";
         var _loc4_:ProjectManager = ProjectManager;
         var _loc2_:Table = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc8_);
         var _loc9_:int = 0;
         var _loc5_:* = _loc2_;
         no.olog.utilfunctions.assert("Row index out of bounds.",true,_loc9_ >= 0 && _loc9_ < _loc5_.rows.length);
         var _loc3_:Row = _loc5_.rows[_loc9_];
         var _loc10_:String = "BettingTime";
         var _loc6_:* = _loc3_;
         if(!_loc6_._cache[_loc10_])
         {
            _loc6_._cache[_loc10_] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name",_loc10_);
         }
         var field:Field = _loc6_._cache[_loc10_];
         var _loc7_:*;
         return !!field ? (_loc7_ = field, _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) : 0;
      }
   }
}

