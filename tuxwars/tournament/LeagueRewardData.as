package tuxwars.tournament
{
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.*;
   import tuxwars.items.*;
   
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
      
      public function LeagueRewardData(param1:Row)
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:int = 0;
         super();
         this.row = param1;
         if(!param1.getCache[REWARD])
         {
            param1.getCache[REWARD] = DCUtils.find(param1.getFields(),"name",REWARD);
         }
         if(param1.getCache[REWARD])
         {
            _loc4_ = param1.getCache[REWARD];
            _loc5_ = _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
            _loc2_ = _loc5_ is Array ? _loc5_ : [_loc5_];
            if(!param1.getCache[REWARD_AMOUNT])
            {
               param1.getCache[REWARD_AMOUNT] = DCUtils.find(param1.getFields(),"name",REWARD_AMOUNT);
            }
            _loc6_ = param1.getCache[REWARD_AMOUNT];
            _loc7_ = _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value;
            _loc3_ = _loc7_ is Array ? _loc7_ : [_loc7_];
            this._rewards = new Vector.<TournamentRewardItem>();
            _loc8_ = 0;
            while(_loc8_ < _loc2_.length)
            {
               this._rewards.push(new TournamentRewardItem(_loc2_[_loc8_],_loc3_[_loc8_]));
               _loc8_++;
            }
         }
      }
      
      public function get id() : String
      {
         if(!this.row.getCache[ID])
         {
            this.row.getCache[ID] = DCUtils.find(this.row.getFields(),"name",ID);
         }
         var _loc1_:* = this.row.getCache[ID];
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public function get rewards() : Vector.<TournamentRewardItem>
      {
         return this._rewards;
      }
      
      public function getFirstRewardOption() : TournamentRewardItem
      {
         return Boolean(this._rewards) && this._rewards.length > 0 ? this._rewards[0] : null;
      }
   }
}

