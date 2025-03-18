package tuxwars.home.ui.screen.vip
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.TextUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.data.VIPData;
   import tuxwars.data.VIPPriceData;
   import tuxwars.data.assets.TooltipsData;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.nomoney.NoMoneyPopUpSubState;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.ItemBaseTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function InactiveMembershipContainer(design:MovieClip, game:TuxWarsGame, vipScreen:VIPScreen, no:int, parent:UIComponent = null)
      {
         var iconRow:Row = null;
         var _loc13_:Object = null;
         var _loc11_:MovieClip = null;
         price1Data = VIPData.getVIPPrice("Price1");
         price2Data = VIPData.getVIPPrice("Price2");
         price3Data = VIPData.getVIPPrice("Price3");
         super(design,parent);
         this.game = game;
         this.vipScreen = vipScreen;
         var freeGiftClip:MovieClip = design.getChildByName("freegift") as MovieClip;
         freeGiftClip.visible = false;
         var noFreeGiftClip:MovieClip = design.getChildByName("no_freegift") as MovieClip;
         noFreeGiftClip.visible = false;
         dayText = TuxUiUtils.createAutoTextFieldWithText(design.Slot_01.Text_days);
         switch(no - 1)
         {
            case 0:
               priceData = price1Data;
               priceTooltip = "TOOLTIP_VIP_1_DAY";
               freeGiftClip.visible = false;
               noFreeGiftClip.visible = true;
               dayText.setText("Day");
               break;
            case 1:
               priceData = price2Data;
               priceTooltip = "TOOLTIP_VIP_7_DAY";
               freeGiftClip.visible = true;
               noFreeGiftClip.visible = false;
               var _loc20_:String = "VIPPrice";
               var _loc14_:ProjectManager = ProjectManager;
               var _loc21_:String = "Price2";
               var _loc15_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc20_);
               if(!_loc15_._cache[_loc21_])
               {
                  var _loc22_:Row = com.dchoc.utils.DCUtils.find(_loc15_.rows,"id",_loc21_);
                  if(!_loc22_)
                  {
                     com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc21_ + "\' was found in table: \'" + _loc15_.name + "\'",_loc15_,3);
                  }
                  _loc15_._cache[_loc21_] = _loc22_;
               }
               iconRow = _loc15_._cache[_loc21_];
               dayText.setText("Days");
               break;
            case 2:
               priceData = price3Data;
               priceTooltip = "TOOLTIP_VIP_30_DAY";
               freeGiftClip.visible = true;
               noFreeGiftClip.visible = false;
               var _loc23_:String = "VIPPrice";
               var _loc16_:ProjectManager = ProjectManager;
               var _loc24_:String = "Price3";
               var _loc17_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc23_);
               if(!_loc17_._cache[_loc24_])
               {
                  var _loc25_:Row = com.dchoc.utils.DCUtils.find(_loc17_.rows,"id",_loc24_);
                  if(!_loc25_)
                  {
                     com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc24_ + "\' was found in table: \'" + _loc17_.name + "\'",_loc17_,3);
                  }
                  _loc17_._cache[_loc24_] = _loc25_;
               }
               iconRow = _loc17_._cache[_loc24_];
               dayText.setText("Days");
         }
         membershipText = ProjectManager.getText("VIP_MEMBERSHIP_HEADER");
         statusText = ProjectManager.getText("VIP_MEMBERSHIP_STATUS_INACTIVE");
         subscriptionText = ProjectManager.getText("VIP_MEMBERSHIP_SUBSCRIPTION_INACTIVE");
         buttonMC = design.Slot_01;
         var dayString:String = TextUtils.getTimeTextFromSeconds(priceData.duration);
         var ii:int = int(dayString.indexOf("d"));
         var daySubString:String = dayString.substr(0,ii);
         time1Text = TuxUiUtils.createAutoTextFieldWithText(design.Slot_01.Text_number,daySubString);
         button = TuxUiUtils.createButton(UIButton,design.Slot_01,"Button_Buy",buttonCallback,null,priceTooltip);
         button.setText(priceData.price.toString());
         button.addEventListener("out",mouseOut,false,0,true);
         button.addEventListener("over",mouseOver,false,0,true);
         updateButtonState();
         if(iconRow)
         {
            var _loc26_:String = "Item";
            var _loc18_:* = iconRow;
            if(!_loc18_._cache[_loc26_])
            {
               _loc18_._cache[_loc26_] = com.dchoc.utils.DCUtils.find(_loc18_._fields,"name",_loc26_);
            }
            var _loc19_:* = _loc18_._cache[_loc26_];
            _loc13_ = _loc19_.overrideValue != null ? _loc19_.overrideValue : _loc19_._value;
            giftItem = ItemManager.getItemData(_loc13_.id);
            if(giftItem.iconRef)
            {
               _loc11_ = DCResourceManager.instance.getFromSWF(giftItem.iconRef.swf,giftItem.iconRef.export);
               if(_loc11_)
               {
                  _loc11_.name = giftItem.iconRef.export;
               }
            }
            freeGiftClip.Container_Icon.addChild(_loc11_);
            freeGiftClip.Container_Icon.addEventListener("mouseOver",itemMouseOver,false,0,true);
            freeGiftClip.Container_Icon.addEventListener("mouseOut",itemMouseOut,false,0,true);
         }
      }
      
      private function buttonCallback(event:MouseEvent) : void
      {
         if(canAfford(priceData.price))
         {
            vipScreen.vipLogic.buyVIP(priceData);
            TooltipManager.removeTooltip();
         }
      }
      
      private function canAfford(value:int) : Boolean
      {
         var sound2:SoundReference = null;
         if(game.player.premiumMoney < value)
         {
            sound2 = Sounds.getSoundReference("Nomoney");
            if(sound2)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",sound2.getMusicID(),sound2.getStart(),sound2.getType(),"PlaySound"));
            }
            var _loc3_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.triggerPopup(new NoMoneyPopUpSubState(game,"Cash"),game.currentState);
            return false;
         }
         return true;
      }
      
      private function mouseOver(event:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(event.getButton().getParameter() as String),event.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(event:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function updateButtonState() : void
      {
         enableButton(true);
         buttonMC.gotoAndStop("Visible");
      }
      
      public function enableButton(value:Boolean) : void
      {
         button.setEnabled(value);
      }
      
      private function itemMouseOver(event:MouseEvent) : void
      {
         trace("itemMouseOver");
         var _loc2_:ShopItem = ShopItemManager.getShopItem(giftItem);
         if(_loc2_)
         {
            TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getWeaponTooltipGraphics(),game),this._design);
         }
      }
      
      private function itemMouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

