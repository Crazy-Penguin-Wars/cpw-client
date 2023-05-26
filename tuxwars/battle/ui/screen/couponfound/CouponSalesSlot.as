package tuxwars.battle.ui.screen.couponfound
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.Row;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.effects.BuyingAnimation;
   import com.dchoc.ui.events.UIButtonEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.data.assets.TooltipsData;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.CouponData;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.net.CRMService;
   import tuxwars.net.messages.ShopItemCouponMessage;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.nomoney.NoMoneyPopUpSubState;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.ItemBaseTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.ui.tooltips.TuxTooltip;
   import tuxwars.utils.TuxUiUtils;
   
   public class CouponSalesSlot
   {
       
      
      private var design:MovieClip;
      
      private var parent:TuxUIScreen;
      
      private var couponData:CouponData;
      
      private var saleRow:Row;
      
      private var newPrice:int;
      
      private var button:UIButton;
      
      public function CouponSalesSlot(design:MovieClip, parent:TuxUIScreen, couponData:CouponData)
      {
         super();
         this.design = design;
         this.parent = parent;
         this.couponData = couponData;
         findSale();
         setUpSaleData();
      }
      
      public function dispose() : void
      {
         button.removeEventListener("out",mouseOut);
         button.removeEventListener("over",mouseOver);
         button.dispose();
         design.Slot_Selected.Container_Icon.removeEventListener("mouseOver",itemMouseOver,false);
         design.Slot_Selected.Container_Icon.removeEventListener("mouseOut",itemMouseOut,false);
         TooltipManager.removeTooltip();
         parent = null;
         couponData = null;
      }
      
      private function findSale() : void
      {
         if(isPremium)
         {
            newPrice = couponData.couponPremiumPrice;
         }
         else
         {
            newPrice = couponData.couponInGamePrice;
         }
      }
      
      private function get isPremium() : Boolean
      {
         return couponData.itemData.priceInfoReference.priceObject.isPremium;
      }
      
      private function get oldPrice() : int
      {
         return couponData.itemData.priceInfoReference.priceObject.priceValue;
      }
      
      private function setPrice() : void
      {
         var currentContainer:* = null;
         var _loc2_:MovieClip = design.Slot_Selected.Container_Price;
         var _loc4_:MovieClip = _loc2_.Price_Cash;
         var _loc1_:MovieClip = _loc2_.Price_Coins;
         _loc4_.visible = isPremium;
         _loc1_.visible = !isPremium;
         if(isPremium)
         {
            currentContainer = _loc4_;
         }
         else
         {
            currentContainer = _loc1_;
         }
         button = TuxUiUtils.createButton(UIButton,currentContainer,"Button_Buy",buyItem,null,"TOOLTIP_BUY_ITEM");
         button.setText(newPrice.toString());
         button.addEventListener("out",mouseOut,false,0,true);
         button.addEventListener("over",mouseOver,false,0,true);
         currentContainer.Text_Price_Old.text = oldPrice;
      }
      
      private function buyItem(event:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var hasMoney:Boolean = false;
         if(isPremium && newPrice <= parent.tuxGame.player.premiumMoney)
         {
            hasMoney = true;
         }
         if(!isPremium && newPrice <= parent.tuxGame.player.ingameMoney)
         {
            hasMoney = true;
         }
         if(hasMoney)
         {
            _loc3_ = Sounds.getSoundReference("Buy");
            if(_loc3_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType(),"PlaySound"));
            }
            button.setEnabled(false);
            TooltipManager.removeTooltip();
            MessageCenter.sendEvent(new ShopItemCouponMessage(couponData,parent));
            _loc4_ = ShopItemManager.getShopItemWithId(couponData.itemData.id);
            CRMService.sendEvent("Action","Button_Pressed","Clicked","Coupon",_loc4_.id);
            BuyingAnimation.startAnimation(design.Slot_Selected.Container_Icon,_loc4_.amountPurchased,_loc4_.icon);
         }
         else
         {
            _loc5_ = Sounds.getSoundReference("Nomoney");
            if(_loc3_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc5_.getMusicID(),_loc5_.getStart(),_loc5_.getType(),"PlaySound"));
            }
            var _loc6_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.triggerPopup(new NoMoneyPopUpSubState(parent.tuxGame,isPremium ? "Cash" : "Coins"),parent.tuxGame.currentState);
         }
      }
      
      private function setUpSaleData() : void
      {
         var _loc1_:MovieClip = design.Slot_Selected;
         TuxUiUtils.createAutoTextFieldWithText(_loc1_.Text,couponData.itemData.name);
         var _loc2_:int = 100 - newPrice / oldPrice * 100;
         _loc1_.Text_Sale.text = "-" + _loc2_ + "%";
         _loc1_.Text_Sale.selectable = false;
         TuxUiUtils.createAutoTextField(_loc1_.Text_Message,"ONE_TIME_OFFER");
         _loc1_.Container_Icon.addChild(couponData.itemData.icon);
         _loc1_.Container_Icon.addEventListener("mouseOver",itemMouseOver,false,0,true);
         _loc1_.Container_Icon.addEventListener("mouseOut",itemMouseOut,false,0,true);
         setPrice();
      }
      
      private function mouseOver(event:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(event.getButton().getParameter() as String),event.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(event:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      private function itemMouseOver(event:MouseEvent) : void
      {
         var tt:* = null;
         var _loc3_:ShopItem = ShopItemManager.getShopItem(couponData.itemData);
         if(_loc3_)
         {
            if(_loc3_.itemData.type == "Weapon")
            {
               tt = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getWeaponTooltipGraphics(),(parent as TuxUIScreen).tuxGame),design);
            }
            else if(_loc3_.itemData.type == "Clothing")
            {
               tt = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getClothingTooltipGraphics(),(parent as TuxUIScreen).tuxGame),design);
            }
            else
            {
               tt = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getBoosterTooltipGraphics(),(parent as TuxUIScreen).tuxGame),design);
            }
            tt.setX(tt.getX() - design.width / 2);
         }
      }
      
      private function itemMouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
