package tuxwars.tournament
{
   import com.dchoc.projectdata.Row;
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
         var _loc3_:* = null;
         var _loc2_:* = null;
         var i:int = 0;
         super();
         this.row = row;
         var _loc5_:* = row;
         if(!_loc5_._cache["Rewards"])
         {
            _loc5_._cache["Rewards"] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name","Rewards");
         }
         if(_loc5_._cache["Rewards"])
         {
            var _loc6_:* = row;
            if(!_loc6_._cache["Rewards"])
            {
               _loc6_._cache["Rewards"] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name","Rewards");
            }
            var _loc7_:* = _loc6_._cache["Rewards"];
            if((_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) is Array)
            {
               var _loc8_:* = row;
               if(!_loc8_._cache["Rewards"])
               {
                  _loc8_._cache["Rewards"] = com.dchoc.utils.DCUtils.find(_loc8_._fields,"name","Rewards");
               }
               var _loc9_:* = _loc8_._cache["Rewards"];
               §§push(_loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value);
            }
            else
            {
               var _loc10_:* = row;
               if(!_loc10_._cache["Rewards"])
               {
                  _loc10_._cache["Rewards"] = com.dchoc.utils.DCUtils.find(_loc10_._fields,"name","Rewards");
               }
               var _loc11_:* = _loc10_._cache["Rewards"];
               §§push([_loc11_.overrideValue != null ? _loc11_.overrideValue : _loc11_._value]);
            }
            _loc3_ = §§pop();
            var _loc12_:* = row;
            if(!_loc12_._cache["RewardsAmount"])
            {
               _loc12_._cache["RewardsAmount"] = com.dchoc.utils.DCUtils.find(_loc12_._fields,"name","RewardsAmount");
            }
            var _loc13_:* = _loc12_._cache["RewardsAmount"];
            if((_loc13_.overrideValue != null ? _loc13_.overrideValue : _loc13_._value) is Array)
            {
               var _loc14_:* = row;
               if(!_loc14_._cache["RewardsAmount"])
               {
                  _loc14_._cache["RewardsAmount"] = com.dchoc.utils.DCUtils.find(_loc14_._fields,"name","RewardsAmount");
               }
               var _loc15_:* = _loc14_._cache["RewardsAmount"];
               §§push(_loc15_.overrideValue != null ? _loc15_.overrideValue : _loc15_._value);
            }
            else
            {
               var _loc16_:* = row;
               if(!_loc16_._cache["RewardsAmount"])
               {
                  _loc16_._cache["RewardsAmount"] = com.dchoc.utils.DCUtils.find(_loc16_._fields,"name","RewardsAmount");
               }
               var _loc17_:* = _loc16_._cache["RewardsAmount"];
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
         var _loc1_:Row = row;
         if(!_loc1_._cache["ID"])
         {
            _loc1_._cache["ID"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","ID");
         }
         var _loc2_:* = _loc1_._cache["ID"];
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
