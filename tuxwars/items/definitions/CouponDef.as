package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.*;
   import tuxwars.items.data.*;
   
   public class CouponDef extends ItemDef
   {
      private var _itemId:String;
      
      private var _ingamePrice:int;
      
      private var _premiumPrice:int;
      
      public function CouponDef()
      {
         super();
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         assert("GameData is not CraftingData",true,param1 is CouponData);
         var _loc2_:CouponData = param1 as CouponData;
         this._itemId = _loc2_.couponItemId;
         this._ingamePrice = _loc2_.couponInGamePrice;
         this._premiumPrice = _loc2_.couponPremiumPrice;
      }
      
      public function get itemId() : String
      {
         return this._itemId;
      }
      
      public function get inGamePrice() : int
      {
         return this._ingamePrice;
      }
      
      public function get premiumPrice() : int
      {
         return this._premiumPrice;
      }
   }
}

