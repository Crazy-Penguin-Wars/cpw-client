package tuxwars.items.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   
   public class CraftingData extends ItemData
   {
      
      private static const REWARD_CASH:String = "RewardCash";
      
      private static const REWARD_COINS:String = "RewardCoins";
      
      private static const REWARD_EXP:String = "RewardExp";
       
      
      public function CraftingData(row:Row)
      {
         super(row);
      }
      
      public function get rewardCash() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["RewardCash"])
         {
            _loc2_._cache["RewardCash"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RewardCash");
         }
         var _loc1_:Field = _loc2_._cache["RewardCash"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get rewardCoins() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["RewardCoins"])
         {
            _loc2_._cache["RewardCoins"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RewardCoins");
         }
         var _loc1_:Field = _loc2_._cache["RewardCoins"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get rewardExp() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["RewardExp"])
         {
            _loc2_._cache["RewardExp"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RewardExp");
         }
         var _loc1_:Field = _loc2_._cache["RewardExp"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
   }
}
