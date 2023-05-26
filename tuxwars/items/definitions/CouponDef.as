package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.data.CouponData;
   
   public class CouponDef extends ItemDef
   {
       
      
      private var _itemId:String;
      
      private var _ingamePrice:int;
      
      private var _premiumPrice:int;
      
      public function CouponDef()
      {
         super();
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         assert("GameData is not CraftingData",true,data is CouponData);
         var _loc2_:CouponData = data as CouponData;
         _itemId = _loc2_.couponItemId;
         _ingamePrice = _loc2_.couponInGamePrice;
         _premiumPrice = _loc2_.couponPremiumPrice;
      }
      
      public function get itemId() : String
      {
         return _itemId;
      }
      
      public function get inGamePrice() : int
      {
         return _ingamePrice;
      }
      
      public function get premiumPrice() : int
      {
         return _premiumPrice;
      }
   }
}
