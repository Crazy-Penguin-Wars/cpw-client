package tuxwars.tournament
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.items.TournamentRewardItem;
   
   public class LeagueRewardData
   {
      private static const ID:String = "ID";
      
      private static const REWARD:String = "Rewards";
      
      private static const REWARD_AMOUNT:String = "RewardsAmount";
      
      public static const REWARD_TYPE_CASH:String = "Cash";
      
      public static const REWARD_TYPE_COINS:String = "Coins";
      
      public static const REWARD_TYPE_XP:String = "XP";
      
      public static const REWARD_TYPE_VIP:String = "VIP";
      
      public static const REWARD_TYPE_ITEM:String = "Item";
      
      private var row:Row;
      
      private var _rewards:Vector.<TournamentRewardItem>;
      
      public function LeagueRewardData(row:Row)
      {
         var _loc3_:Array = null;
         var _loc2_:Array = null;
         var i:int = 0;
         super();
         this.row = row;
         var _loc18_:String = "Rewards";
         var _loc5_:* = row;
         if(!_loc5_._cache[_loc18_])
         {
            _loc5_._cache[_loc18_] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name",_loc18_);
         }
         if(_loc5_._cache[_loc18_])
         {
            var _loc19_:String = "Rewards";
            var _loc6_:* = row;
            if(!_loc6_._cache[_loc19_])
            {
               _loc6_._cache[_loc19_] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name",_loc19_);
            }
            var _loc7_:* = _loc6_._cache[_loc19_];
            if((_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) is Array)
            {
               var _loc20_:String = "Rewards";
               var _loc8_:* = row;
               if(!_loc8_._cache[_loc20_])
               {
                  _loc8_._cache[_loc20_] = com.dchoc.utils.DCUtils.find(_loc8_._fields,"name",_loc20_);
               }
               var _loc9_:* = _loc8_._cache[_loc20_];
               §§push(_loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value);
            }
            else
            {
               var _loc21_:String = "Rewards";
               var _loc10_:* = row;
               if(!_loc10_._cache[_loc21_])
               {
                  _loc10_._cache[_loc21_] = com.dchoc.utils.DCUtils.find(_loc10_._fields,"name",_loc21_);
               }
               var _loc11_:* = _loc10_._cache[_loc21_];
               §§push([_loc11_.overrideValue != null ? _loc11_.overrideValue : _loc11_._value]);
            }
            _loc3_ = §§pop();
            var _loc22_:String = "RewardsAmount";
            var _loc12_:* = row;
            if(!_loc12_._cache[_loc22_])
            {
               _loc12_._cache[_loc22_] = com.dchoc.utils.DCUtils.find(_loc12_._fields,"name",_loc22_);
            }
            var _loc13_:* = _loc12_._cache[_loc22_];
            if((_loc13_.overrideValue != null ? _loc13_.overrideValue : _loc13_._value) is Array)
            {
               var _loc23_:String = "RewardsAmount";
               var _loc14_:* = row;
               if(!_loc14_._cache[_loc23_])
               {
                  _loc14_._cache[_loc23_] = com.dchoc.utils.DCUtils.find(_loc14_._fields,"name",_loc23_);
               }
               var _loc15_:* = _loc14_._cache[_loc23_];
               §§push(_loc15_.overrideValue != null ? _loc15_.overrideValue : _loc15_._value);
            }
            else
            {
               var _loc24_:String = "RewardsAmount";
               var _loc16_:* = row;
               if(!_loc16_._cache[_loc24_])
               {
                  _loc16_._cache[_loc24_] = com.dchoc.utils.DCUtils.find(_loc16_._fields,"name",_loc24_);
               }
               var _loc17_:* = _loc16_._cache[_loc24_];
               §§push([_loc17_.overrideValue != null ? _loc17_.overrideValue : _loc17_._value]);
            }
            _loc2_ = §§pop();
            _rewards = new Vector.<TournamentRewardItem>();
            for(i = 0; i < _loc3_.length; )
            {
               _rewards.push(new TournamentRewardItem(_loc3_[i],_loc2_[i]));
               i++;
            }
         }
      }
      
      public function get id() : String
      {
         var _loc3_:String = "ID";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get rewards() : Vector.<TournamentRewardItem>
      {
         return _rewards;
      }
      
      public function getFirstRewardOption() : TournamentRewardItem
      {
         if(_rewards && rewards.length > 0)
         {
            return _rewards[0];
         }
         return null;
      }
   }
}

