package tuxwars.home.ui.screen.dailynews
{
   import com.dchoc.game.DCGame;
   import com.dchoc.game.LogicUpdater;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.effects.BuyingAnimation;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.TextUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.data.assets.TooltipsData;
   import tuxwars.home.states.crafting.CraftingState;
   import tuxwars.home.states.equipment.EquipmentState;
   import tuxwars.home.states.money.MoneyState;
   import tuxwars.home.states.shop.ShopState;
   import tuxwars.home.states.vip.VIPState;
   import tuxwars.home.ui.logic.dailynews.SaleData;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.net.CRMService;
   import tuxwars.net.messages.ShopItemMessage;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.nomoney.NoMoneyPopUpSubState;
   import tuxwars.ui.tooltips.ItemBaseTooltip;
   import tuxwars.ui.tooltips.ItemTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class SaleSlot
   {
       
      
      private const timeText:UIAutoTextField = new UIAutoTextField();
      
      private var data:SaleData;
      
      private var button:UIButton;
      
      private var design:MovieClip;
      
      private var parent:TuxUIScreen;
      
      public function SaleSlot(design:MovieClip, data:SaleData, parent:TuxUIScreen)
      {
         super();
         this.design = design;
         this.data = data;
         this.parent = parent;
         setUpSaleData();
         design.addEventListener("mouseOver",mouseOver,false,0,true);
         design.addEventListener("mouseOut",mouseOut,false,0,true);
      }
      
      public function dispose() : void
      {
         LogicUpdater.unregister(this,"SaleButton");
         design.removeEventListener("mouseOver",mouseOver,false);
         design.removeEventListener("mouseOut",mouseOut,false);
         TooltipManager.removeTooltip();
         MessageCenter.removeListener("ItemBought",enableButton);
         data = null;
         if(button)
         {
            button.dispose();
            button = null;
         }
         design = null;
         parent = null;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         if(timeText)
         {
            timeText.setText(TextUtils.getTimeTextFromSeconds((data.remainingTime - DCGame.getTime()) * 0.001));
         }
      }
      
      private function setPrice() : void
      {
         var _loc2_:MovieClip = design.Container_Price;
         var _loc3_:MovieClip = _loc2_.Price_Cash;
         var _loc1_:MovieClip = _loc2_.Price_Coins;
         _loc3_.visible = data.premium;
         _loc1_.visible = !data.premium;
         if(data.premium)
         {
            button = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Buy",buttonCallback);
            button.setText(data.newPrice.toString());
            _loc3_.Text_Price_Old.text = data.oldPrice;
         }
         else
         {
            button = TuxUiUtils.createButton(UIButton,_loc1_,"Button_Buy",buttonCallback);
            button.setText(data.newPrice.toString());
            _loc1_.Text_Price_Old.text = data.oldPrice;
         }
      }
      
      private function buttonCallback(event:MouseEvent) : void
      {
         switch(data.action)
         {
            case "directBuy":
               buyItem();
               break;
            case "OpenCharacter":
               openScreen(new EquipmentState(parent.tuxGame));
               break;
            case "OpenCrafting":
               openScreen(new CraftingState(parent.tuxGame));
               break;
            case "OpenGetCash":
               openScreen(new MoneyState(parent.tuxGame,"popup_get_cash_new"));
               break;
            case "OpenGetCoins":
               openScreen(new MoneyState(parent.tuxGame,"popup_get_coins"));
               break;
            case "OpenMembership":
               openScreen(new VIPState(parent.tuxGame));
               break;
            case "OpenSupplies":
               openScreen(new ShopState(parent.tuxGame));
         }
      }
      
      private function openScreen(state:TuxState) : void
      {
         parent.tuxGame.homeState.changeState(state);
      }
      
      private function buyItem() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var hasMoney:Boolean = false;
         if(data.premium && data.newPrice <= parent.tuxGame.player.premiumMoney)
         {
            hasMoney = true;
         }
         if(!data.premium && data.newPrice <= parent.tuxGame.player.ingameMoney)
         {
            hasMoney = true;
         }
         if(hasMoney)
         {
            _loc2_ = Sounds.getSoundReference("Buy");
            if(_loc2_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
            }
            disableButtonUntillServerResponse();
            _loc3_ = ShopItemManager.getShopItemWithId(data.itemId);
            CRMService.sendEvent("Action","Button_Pressed","Clicked",CRMService.classChecker(parent),_loc3_.id);
            MessageCenter.sendEvent(new ShopItemMessage(_loc3_,parent));
            BuyingAnimation.startAnimation(design.Container_Icon,_loc3_.amountPurchased,_loc3_.icon);
         }
         else
         {
            _loc4_ = Sounds.getSoundReference("Nomoney");
            if(_loc4_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc4_.getMusicID(),_loc4_.getStart(),_loc4_.getType(),"PlaySound"));
            }
            var _loc5_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.triggerPopup(new NoMoneyPopUpSubState(parent.tuxGame,data.premium ? "Cash" : "Coins"),parent.tuxGame.currentState);
         }
      }
      
      private function setUpSaleData() : void
      {
         TuxUiUtils.createAutoTextFieldWithText(design.Text,data.title);
         var _loc1_:int = 100 - data.newPrice / data.oldPrice * 100;
         design.Text_Sale.text = "-" + _loc1_ + "%";
         design.Text_Sale.selectable = false;
         TuxUiUtils.createAutoTextField(design.Text_Message,"LIMITED_TIME_OFFER");
         timeText.setTextField(design.Text_Time);
         design.Container_Icon.addChild(data.itemData.icon);
         setPrice();
         LogicUpdater.register(this,"SaleButton");
      }
      
      private function disableButtonUntillServerResponse() : void
      {
         if(button)
         {
            button.setEnabled(false);
         }
         MessageCenter.addListener("ItemBought",enableButton);
      }
      
      private function enableButton(msg:Message) : void
      {
         MessageCenter.removeListener("ItemBought",enableButton);
         if(button)
         {
            button.setEnabled(true);
         }
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         var _loc2_:ShopItem = ShopItemManager.getShopItem(data.itemData);
         if(_loc2_)
         {
            if(_loc2_.itemData.type == "Weapon")
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getWeaponTooltipGraphics(),(parent as TuxUIScreen).tuxGame),design);
            }
            else if(_loc2_.itemData.type == "Clothing")
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getClothingTooltipGraphics(),(parent as TuxUIScreen).tuxGame),design);
            }
            else
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getBoosterTooltipGraphics(),(parent as TuxUIScreen).tuxGame),design);
            }
         }
         else
         {
            TooltipManager.showTooltip(new ItemTooltip(data.itemData.name,data.itemData.description),design);
         }
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
