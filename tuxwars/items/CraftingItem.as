package tuxwars.items
{
   import no.olog.utilfunctions.assert;
   import tuxwars.items.definitions.CraftingDef;
   import tuxwars.items.definitions.EquippableDef;
   
   public class CraftingItem extends Item
   {
       
      
      private var _rewardCash:int;
      
      private var _rewardCoin:int;
      
      private var _rewardExp:int;
      
      public function CraftingItem()
      {
         super();
      }
      
      override public function load(data:EquippableDef) : void
      {
         super.load(data);
         assert("data is not CraftingDef",true,data is CraftingDef);
         var _loc2_:CraftingDef = data as CraftingDef;
         _rewardCash = _loc2_.rewardCash;
         _rewardCoin = _loc2_.rewardCoins;
         _rewardExp = _loc2_.rewardExp;
      }
      
      public function get rewardCash() : int
      {
         return _rewardCash;
      }
      
      public function get rewardCoins() : int
      {
         return _rewardCoin;
      }
      
      public function get rewardExp() : int
      {
         return _rewardExp;
      }
   }
}
