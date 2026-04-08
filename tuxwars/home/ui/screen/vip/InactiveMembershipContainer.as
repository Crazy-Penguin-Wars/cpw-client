package tuxwars.home.ui.screen.vip
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.data.assets.*;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.nomoney.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class InactiveMembershipContainer extends AbstractMembershipContainer
   {
      private static const ENABLED_LABEL:String = "Visible";
      
      private static const PRICE1Tooltip:String = "TOOLTIP_VIP_1_DAY";
      
      private static const PRICE2Tooltip:String = "TOOLTIP_VIP_7_DAY";
      
      private static const PRICE3Tooltip:String = "TOOLTIP_VIP_30_DAY";
      
      public static const FREE_GIFT:String = "freegift";
      
      public static const NOFREE_GIFT:String = "no_freegift";
      
      private var game:TuxWarsGame;
      
      private var priceTooltip:String;
      
      private var price1Data:VIPPriceData;
      
      private var price2Data:VIPPriceData;
      
      private var price3Data:VIPPriceData;
      
      private var priceData:VIPPriceData;
      
      private var vipScreen:VIPScreen;
      
      private var buttonMC:MovieClip;
      
      private var button:UIButton;
      
      private var time1Text:UIAutoTextField;
      
      private var dayText:UIAutoTextField;
      
      private var giftItem:ItemData;
      
      public function InactiveMembershipContainer(param1:MovieClip, param2:TuxWarsGame, param3:VIPScreen, param4:int, param5:UIComponent = null)
      {
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:* = undefined;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _loc19_:* = undefined;
         var _loc20_:Row = null;
         var _loc21_:Row = null;
         var _loc22_:String = null;
         var _loc23_:* = undefined;
         var _loc24_:* = undefined;
         var _loc6_:Row = null;
         var _loc7_:Object = null;
         var _loc8_:MovieClip = null;
         this.price1Data = VIPData.getVIPPrice("Price1");
         this.price2Data = VIPData.getVIPPrice("Price2");
         this.price3Data = VIPData.getVIPPrice("Price3");
         super(param1,param5);
         this.game = param2;
         this.vipScreen = param3;
         var _loc9_:MovieClip = param1.getChildByName("freegift") as MovieClip;
         _loc9_.visible = false;
         var _loc10_:MovieClip = param1.getChildByName("no_freegift") as MovieClip;
         _loc10_.visible = false;
         this.dayText = TuxUiUtils.createAutoTextFieldWithText(param1.Slot_01.Text_days);
         switch(param4 - 1)
         {
            case 0:
               this.priceData = this.price1Data;
               this.priceTooltip = "TOOLTIP_VIP_1_DAY";
               _loc9_.visible = false;
               _loc10_.visible = true;
               this.dayText.setText("Day");
               break;
            case 1:
               this.priceData = this.price2Data;
               this.priceTooltip = "TOOLTIP_VIP_7_DAY";
               _loc9_.visible = true;
               _loc10_.visible = false;
               _loc14_ = "VIPPrice";
               _loc15_ = "Price2";
               _loc16_ = ProjectManager.findTable(_loc14_);
               if(!_loc16_.getCache[_loc15_])
               {
                  _loc20_ = DCUtils.find(_loc16_.rows,"id",_loc15_);
                  if(!_loc20_)
                  {
                     LogUtils.log("No row with name: \'" + _loc15_ + "\' was found in table: \'" + _loc16_.name + "\'",_loc16_,3);
                  }
                  _loc16_.getCache[_loc15_] = _loc20_;
               }
               _loc6_ = _loc16_.getCache[_loc15_];
               this.dayText.setText("Days");
               break;
            case 2:
               this.priceData = this.price3Data;
               this.priceTooltip = "TOOLTIP_VIP_30_DAY";
               _loc9_.visible = true;
               _loc10_.visible = false;
               _loc17_ = "VIPPrice";
               _loc18_ = "Price3";
               _loc19_ = ProjectManager.findTable(_loc17_);
               if(!_loc19_.getCache[_loc18_])
               {
                  _loc21_ = DCUtils.find(_loc19_.rows,"id",_loc18_);
                  if(!_loc21_)
                  {
                     LogUtils.log("No row with name: \'" + _loc18_ + "\' was found in table: \'" + _loc19_.name + "\'",_loc19_,3);
                  }
                  _loc19_.getCache[_loc18_] = _loc21_;
               }
               _loc6_ = _loc19_.getCache[_loc18_];
               this.dayText.setText("Days");
         }
         membershipText = ProjectManager.getText("VIP_MEMBERSHIP_HEADER");
         statusText = ProjectManager.getText("VIP_MEMBERSHIP_STATUS_INACTIVE");
         subscriptionText = ProjectManager.getText("VIP_MEMBERSHIP_SUBSCRIPTION_INACTIVE");
         this.buttonMC = param1.Slot_01;
         var _loc11_:String = TextUtils.getTimeTextFromSeconds(this.priceData.duration);
         var _loc12_:int = int(_loc11_.indexOf("d"));
         var _loc13_:String = _loc11_.substr(0,_loc12_);
         this.time1Text = TuxUiUtils.createAutoTextFieldWithText(param1.Slot_01.Text_number,_loc13_);
         this.button = TuxUiUtils.createButton(UIButton,param1.Slot_01,"Button_Buy",this.buttonCallback,null,this.priceTooltip);
         this.button.setText(this.priceData.price.toString());
         this.button.addEventListener("out",this.mouseOut,false,0,true);
         this.button.addEventListener("over",this.mouseOver,false,0,true);
         this.updateButtonState();
         if(_loc6_)
         {
            _loc22_ = "Item";
            _loc23_ = _loc6_;
            if(!_loc23_.getCache[_loc22_])
            {
               _loc23_.getCache[_loc22_] = DCUtils.find(_loc23_.getFields(),"name",_loc22_);
            }
            _loc24_ = _loc23_.getCache[_loc22_];
            _loc7_ = _loc24_.overrideValue != null ? _loc24_.overrideValue : _loc24_._value;
            this.giftItem = ItemManager.getItemData(_loc7_.id);
            if(this.giftItem.iconRef)
            {
               _loc8_ = DCResourceManager.instance.getFromSWF(this.giftItem.iconRef.swf,this.giftItem.iconRef.export);
               if(_loc8_)
               {
                  _loc8_.name = this.giftItem.iconRef.export;
               }
            }
            _loc9_.Container_Icon.addChild(_loc8_);
            _loc9_.Container_Icon.addEventListener("mouseOver",this.itemMouseOver,false,0,true);
            _loc9_.Container_Icon.addEventListener("mouseOut",this.itemMouseOut,false,0,true);
         }
      }
      
      private function buttonCallback(param1:MouseEvent) : void
      {
         if(this.canAfford(this.priceData.price))
         {
            this.vipScreen.vipLogic.buyVIP(this.priceData);
            TooltipManager.removeTooltip();
         }
      }
      
      private function canAfford(param1:int) : Boolean
      {
         var _loc2_:SoundReference = null;
         if(this.game.player.premiumMoney < param1)
         {
            _loc2_ = Sounds.getSoundReference("Nomoney");
            if(_loc2_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
            }
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.triggerPopup(new NoMoneyPopUpSubState(this.game,"Cash"),this.game.currentState);
            return false;
         }
         return true;
      }
      
      private function mouseOver(param1:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(param1.getButton().getParameter() as String),param1.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(param1:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function updateButtonState() : void
      {
         this.enableButton(true);
         this.buttonMC.gotoAndStop("Visible");
      }
      
      public function enableButton(param1:Boolean) : void
      {
         this.button.setEnabled(param1);
      }
      
      private function itemMouseOver(param1:MouseEvent) : void
      {
         trace("itemMouseOver");
         var _loc2_:ShopItem = ShopItemManager.getShopItem(this.giftItem);
         if(_loc2_)
         {
            TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getWeaponTooltipGraphics(),this.game),this._design);
         }
      }
      
      private function itemMouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

