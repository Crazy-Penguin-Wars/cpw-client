package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.data.CraftingData;
   
   public class CraftingDef extends ItemDef
   {
       
      
      private var _rewardCash:int;
      
      private var _rewardCoin:int;
      
      private var _rewardExp:int;
      
      public function CraftingDef()
      {
         super();
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         assert("GameData is not CraftingData",true,data is CraftingData);
         var _loc2_:CraftingData = data as CraftingData;
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
