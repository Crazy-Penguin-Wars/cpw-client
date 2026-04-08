package tuxwars.ui.popups.logic.crm
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.home.states.equipment.*;
   import tuxwars.home.states.money.*;
   import tuxwars.home.states.shop.*;
   import tuxwars.home.states.tournament.*;
   import tuxwars.home.states.vip.*;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.*;
   import tuxwars.net.*;
   import tuxwars.net.messages.*;
   import tuxwars.net.objects.*;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.logic.message.MessagePopUpLogic;
   import tuxwars.ui.popups.screen.crm.*;
   import tuxwars.ui.popups.states.nomoney.*;
   
   public class CRMMessagePopUpLogic extends MessagePopUpLogic
   {
      private static const ON_DISPLAY:String = "ondisplay";
      
      private static const ON_CLICK:String = "onclick";
      
      private static const ON_CLOSE:String = "onclose";
      
      public static const OK:String = "ok";
      
      public static const DIRECT_BUY:String = "directbuy";
      
      public static const GO_TO_URL:String = "gotourl";
      
      public static const GO_TO_STORE:String = "gotostore";
      
      public static const GO_TO_CUSTOMIZATION:String = "gotocustomization";
      
      public static const GO_TO_VIP_MENU:String = "gotovipmenu";
      
      public static const GO_TO_BUY_CASH:String = "gotobuycash";
      
      public static const GO_TO_BUY_COINS:String = "gotobuycoins";
      
      public static const GO_TO_TOURNAMENT:String = "gototournament";
      
      private var shopItem:ShopItem;
      
      public function CRMMessagePopUpLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function init(param1:*) : void
      {
         assert("CRM params is null",true,param1 is CRMPopUpData);
         super.init(param1);
         if(!this.popupData.sendCRMEventTracking("ondisplay"))
         {
            CRMService.sendEvent("Game","Shown","CRM_Message_PopUp");
         }
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("ItemBought",this.enableButton);
         MessageCenter.removeListener("showMoneyState",this.openMoneyState);
         this.shopItem = null;
         super.dispose();
      }
      
      override public function exit() : void
      {
         if(!this.popupData.sendCRMEventTracking("onclose"))
         {
            CRMService.sendEvent("Game","CRM_Message","Clicked","Close_CRM_Message");
         }
         super.exit();
      }
      
      public function runAction() : void
      {
         var _loc1_:SoundReference = null;
         var _loc2_:String = null;
         var _loc3_:SoundReference = null;
         if(!this.popupData.sendCRMEventTracking("onclick"))
         {
            CRMService.sendEvent("Game","CRM_Message","Clicked","Click_CRM_Message");
         }
         var _loc4_:TuxWarsGame = game;
         switch(this.popupData.actionCode)
         {
            case "directbuy":
               this.shopItem = ShopItemManager.getShopItemWithId(this.popupData.actionParameters.id);
               if(this.shopItem)
               {
                  if(this.canAffordItem)
                  {
                     _loc1_ = Sounds.getSoundReference("Buy");
                     if(_loc1_)
                     {
                        MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
                     }
                     MessageCenter.sendEvent(new ShopItemMessage(this.shopItem,this.crmMessagePopUpScreen));
                     _loc2_ = CRMService.classChecker(this.crmMessagePopUpScreen);
                     if(_loc2_ != "NotSpecified")
                     {
                        CRMService.sendEvent("Action","Button_Pressed","Clicked",_loc2_,this.shopItem.id);
                     }
                     if(this.shopItem.priceObject.isPremium)
                     {
                        this.crmMessagePopUpScreen.cashButton.setVisible(this.canAffordItem);
                     }
                     else
                     {
                        this.crmMessagePopUpScreen.coinsButton.setVisible(this.canAffordItem);
                     }
                     this.disableButtonUntillServerResponse();
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
                     PopUpManager.instance.triggerPopup(new NoMoneyPopUpSubState(game,!!this.shopItem.priceObject.isPremium ? "Cash" : "Coins"),game.currentState);
                  }
               }
               break;
            case "gotobuycoins":
               super.exit();
               MessageCenter.addListener("showMoneyState",this.openMoneyState);
               JavaScriptServices.callJavascript(new ShowPaymentObject("Coins"));
               break;
            case "gotobuycash":
               super.exit();
               MessageCenter.addListener("showMoneyState",this.openMoneyState);
               JavaScriptServices.callJavascript(new ShowPaymentObject("Cash"));
               break;
            case "gotocustomization":
               super.exit();
               _loc4_.homeState.changeState(new EquipmentState(_loc4_));
               break;
            case "gotostore":
               super.exit();
               _loc4_.homeState.changeState(new ShopState(_loc4_));
               break;
            case "gotovipmenu":
               super.exit();
               _loc4_.homeState.changeState(new VIPState(_loc4_));
               break;
            case "gototournament":
               if(_loc4_.player.isTournamentAvailable())
               {
                  super.exit();
                  if(_loc4_.player.isTournamentFinished())
                  {
                     _loc4_.homeState.changeState(new TournamentEndState(_loc4_));
                  }
                  else
                  {
                     _loc4_.homeState.changeState(new TournamentState(_loc4_));
                  }
               }
               break;
            case "gotourl":
               DCUtils.loadPage(this.popupData.getActionParameterValue("url"),this.popupData.getActionParameterValue("window"));
               break;
            case "ok":
            default:
               super.exit();
         }
      }
      
      private function disableButtonUntillServerResponse() : void
      {
         this.crmMessagePopUpScreen.okButton.setEnabled(false);
         MessageCenter.addListener("ItemBought",this.enableButton);
      }
      
      private function enableButton(param1:Message) : void
      {
         MessageCenter.removeListener("ItemBought",this.enableButton);
         this.crmMessagePopUpScreen.okButton.setEnabled(this.canAffordItem);
      }
      
      private function get canAffordItem() : Boolean
      {
         if(this.shopItem.priceObject.isPremium)
         {
            return this.shopItem.priceObject.priceValue <= game.player.premiumMoney;
         }
         return this.shopItem.priceObject.priceValue <= game.player.ingameMoney;
      }
      
      private function openMoneyState(param1:Message) : void
      {
         LogUtils.log("Entered the openMoneyState",null,2,"Messages",true,false,false);
         MessageCenter.removeListener("showMoneyState",this.openMoneyState);
         var _loc2_:* = JSON.parse(param1.data);
         if(_loc2_ != null)
         {
            if(_loc2_.type == "Coins")
            {
               game.homeState.changeState(new MoneyState(game,"popup_get_coins"));
               CRMService.sendEvent("PopUp","Buy_Coins_Clicked","CRMPopup");
            }
            else if(_loc2_.type == "Cash")
            {
               game.homeState.changeState(new MoneyState(game,"popup_get_cash_new"));
               CRMService.sendEvent("PopUp","Buy_Cash_Clicked","CRMPopup");
            }
            else
            {
               LogUtils.log("sendMessage: No eventListener for type: " + _loc2_.type,null,2,"Messages",false,false,false);
            }
         }
      }
      
      override public function get headerText() : String
      {
         return this.popupData.title;
      }
      
      override public function get messageText() : String
      {
         return this.popupData.description;
      }
      
      override public function get picture() : String
      {
         return this.popupData.imageURL;
      }
      
      private function get popupData() : CRMPopUpData
      {
         return params;
      }
      
      private function get crmMessagePopUpScreen() : CRMMessagePopUpScreen
      {
         return screen as CRMMessagePopUpScreen;
      }
   }
}

