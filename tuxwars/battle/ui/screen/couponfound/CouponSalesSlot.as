package tuxwars.battle.ui.screen.couponfound
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.Row;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.effects.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.data.*;
   import tuxwars.data.assets.*;
   import tuxwars.home.ui.screen.*;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.CouponData;
   import tuxwars.items.managers.*;
   import tuxwars.net.*;
   import tuxwars.net.messages.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.nomoney.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class CouponSalesSlot
   {
      private var design:MovieClip;
      
      private var parent:TuxUIScreen;
      
      private var couponData:CouponData;
      
      private var saleRow:Row;
      
      private var newPrice:int;
      
      private var button:UIButton;
      
      public function CouponSalesSlot(param1:MovieClip, param2:TuxUIScreen, param3:CouponData)
      {
         super();
         this.design = param1;
         this.parent = param2;
         this.couponData = param3;
         this.findSale();
         this.setUpSaleData();
      }
      
      public function dispose() : void
      {
         this.button.removeEventListener("out",this.mouseOut);
         this.button.removeEventListener("over",this.mouseOver);
         this.button.dispose();
         this.design.Slot_Selected.Container_Icon.removeEventListener("mouseOver",this.itemMouseOver,false);
         this.design.Slot_Selected.Container_Icon.removeEventListener("mouseOut",this.itemMouseOut,false);
         TooltipManager.removeTooltip();
         this.parent = null;
         this.couponData = null;
      }
      
      private function findSale() : void
      {
         if(this.isPremium)
         {
            this.newPrice = this.couponData.couponPremiumPrice;
         }
         else
         {
            this.newPrice = this.couponData.couponInGamePrice;
         }
      }
      
      private function get isPremium() : Boolean
      {
         return this.couponData.itemData.priceInfoReference.priceObject.isPremium;
      }
      
      private function get oldPrice() : int
      {
         return this.couponData.itemData.priceInfoReference.priceObject.priceValue;
      }
      
      private function setPrice() : void
      {
         var _loc1_:* = null;
         var _loc2_:MovieClip = this.design.Slot_Selected.Container_Price;
         var _loc3_:MovieClip = _loc2_.Price_Cash;
         var _loc4_:MovieClip = _loc2_.Price_Coins;
         _loc3_.visible = this.isPremium;
         _loc4_.visible = !this.isPremium;
         if(this.isPremium)
         {
            _loc1_ = _loc3_;
         }
         else
         {
            _loc1_ = _loc4_;
         }
         this.button = TuxUiUtils.createButton(UIButton,_loc1_,"Button_Buy",this.buyItem,null,"TOOLTIP_BUY_ITEM");
         this.button.setText(this.newPrice.toString());
         this.button.addEventListener("out",this.mouseOut,false,0,true);
         this.button.addEventListener("over",this.mouseOver,false,0,true);
         _loc1_.Text_Price_Old.text = this.oldPrice;
      }
      
      private function buyItem(param1:MouseEvent) : void
      {
         var _loc2_:SoundReference = null;
         var _loc3_:ShopItem = null;
         var _loc4_:SoundReference = null;
         var _loc5_:Boolean = false;
         if(Boolean(this.isPremium) && this.newPrice <= this.parent.tuxGame.player.premiumMoney)
         {
            _loc5_ = true;
         }
         if(!this.isPremium && this.newPrice <= this.parent.tuxGame.player.ingameMoney)
         {
            _loc5_ = true;
         }
         if(_loc5_)
         {
            _loc2_ = Sounds.getSoundReference("Buy");
            if(_loc2_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
            }
            this.button.setEnabled(false);
            TooltipManager.removeTooltip();
            MessageCenter.sendEvent(new ShopItemCouponMessage(this.couponData,this.parent));
            _loc3_ = ShopItemManager.getShopItemWithId(this.couponData.itemData.id);
            CRMService.sendEvent("Action","Button_Pressed","Clicked","Coupon",_loc3_.id);
            BuyingAnimation.startAnimation(this.design.Slot_Selected.Container_Icon,_loc3_.amountPurchased,_loc3_.icon);
         }
         else
         {
            _loc4_ = Sounds.getSoundReference("Nomoney");
            if(_loc2_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc4_.getMusicID(),_loc4_.getStart(),_loc4_.getType(),"PlaySound"));
            }
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.triggerPopup(new NoMoneyPopUpSubState(this.parent.tuxGame,!!this.isPremium ? "Cash" : "Coins"),this.parent.tuxGame.currentState);
         }
      }
      
      private function setUpSaleData() : void
      {
         var _loc1_:MovieClip = this.design.Slot_Selected;
         TuxUiUtils.createAutoTextFieldWithText(_loc1_.Text,this.couponData.itemData.name);
         var _loc2_:int = 100 - this.newPrice / this.oldPrice * 100;
         _loc1_.Text_Sale.text = "-" + _loc2_ + "%";
         _loc1_.Text_Sale.selectable = false;
         TuxUiUtils.createAutoTextField(_loc1_.Text_Message,"ONE_TIME_OFFER");
         _loc1_.Container_Icon.addChild(this.couponData.itemData.icon);
         _loc1_.Container_Icon.addEventListener("mouseOver",this.itemMouseOver,false,0,true);
         _loc1_.Container_Icon.addEventListener("mouseOut",this.itemMouseOut,false,0,true);
         this.setPrice();
      }
      
      private function mouseOver(param1:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(param1.getButton().getParameter() as String),param1.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(param1:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      private function itemMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:TuxTooltip = null;
         var _loc3_:ShopItem = ShopItemManager.getShopItem(this.couponData.itemData);
         if(_loc3_)
         {
            if(_loc3_.itemData.type == "Weapon")
            {
               _loc2_ = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getWeaponTooltipGraphics(),(this.parent as TuxUIScreen).tuxGame),this.design);
            }
            else if(_loc3_.itemData.type == "Clothing")
            {
               _loc2_ = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getClothingTooltipGraphics(),(this.parent as TuxUIScreen).tuxGame),this.design);
            }
            else
            {
               _loc2_ = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getBoosterTooltipGraphics(),(this.parent as TuxUIScreen).tuxGame),this.design);
            }
            _loc2_.setX(_loc2_.getX() - this.design.width / 2);
         }
      }
      
      private function itemMouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

