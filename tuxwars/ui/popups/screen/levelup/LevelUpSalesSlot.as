package tuxwars.ui.popups.screen.levelup
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.effects.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.data.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   import tuxwars.net.*;
   import tuxwars.net.messages.*;
   import tuxwars.player.Player;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.nomoney.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class LevelUpSalesSlot
   {
      private var design:MovieClip;
      
      private var parent:TuxUIScreen;
      
      private var item:ItemData;
      
      private var saleRow:Row;
      
      private var newPrice:int;
      
      private var button:UIButton;
      
      private var levelNumber:int;
      
      public function LevelUpSalesSlot(param1:MovieClip, param2:TuxUIScreen, param3:Player, param4:int)
      {
         super();
         this.design = param1;
         this.parent = param2;
         this.findSale(param4);
         this.setUpSaleData();
      }
      
      public static function hasSaleWithPlayer(param1:Player) : Boolean
      {
         return LevelUpSalesSlot.getSale(param1.level) != null;
      }
      
      public static function hasSale(param1:int) : Boolean
      {
         return LevelUpSalesSlot.getSale(param1) != null;
      }
      
      public static function getSale(param1:int) : Row
      {
         var _loc5_:Row = null;
         var _loc2_:String = "ItemLevelUpSales";
         var _loc3_:* = "" + param1;
         var _loc4_:* = ProjectManager.findTable(_loc2_);
         if(!_loc4_.getCache[_loc3_])
         {
            _loc5_ = DCUtils.find(_loc4_.rows,"id",_loc3_);
            if(!_loc5_)
            {
               LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_.getCache[_loc3_] = _loc5_;
         }
         return _loc4_.getCache[_loc3_];
      }
      
      public static function getSalePrice(param1:int) : int
      {
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:String = null;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc2_:Object = null;
         var _loc3_:ItemData = null;
         var _loc4_:Row = LevelUpSalesSlot.getSale(param1);
         if(_loc4_)
         {
            _loc5_ = "Item";
            _loc6_ = _loc4_;
            if(!_loc6_.getCache[_loc5_])
            {
               _loc6_.getCache[_loc5_] = DCUtils.find(_loc6_.getFields(),"name",_loc5_);
            }
            _loc7_ = _loc6_.getCache[_loc5_];
            _loc2_ = _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value;
            _loc3_ = ItemManager.getItemData(_loc2_.id);
            if(_loc3_)
            {
               if(_loc3_.priceInfoReference.priceObject.isPremium)
               {
                  _loc11_ = "Premium";
                  _loc12_ = _loc4_;
                  if(!_loc12_.getCache[_loc11_])
                  {
                     _loc12_.getCache[_loc11_] = DCUtils.find(_loc12_.getFields(),"name",_loc11_);
                  }
                  _loc13_ = _loc12_.getCache[_loc11_];
                  return _loc13_.overrideValue != null ? int(_loc13_.overrideValue) : int(_loc13_._value);
               }
               _loc8_ = "InGame";
               _loc9_ = _loc4_;
               if(!_loc9_.getCache[_loc8_])
               {
                  _loc9_.getCache[_loc8_] = DCUtils.find(_loc9_.getFields(),"name",_loc8_);
               }
               _loc10_ = _loc9_.getCache[_loc8_];
               return _loc10_.overrideValue != null ? int(_loc10_.overrideValue) : int(_loc10_._value);
            }
         }
         return 999;
      }
      
      public function dispose() : void
      {
         this.button.removeEventListener("out",this.mouseOut);
         this.button.removeEventListener("over",this.mouseOver);
         this.button.dispose();
         this.design.Container_Icon.removeEventListener("mouseOver",this.itemMouseOver,false);
         this.design.Container_Icon.removeEventListener("mouseOut",this.itemMouseOut,false);
         TooltipManager.removeTooltip();
         this.parent = null;
         this.item = null;
         this.saleRow = null;
      }
      
      private function findSale(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc4_:Row = null;
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:Row = null;
         var _loc8_:* = undefined;
         var _loc9_:String = null;
         var _loc10_:Row = null;
         var _loc11_:* = undefined;
         var _loc2_:Object = null;
         this.saleRow = LevelUpSalesSlot.getSale(param1);
         if(this.saleRow)
         {
            _loc3_ = "Item";
            _loc4_ = this.saleRow;
            if(!_loc4_.getCache[_loc3_])
            {
               _loc4_.getCache[_loc3_] = DCUtils.find(_loc4_.getFields(),"name",_loc3_);
            }
            _loc5_ = _loc4_.getCache[_loc3_];
            _loc2_ = _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value;
            this.item = ItemManager.getItemData(_loc2_.id);
            if(this.isPremium)
            {
               _loc6_ = "Premium";
               _loc7_ = this.saleRow;
               if(!_loc7_.getCache[_loc6_])
               {
                  _loc7_.getCache[_loc6_] = DCUtils.find(_loc7_.getFields(),"name",_loc6_);
               }
               _loc8_ = _loc7_.getCache[_loc6_];
               this.newPrice = _loc8_.overrideValue != null ? int(_loc8_.overrideValue) : int(_loc8_._value);
            }
            else
            {
               _loc9_ = "InGame";
               _loc10_ = this.saleRow;
               if(!_loc10_.getCache[_loc9_])
               {
                  _loc10_.getCache[_loc9_] = DCUtils.find(_loc10_.getFields(),"name",_loc9_);
               }
               _loc11_ = _loc10_.getCache[_loc9_];
               this.newPrice = _loc11_.overrideValue != null ? int(_loc11_.overrideValue) : int(_loc11_._value);
            }
         }
      }
      
      private function get isPremium() : Boolean
      {
         return this.item.priceInfoReference.priceObject.isPremium;
      }
      
      private function get oldPrice() : int
      {
         return this.item.priceInfoReference.priceObject.priceValue;
      }
      
      private function setPrice() : void
      {
         var _loc1_:* = null;
         var _loc2_:MovieClip = this.design.Container_Price;
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
            _loc3_ = ShopItemManager.getShopItemWithId(this.item.id);
            MessageCenter.sendEvent(new ShopItemLevelUpSalesMessage(_loc3_,this.parent));
            CRMService.sendEvent("Action","Button_Pressed","Clicked","LevelUpSale",_loc3_.id);
            BuyingAnimation.startAnimation(this.design.Container_Icon,_loc3_.amountPurchased,_loc3_.icon);
            this.setButtonDisabled();
            MessageCenter.addListener("ItemBoughtCouponSales",this.enableButton);
         }
         else
         {
            _loc4_ = Sounds.getSoundReference("Nomoney");
            if(_loc4_)
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
         TuxUiUtils.createAutoTextFieldWithText(this.design.Text,this.item.name);
         var _loc1_:int = 100 - this.newPrice / this.oldPrice * 100;
         this.design.Text_Sale.text = "-" + _loc1_ + "%";
         this.design.Text_Sale.selectable = false;
         TuxUiUtils.createAutoTextField(this.design.Text_Message,"ONE_TIME_OFFER");
         this.design.Container_Icon.addChild(this.item.icon);
         this.design.Container_Icon.addEventListener("mouseOver",this.itemMouseOver,false,0,true);
         this.design.Container_Icon.addEventListener("mouseOut",this.itemMouseOut,false,0,true);
         this.setPrice();
      }
      
      private function enableButton(param1:Message) : void
      {
         this.setButtonEnabled();
         MessageCenter.removeListener("ItemBoughtCouponSales",this.enableButton);
      }
      
      private function setButtonDisabled() : void
      {
         this.button.setEnabled(false);
      }
      
      private function setButtonEnabled() : void
      {
         this.button.setEnabled(true);
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
         TooltipManager.showTooltip(new ItemTooltip(this.item.name,this.item.description),this.design);
      }
      
      private function itemMouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

