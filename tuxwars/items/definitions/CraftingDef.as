package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.*;
   import tuxwars.items.data.*;
   
   public class CraftingDef extends ItemDef
   {
      private var _rewardCash:int;
      
      private var _rewardCoin:int;
      
      private var _rewardExp:int;
      
      public function CraftingDef()
      {
         super();
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         assert("GameData is not CraftingData",true,param1 is CraftingData);
         var _loc2_:CraftingData = param1 as CraftingData;
         this._rewardCash = _loc2_.rewardCash;
         this._rewardCoin = _loc2_.rewardCoins;
         this._rewardExp = _loc2_.rewardExp;
      }
      
      public function get rewardCash() : int
      {
         return this._rewardCash;
      }
      
      public function get rewardCoins() : int
      {
         return this._rewardCoin;
      }
      
      public function get rewardExp() : int
      {
         return this._rewardExp;
      }
   }
}

