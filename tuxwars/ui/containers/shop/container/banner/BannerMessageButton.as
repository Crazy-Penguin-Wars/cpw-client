package tuxwars.ui.containers.shop.container.banner
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.home.states.equipment.EquipmentState;
   import tuxwars.home.states.money.MoneyState;
   import tuxwars.home.states.shop.ShopState;
   import tuxwars.home.states.tournament.TournamentEndState;
   import tuxwars.home.states.tournament.TournamentState;
   import tuxwars.home.states.vip.VIPState;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.net.CRMService;
   import tuxwars.net.JavaScriptServices;
   import tuxwars.net.messages.ShopItemMessage;
   import tuxwars.net.objects.ShowPaymentObject;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.nomoney.NoMoneyPopUpSubState;
   import tuxwars.utils.TuxUiUtils;
   
   public class BannerMessageButton extends BannerMessage
   {
       
      
      private var _buttonCash:UIButton;
      
      private var _buttonCoins:UIButton;
      
      private var _buttonGeneric:UIButton;
      
      public function BannerMessageButton(design:MovieClip, data:*, game:TuxWarsGame, parent:UIComponent = null)
      {
         super(design,data,game,parent);
         if(design.Message)
         {
            _buttonCash = TuxUiUtils.createButton(UIButton,design.Message,"Button_Buy_Cash",buttonPressed,null,data);
            _buttonCoins = TuxUiUtils.createButton(UIButton,design.Message,"Button_Buy_Coins",buttonPressed,null,data);
            _buttonGeneric = TuxUiUtils.createButton(UIButton,design.Message,"Button_Generic",buttonPressed,null,data);
            showButton();
         }
      }
      
      private function showButton() : void
      {
         var _loc1_:* = null;
         if(this._design.Message)
         {
            _buttonCash.setVisible(false);
            _buttonCoins.setVisible(false);
            _buttonGeneric.setVisible(false);
            if(bigShopItem)
            {
               if(bigShopItem.actionCode)
               {
                  _buttonGeneric.setText(bigShopItem.actionLabel);
                  if(bigShopItem.actionCode == "gototournament")
                  {
                     _buttonGeneric.setVisible(game.player.isTournamentAvailable());
                  }
                  else
                  {
                     _buttonGeneric.setVisible(true);
                  }
               }
               else if(bigShopItem.item)
               {
                  _loc1_ = ShopItemManager.getShopItemWithId(bigShopItem.item.id);
                  _buttonCash.setVisible(_loc1_.priceObject.isPremium);
                  _buttonCoins.setVisible(!_loc1_.priceObject.isPremium);
               }
            }
         }
      }
      
      private function get canAffordItem() : Boolean
      {
         var _loc1_:ShopItem = ShopItemManager.getShopItemWithId(bigShopItem.item.id);
         if(_loc1_.priceObject.isPremium)
         {
            return _loc1_.priceObject.priceValue <= game.player.premiumMoney;
         }
         return _loc1_.priceObject.priceValue <= game.player.ingameMoney;
      }
      
      private function doAction() : void
      {
         var _loc3_:* = null;
         var sound:* = null;
         var parentName:* = null;
         var sound2:* = null;
         var _loc1_:TuxWarsGame = game;
         LogUtils.log("Do Action: " + bigShopItem.actionCode,this,0,"UI",true,false,false);
         switch(bigShopItem.actionCode)
         {
            case "directbuy":
               _loc3_ = ShopItemManager.getShopItemWithId(bigShopItem.item.id);
               if(_loc3_)
               {
                  if(canAffordItem)
                  {
                     sound = Sounds.getSoundReference("Buy");
                     if(sound)
                     {
                        MessageCenter.sendEvent(new SoundMessage("PlaySound",sound.getMusicID(),sound.getStart(),sound.getType(),"PlaySound"));
                     }
                     MessageCenter.sendEvent(new ShopItemMessage(_loc3_,parent as TuxUIScreen));
                     parentName = CRMService.classChecker(parent as TuxUIScreen);
                     if(parentName != "NotSpecified")
                     {
                        CRMService.sendEvent("Action","Button_Pressed","Clicked",parentName,_loc3_.id);
                     }
                     if(_loc3_.priceObject.isPremium)
                     {
                        _buttonCash.setVisible(canAffordItem);
                     }
                     else
                     {
                        _buttonCoins.setVisible(canAffordItem);
                     }
                     disableButtonUntillServerResponse();
                     break;
                  }
                  sound2 = Sounds.getSoundReference("Nomoney");
                  if(sound2)
                  {
                     MessageCenter.sendEvent(new SoundMessage("PlaySound",sound2.getMusicID(),sound2.getStart(),sound2.getType(),"PlaySound"));
                  }
                  var _loc6_:PopUpManager = PopUpManager;
                  if(!tuxwars.ui.popups.PopUpManager._instance)
                  {
                     tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
                  }
                  tuxwars.ui.popups.PopUpManager._instance.triggerPopup(new NoMoneyPopUpSubState(game,_loc3_.priceObject.isPremium ? "Cash" : "Coins"),game.currentState);
                  break;
               }
               break;
            case "gotobuycoins":
               MessageCenter.addListener("showMoneyState",openMoneyState);
               JavaScriptServices.callJavascript(new ShowPaymentObject("Coins"));
               break;
            case "gotobuycash":
               MessageCenter.addListener("showMoneyState",openMoneyState);
               JavaScriptServices.callJavascript(new ShowPaymentObject("Cash"));
               break;
            case "gotocustomization":
               _loc1_.homeState.exitCurrentState();
               _loc1_.homeState.changeState(new EquipmentState(_loc1_));
               break;
            case "gotostore":
               game.homeState.exitCurrentState();
               _loc1_.homeState.changeState(new ShopState(_loc1_));
               break;
            case "gotovipmenu":
               game.homeState.exitCurrentState();
               _loc1_.homeState.changeState(new VIPState(_loc1_));
               break;
            case "gototournament":
               if(_loc1_.player.isTournamentAvailable())
               {
                  _loc1_.homeState.exitCurrentState();
                  if(_loc1_.player.isTournamentFinished())
                  {
                     _loc1_.homeState.changeState(new TournamentEndState(_loc1_));
                     break;
                  }
                  _loc1_.homeState.changeState(new TournamentState(_loc1_));
                  break;
               }
               break;
            case "gotourl":
               if(bigShopItem.actionParamTwo)
               {
                  DCUtils.loadPage(bigShopItem.actionParamOne,bigShopItem.actionParamTwo);
                  break;
               }
               DCUtils.loadPage(bigShopItem.actionParamOne);
               break;
            case "ok":
            default:
               super.exit();
         }
      }
      
      private function openMoneyState(msg:Message) : void
      {
         LogUtils.log("Entered the openMoneyState",null,2,"Messages",false,false,false);
         MessageCenter.removeListener("showMoneyState",openMoneyState);
         var _loc2_:* = JSON.parse(msg.data);
         if(_loc2_ != null)
         {
            if(_loc2_.type == "Coins")
            {
               game.homeState.changeState(new MoneyState(game,"popup_get_coins"));
               CRMService.sendEvent("PopUp","Buy_Coins_Clicked","BannerMessage");
            }
            else if(_loc2_.type == "Cash")
            {
               game.homeState.changeState(new MoneyState(game,"popup_get_cash_new"));
               CRMService.sendEvent("PopUp","Buy_Cash_Clicked","BannerMessage");
            }
            else
            {
               LogUtils.log("sendMessage: No eventListener for type: " + _loc2_.type,null,2,"Messages",false,false,false);
            }
         }
      }
      
      private function buttonPressed(mouseEvent:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(bigShopItem.actionCode)
         {
            doAction();
         }
         else if(bigShopItem.item)
         {
            _loc2_ = ShopItemManager.getShopItem(bigShopItem.item);
            if(_loc2_)
            {
               MessageCenter.sendMessage("BuyItem",_loc2_);
               CRMService.sendEvent("Action","Button_Pressed","Clicked","ShopBanner",_loc2_.id);
            }
         }
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("ItemBought",enableButton);
         MessageCenter.removeListener("showMoneyState",openMoneyState);
         if(this._design.Message)
         {
            _buttonCash.dispose();
            _buttonCash = null;
            _buttonCoins.dispose();
            _buttonCoins = null;
            _buttonGeneric.dispose();
            _buttonGeneric = null;
         }
         super.dispose();
      }
      
      private function disableButtonUntillServerResponse() : void
      {
         _buttonCash.setEnabled(false);
         _buttonCoins.setEnabled(false);
         _buttonGeneric.setEnabled(false);
         MessageCenter.addListener("ItemBought",enableButton);
      }
      
      private function enableButton(msg:Message) : void
      {
         MessageCenter.removeListener("ItemBought",enableButton);
         var _loc2_:Boolean = canAffordItem;
         _buttonCash.setEnabled(_loc2_);
         _buttonCoins.setEnabled(_loc2_);
         _buttonGeneric.setEnabled(_loc2_);
      }
      
      override public function activateTutorial(itemID:String, arrow:String, addTutorialArrow:Function) : void
      {
         super.activateTutorial(itemID,arrow,addTutorialArrow);
      }
   }
}
