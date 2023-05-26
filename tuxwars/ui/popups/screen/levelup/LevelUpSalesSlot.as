package tuxwars.ui.popups.screen.levelup
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.effects.BuyingAnimation;
   import com.dchoc.ui.events.UIButtonEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.net.CRMService;
   import tuxwars.net.messages.ShopItemLevelUpSalesMessage;
   import tuxwars.player.Player;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.nomoney.NoMoneyPopUpSubState;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.ItemTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class LevelUpSalesSlot
   {
       
      
      private var design:MovieClip;
      
      private var parent:TuxUIScreen;
      
      private var item:ItemData;
      
      private var saleRow:Row;
      
      private var newPrice:int;
      
      private var button:UIButton;
      
      private var levelNumber:int;
      
      public function LevelUpSalesSlot(design:MovieClip, parent:TuxUIScreen, player:Player, levelNumber:int)
      {
         super();
         this.design = design;
         this.parent = parent;
         findSale(levelNumber);
         setUpSaleData();
      }
      
      public static function hasSaleWithPlayer(player:Player) : Boolean
      {
         return LevelUpSalesSlot.getSale(player.level) != null;
      }
      
      public static function hasSale(currentLevel:int) : Boolean
      {
         return LevelUpSalesSlot.getSale(currentLevel) != null;
      }
      
      public static function getSale(currentLevel:int) : Row
      {
         var _loc2_:ProjectManager = ProjectManager;
         var _loc5_:* = "" + currentLevel;
         var _loc3_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("ItemLevelUpSales");
         if(!_loc3_._cache[_loc5_])
         {
            var _loc6_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc5_);
            if(!_loc6_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc5_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_._cache[_loc5_] = _loc6_;
         }
         return _loc3_._cache[_loc5_];
      }
      
      public static function getSalePrice(currentLevel:int) : int
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var saleRow:Row = LevelUpSalesSlot.getSale(currentLevel);
         if(saleRow)
         {
            var _loc5_:* = saleRow;
            if(!_loc5_._cache["Item"])
            {
               _loc5_._cache["Item"] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name","Item");
            }
            var _loc6_:* = _loc5_._cache["Item"];
            _loc2_ = _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value;
            _loc3_ = ItemManager.getItemData(_loc2_.id);
            if(_loc3_)
            {
               if(_loc3_.priceInfoReference.priceObject.isPremium)
               {
                  var _loc7_:* = saleRow;
                  if(!_loc7_._cache["Premium"])
                  {
                     _loc7_._cache["Premium"] = com.dchoc.utils.DCUtils.find(_loc7_._fields,"name","Premium");
                  }
                  var _loc8_:* = _loc7_._cache["Premium"];
                  return _loc8_.overrideValue != null ? _loc8_.overrideValue : _loc8_._value;
               }
               var _loc9_:* = saleRow;
               if(!_loc9_._cache["InGame"])
               {
                  _loc9_._cache["InGame"] = com.dchoc.utils.DCUtils.find(_loc9_._fields,"name","InGame");
               }
               var _loc10_:* = _loc9_._cache["InGame"];
               return _loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value;
            }
         }
         return 999;
      }
      
      public function dispose() : void
      {
         button.removeEventListener("out",mouseOut);
         button.removeEventListener("over",mouseOver);
         button.dispose();
         design.Container_Icon.removeEventListener("mouseOver",itemMouseOver,false);
         design.Container_Icon.removeEventListener("mouseOut",itemMouseOut,false);
         TooltipManager.removeTooltip();
         parent = null;
         item = null;
         saleRow = null;
      }
      
      private function findSale(currentLevel:int) : void
      {
         var _loc2_:* = null;
         saleRow = LevelUpSalesSlot.getSale(currentLevel);
         if(saleRow)
         {
            var _loc3_:Row = saleRow;
            if(!_loc3_._cache["Item"])
            {
               _loc3_._cache["Item"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","Item");
            }
            var _loc4_:* = _loc3_._cache["Item"];
            _loc2_ = _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
            item = ItemManager.getItemData(_loc2_.id);
            if(isPremium)
            {
               var _loc5_:Row = saleRow;
               if(!_loc5_._cache["Premium"])
               {
                  _loc5_._cache["Premium"] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name","Premium");
               }
               var _loc6_:* = _loc5_._cache["Premium"];
               newPrice = _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value;
            }
            else
            {
               var _loc7_:Row = saleRow;
               if(!_loc7_._cache["InGame"])
               {
                  _loc7_._cache["InGame"] = com.dchoc.utils.DCUtils.find(_loc7_._fields,"name","InGame");
               }
               var _loc8_:* = _loc7_._cache["InGame"];
               newPrice = _loc8_.overrideValue != null ? _loc8_.overrideValue : _loc8_._value;
            }
         }
      }
      
      private function get isPremium() : Boolean
      {
         return item.priceInfoReference.priceObject.isPremium;
      }
      
      private function get oldPrice() : int
      {
         return item.priceInfoReference.priceObject.priceValue;
      }
      
      private function setPrice() : void
      {
         var currentContainer:* = null;
         var _loc2_:MovieClip = design.Container_Price;
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
            _loc4_ = ShopItemManager.getShopItemWithId(item.id);
            MessageCenter.sendEvent(new ShopItemLevelUpSalesMessage(_loc4_,parent));
            CRMService.sendEvent("Action","Button_Pressed","Clicked","LevelUpSale",_loc4_.id);
            BuyingAnimation.startAnimation(design.Container_Icon,_loc4_.amountPurchased,_loc4_.icon);
            setButtonDisabled();
            MessageCenter.addListener("ItemBoughtCouponSales",enableButton);
         }
         else
         {
            _loc5_ = Sounds.getSoundReference("Nomoney");
            if(_loc5_)
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
         TuxUiUtils.createAutoTextFieldWithText(design.Text,item.name);
         var _loc1_:int = 100 - newPrice / oldPrice * 100;
         design.Text_Sale.text = "-" + _loc1_ + "%";
         design.Text_Sale.selectable = false;
         TuxUiUtils.createAutoTextField(design.Text_Message,"ONE_TIME_OFFER");
         design.Container_Icon.addChild(item.icon);
         design.Container_Icon.addEventListener("mouseOver",itemMouseOver,false,0,true);
         design.Container_Icon.addEventListener("mouseOut",itemMouseOut,false,0,true);
         setPrice();
      }
      
      private function enableButton(msg:Message) : void
      {
         setButtonEnabled();
         MessageCenter.removeListener("ItemBoughtCouponSales",enableButton);
      }
      
      private function setButtonDisabled() : void
      {
         button.setEnabled(false);
      }
      
      private function setButtonEnabled() : void
      {
         button.setEnabled(true);
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
         TooltipManager.showTooltip(new ItemTooltip(item.name,item.description),design);
      }
      
      private function itemMouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
