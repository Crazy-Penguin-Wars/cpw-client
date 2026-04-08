package tuxwars.ui.containers.shop.container.banner
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.home.states.equipment.*;
   import tuxwars.home.states.money.*;
   import tuxwars.home.states.shop.*;
   import tuxwars.home.states.tournament.*;
   import tuxwars.home.states.vip.*;
   import tuxwars.home.ui.screen.*;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.*;
   import tuxwars.net.*;
   import tuxwars.net.messages.*;
   import tuxwars.net.objects.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.nomoney.*;
   import tuxwars.utils.*;
   
   public class BannerMessageButton extends BannerMessage
   {
      private var _buttonCash:UIButton;
      
      private var _buttonCoins:UIButton;
      
      private var _buttonGeneric:UIButton;
      
      public function BannerMessageButton(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:UIComponent = null)
      {
         super(param1,param2,param3,param4);
         if(param1.Message)
         {
            this._buttonCash = TuxUiUtils.createButton(UIButton,param1.Message,"Button_Buy_Cash",this.buttonPressed,null,param2);
            this._buttonCoins = TuxUiUtils.createButton(UIButton,param1.Message,"Button_Buy_Coins",this.buttonPressed,null,param2);
            this._buttonGeneric = TuxUiUtils.createButton(UIButton,param1.Message,"Button_Generic",this.buttonPressed,null,param2);
            this.showButton();
         }
      }
      
      private function showButton() : void
      {
         var _loc1_:ShopItem = null;
         if(this._design.Message)
         {
            this._buttonCash.setVisible(false);
            this._buttonCoins.setVisible(false);
            this._buttonGeneric.setVisible(false);
            if(bigShopItem)
            {
               if(bigShopItem.actionCode)
               {
                  this._buttonGeneric.setText(bigShopItem.actionLabel);
                  if(bigShopItem.actionCode == "gototournament")
                  {
                     this._buttonGeneric.setVisible(game.player.isTournamentAvailable());
                  }
                  else
                  {
                     this._buttonGeneric.setVisible(true);
                  }
               }
               else if(bigShopItem.item)
               {
                  _loc1_ = ShopItemManager.getShopItemWithId(bigShopItem.item.id);
                  this._buttonCash.setVisible(_loc1_.priceObject.isPremium);
                  this._buttonCoins.setVisible(!_loc1_.priceObject.isPremium);
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
         var _loc1_:ShopItem = null;
         var _loc2_:SoundReference = null;
         var _loc3_:String = null;
         var _loc4_:SoundReference = null;
         var _loc5_:TuxWarsGame = game;
         LogUtils.log("Do Action: " + bigShopItem.actionCode,this,0,"UI",true,false,false);
         switch(bigShopItem.actionCode)
         {
            case "directbuy":
               _loc1_ = ShopItemManager.getShopItemWithId(bigShopItem.item.id);
               if(_loc1_)
               {
                  if(this.canAffordItem)
                  {
                     _loc2_ = Sounds.getSoundReference("Buy");
                     if(_loc2_)
                     {
                        MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
                     }
                     MessageCenter.sendEvent(new ShopItemMessage(_loc1_,parent as TuxUIScreen));
                     _loc3_ = CRMService.classChecker(parent as TuxUIScreen);
                     if(_loc3_ != "NotSpecified")
                     {
                        CRMService.sendEvent("Action","Button_Pressed","Clicked",_loc3_,_loc1_.id);
                     }
                     if(_loc1_.priceObject.isPremium)
                     {
                        this._buttonCash.setVisible(this.canAffordItem);
                     }
                     else
                     {
                        this._buttonCoins.setVisible(this.canAffordItem);
                     }
                     this.disableButtonUntillServerResponse();
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
                     PopUpManager.instance.triggerPopup(new NoMoneyPopUpSubState(game,_loc1_.priceObject.isPremium ? "Cash" : "Coins"),game.currentState);
                  }
               }
               break;
            case "gotobuycoins":
               MessageCenter.addListener("showMoneyState",this.openMoneyState);
               JavaScriptServices.callJavascript(new ShowPaymentObject("Coins"));
               break;
            case "gotobuycash":
               MessageCenter.addListener("showMoneyState",this.openMoneyState);
               JavaScriptServices.callJavascript(new ShowPaymentObject("Cash"));
               break;
            case "gotocustomization":
               _loc5_.homeState.exitCurrentState();
               _loc5_.homeState.changeState(new EquipmentState(_loc5_));
               break;
            case "gotostore":
               game.homeState.exitCurrentState();
               _loc5_.homeState.changeState(new ShopState(_loc5_));
               break;
            case "gotovipmenu":
               game.homeState.exitCurrentState();
               _loc5_.homeState.changeState(new VIPState(_loc5_));
               break;
            case "gototournament":
               if(_loc5_.player.isTournamentAvailable())
               {
                  _loc5_.homeState.exitCurrentState();
                  if(_loc5_.player.isTournamentFinished())
                  {
                     _loc5_.homeState.changeState(new TournamentEndState(_loc5_));
                  }
                  else
                  {
                     _loc5_.homeState.changeState(new TournamentState(_loc5_));
                  }
               }
               break;
            case "gotourl":
               if(bigShopItem.actionParamTwo)
               {
                  DCUtils.loadPage(bigShopItem.actionParamOne,bigShopItem.actionParamTwo);
               }
               else
               {
                  DCUtils.loadPage(bigShopItem.actionParamOne);
               }
               break;
            case "ok":
            default:
               super.exit();
         }
      }
      
      private function openMoneyState(param1:Message) : void
      {
         LogUtils.log("Entered the openMoneyState",null,2,"Messages",false,false,false);
         MessageCenter.removeListener("showMoneyState",this.openMoneyState);
         var _loc2_:* = JSON.parse(param1.data);
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
      
      private function buttonPressed(param1:MouseEvent) : void
      {
         var _loc2_:ShopItem = null;
         if(bigShopItem.actionCode)
         {
            this.doAction();
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
         MessageCenter.removeListener("ItemBought",this.enableButton);
         MessageCenter.removeListener("showMoneyState",this.openMoneyState);
         if(this._design.Message)
         {
            this._buttonCash.dispose();
            this._buttonCash = null;
            this._buttonCoins.dispose();
            this._buttonCoins = null;
            this._buttonGeneric.dispose();
            this._buttonGeneric = null;
         }
         super.dispose();
      }
      
      private function disableButtonUntillServerResponse() : void
      {
         this._buttonCash.setEnabled(false);
         this._buttonCoins.setEnabled(false);
         this._buttonGeneric.setEnabled(false);
         MessageCenter.addListener("ItemBought",this.enableButton);
      }
      
      private function enableButton(param1:Message) : void
      {
         MessageCenter.removeListener("ItemBought",this.enableButton);
         var _loc2_:Boolean = Boolean(this.canAffordItem);
         this._buttonCash.setEnabled(_loc2_);
         this._buttonCoins.setEnabled(_loc2_);
         this._buttonGeneric.setEnabled(_loc2_);
      }
      
      override public function activateTutorial(param1:String, param2:String, param3:Function) : void
      {
         super.activateTutorial(param1,param2,param3);
      }
   }
}

