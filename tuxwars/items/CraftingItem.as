package tuxwars.items
{
   import no.olog.utilfunctions.*;
   import tuxwars.items.definitions.*;
   
   public class CraftingItem extends Item
   {
      private var _rewardCash:int;
      
      private var _rewardCoin:int;
      
      private var _rewardExp:int;
      
      public function CraftingItem()
      {
         super();
      }
      
      override public function load(param1:EquippableDef) : void
      {
         super.load(param1);
         assert("data is not CraftingDef",true,param1 is CraftingDef);
         var _loc2_:CraftingDef = param1 as CraftingDef;
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

