package tuxwars.items
{
   import no.olog.utilfunctions.*;
   import tuxwars.items.definitions.*;
   
   public class CouponItem extends Item
   {
      private var _itemId:String;
      
      private var _ingamePrice:int;
      
      private var _premiumPrice:int;
      
      public function CouponItem()
      {
         super();
      }
      
      override public function load(param1:EquippableDef) : void
      {
         super.load(param1);
         assert("data is not CraftingDef",true,param1 is CouponDef);
         var _loc2_:CouponDef = param1 as CouponDef;
         this._itemId = _loc2_.itemId;
         this._ingamePrice = _loc2_.inGamePrice;
         this._premiumPrice = _loc2_.premiumPrice;
      }
      
      public function get couponItemId() : String
      {
         return this._itemId;
      }
      
      public function get couponInGamePrice() : int
      {
         return this._ingamePrice;
      }
      
      public function get couponPremiumPrice() : int
      {
         return this._premiumPrice;
      }
   }
}

