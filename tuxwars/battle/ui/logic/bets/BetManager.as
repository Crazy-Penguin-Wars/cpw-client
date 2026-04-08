package tuxwars.battle.ui.logic.bets
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.data.*;
   
   public class BetManager
   {
      private static const BETtable:String = "Bet";
      
      private static const BET_SETTINGStable:String = "BettingSettings";
      
      private static const BETTING_TIME:String = "BettingTime";
      
      private static const _bets:Vector.<BetData> = new Vector.<BetData>();
      
      public function BetManager()
      {
         super();
         throw new Error("GiftManager is a static class!");
      }
      
      public static function getBets() : Vector.<BetData>
      {
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc1_:Table = null;
         if(_bets.length <= 0)
         {
            _loc2_ = "Bet";
            _loc1_ = ProjectManager.findTable(_loc2_);
            _loc3_ = _loc1_;
            for each(_loc4_ in _loc3_._rows)
            {
               _bets.push(new BetData(_loc4_));
            }
            _bets.sort(sortByPriority);
         }
         return _bets;
      }
      
      public static function getBet(param1:String) : BetData
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in _bets)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getBetIndex(param1:String) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _bets.length)
         {
            if(_bets[_loc2_].id == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private static function sortByPriority(param1:BetData, param2:BetData) : int
      {
         if(param1.sortPriority == param2.sortPriority)
         {
            return 0;
         }
         if(param1.sortPriority < param2.sortPriority)
         {
            return -1;
         }
         return 1;
      }
      
      public static function getBetingTime() : int
      {
         var _loc9_:* = undefined;
         var _loc1_:String = "BettingSettings";
         var _loc2_:Table = ProjectManager.findTable(_loc1_);
         var _loc3_:int = 0;
         var _loc4_:* = _loc2_;
         assert("Row index out of bounds.",true,_loc3_ >= 0 && _loc3_ < _loc4_.rows.length);
         var _loc5_:Row = _loc4_.rows[_loc3_];
         var _loc6_:String = "BettingTime";
         var _loc7_:* = _loc5_;
         if(!_loc7_.getCache[_loc6_])
         {
            _loc7_.getCache[_loc6_] = DCUtils.find(_loc7_.getFields(),"name",_loc6_);
         }
         _loc9_ = _loc8_;
         var _loc8_:Field = _loc7_.getCache[_loc6_];
         return !!_loc8_ ? (_loc9_.overrideValue != null ? int(_loc9_.overrideValue) : int(_loc9_._value)) : 0;
      }
   }
}

