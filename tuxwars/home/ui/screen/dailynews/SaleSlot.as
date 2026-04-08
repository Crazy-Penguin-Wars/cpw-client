package tuxwars.home.ui.screen.dailynews
{
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.effects.*;
   import com.dchoc.ui.text.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.data.*;
   import tuxwars.data.assets.*;
   import tuxwars.home.states.crafting.*;
   import tuxwars.home.states.equipment.*;
   import tuxwars.home.states.money.*;
   import tuxwars.home.states.shop.*;
   import tuxwars.home.states.vip.*;
   import tuxwars.home.ui.logic.dailynews.SaleData;
   import tuxwars.home.ui.screen.*;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.*;
   import tuxwars.net.*;
   import tuxwars.net.messages.*;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.nomoney.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class SaleSlot
   {
      private const timeText:UIAutoTextField = new UIAutoTextField();
      
      private var data:SaleData;
      
      private var button:UIButton;
      
      private var design:MovieClip;
      
      private var parent:TuxUIScreen;
      
      public function SaleSlot(param1:MovieClip, param2:SaleData, param3:TuxUIScreen)
      {
         super();
         this.design = param1;
         this.data = param2;
         this.parent = param3;
         this.setUpSaleData();
         param1.addEventListener("mouseOver",this.mouseOver,false,0,true);
         param1.addEventListener("mouseOut",this.mouseOut,false,0,true);
      }
      
      public function dispose() : void
      {
         LogicUpdater.unregister(this,"SaleButton");
         this.design.removeEventListener("mouseOver",this.mouseOver,false);
         this.design.removeEventListener("mouseOut",this.mouseOut,false);
         TooltipManager.removeTooltip();
         MessageCenter.removeListener("ItemBought",this.enableButton);
         this.data = null;
         if(this.button)
         {
            this.button.dispose();
            this.button = null;
         }
         this.design = null;
         this.parent = null;
      }
      
      public function logicUpdate(param1:int) : void
      {
         if(this.timeText)
         {
            this.timeText.setText(TextUtils.getTimeTextFromSeconds((this.data.remainingTime - DCGame.getTime()) * 0.001));
         }
      }
      
      private function setPrice() : void
      {
         var _loc1_:MovieClip = this.design.Container_Price;
         var _loc2_:MovieClip = _loc1_.Price_Cash;
         var _loc3_:MovieClip = _loc1_.Price_Coins;
         _loc2_.visible = this.data.premium;
         _loc3_.visible = !this.data.premium;
         if(this.data.premium)
         {
            this.button = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Buy",this.buttonCallback);
            this.button.setText(this.data.newPrice.toString());
            _loc2_.Text_Price_Old.text = this.data.oldPrice;
         }
         else
         {
            this.button = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Buy",this.buttonCallback);
            this.button.setText(this.data.newPrice.toString());
            _loc3_.Text_Price_Old.text = this.data.oldPrice;
         }
      }
      
      private function buttonCallback(param1:MouseEvent) : void
      {
         switch(this.data.action)
         {
            case "directBuy":
               this.buyItem();
               break;
            case "OpenCharacter":
               this.openScreen(new EquipmentState(this.parent.tuxGame));
               break;
            case "OpenCrafting":
               this.openScreen(new CraftingState(this.parent.tuxGame));
               break;
            case "OpenGetCash":
               this.openScreen(new MoneyState(this.parent.tuxGame,"popup_get_cash_new"));
               break;
            case "OpenGetCoins":
               this.openScreen(new MoneyState(this.parent.tuxGame,"popup_get_coins"));
               break;
            case "OpenMembership":
               this.openScreen(new VIPState(this.parent.tuxGame));
               break;
            case "OpenSupplies":
               this.openScreen(new ShopState(this.parent.tuxGame));
         }
      }
      
      private function openScreen(param1:TuxState) : void
      {
         this.parent.tuxGame.homeState.changeState(param1);
      }
      
      private function buyItem() : void
      {
         var _loc1_:SoundReference = null;
         var _loc2_:ShopItem = null;
         var _loc3_:SoundReference = null;
         var _loc4_:Boolean = false;
         if(Boolean(this.data.premium) && this.data.newPrice <= this.parent.tuxGame.player.premiumMoney)
         {
            _loc4_ = true;
         }
         if(!this.data.premium && this.data.newPrice <= this.parent.tuxGame.player.ingameMoney)
         {
            _loc4_ = true;
         }
         if(_loc4_)
         {
            _loc1_ = Sounds.getSoundReference("Buy");
            if(_loc1_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
            }
            this.disableButtonUntillServerResponse();
            _loc2_ = ShopItemManager.getShopItemWithId(this.data.itemId);
            CRMService.sendEvent("Action","Button_Pressed","Clicked",CRMService.classChecker(this.parent),_loc2_.id);
            MessageCenter.sendEvent(new ShopItemMessage(_loc2_,this.parent));
            BuyingAnimation.startAnimation(this.design.Container_Icon,_loc2_.amountPurchased,_loc2_.icon);
         }
         else
         {
            _loc3_ = Sounds.getSoundReference("Nomoney");
            if(_loc3_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType(),"PlaySound"));
            }
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.triggerPopup(new NoMoneyPopUpSubState(this.parent.tuxGame,!!this.data.premium ? "Cash" : "Coins"),this.parent.tuxGame.currentState);
         }
      }
      
      private function setUpSaleData() : void
      {
         TuxUiUtils.createAutoTextFieldWithText(this.design.Text,this.data.title);
         var _loc1_:int = 100 - this.data.newPrice / this.data.oldPrice * 100;
         this.design.Text_Sale.text = "-" + _loc1_ + "%";
         this.design.Text_Sale.selectable = false;
         TuxUiUtils.createAutoTextField(this.design.Text_Message,"LIMITED_TIME_OFFER");
         this.timeText.setTextField(this.design.Text_Time);
         this.design.Container_Icon.addChild(this.data.itemData.icon);
         this.setPrice();
         LogicUpdater.register(this,"SaleButton");
      }
      
      private function disableButtonUntillServerResponse() : void
      {
         if(this.button)
         {
            this.button.setEnabled(false);
         }
         MessageCenter.addListener("ItemBought",this.enableButton);
      }
      
      private function enableButton(param1:Message) : void
      {
         MessageCenter.removeListener("ItemBought",this.enableButton);
         if(this.button)
         {
            this.button.setEnabled(true);
         }
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         var _loc2_:ShopItem = ShopItemManager.getShopItem(this.data.itemData);
         if(_loc2_)
         {
            if(_loc2_.itemData.type == "Weapon")
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getWeaponTooltipGraphics(),(this.parent as TuxUIScreen).tuxGame),this.design);
            }
            else if(_loc2_.itemData.type == "Clothing")
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getClothingTooltipGraphics(),(this.parent as TuxUIScreen).tuxGame),this.design);
            }
            else
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getBoosterTooltipGraphics(),(this.parent as TuxUIScreen).tuxGame),this.design);
            }
         }
         else
         {
            TooltipManager.showTooltip(new ItemTooltip(this.data.itemData.name,this.data.itemData.description),this.design);
         }
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

