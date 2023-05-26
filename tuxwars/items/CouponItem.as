package tuxwars.items
{
   import no.olog.utilfunctions.assert;
   import tuxwars.items.definitions.CouponDef;
   import tuxwars.items.definitions.EquippableDef;
   
   public class CouponItem extends Item
   {
       
      
      private var _itemId:String;
      
      private var _ingamePrice:int;
      
      private var _premiumPrice:int;
      
      public function CouponItem()
      {
         super();
      }
      
      override public function load(data:EquippableDef) : void
      {
         super.load(data);
         assert("data is not CraftingDef",true,data is CouponDef);
         var _loc2_:CouponDef = data as CouponDef;
         _itemId = _loc2_.itemId;
         _ingamePrice = _loc2_.inGamePrice;
         _premiumPrice = _loc2_.premiumPrice;
      }
      
      public function get couponItemId() : String
      {
         return _itemId;
      }
      
      public function get couponInGamePrice() : int
      {
         return _ingamePrice;
      }
      
      public function get couponPremiumPrice() : int
      {
         return _premiumPrice;
      }
   }
}
