package tuxwars.ui.popups.logic.crm
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import no.olog.utilfunctions.assert;
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
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.net.CRMService;
   import tuxwars.net.JavaScriptServices;
   import tuxwars.net.messages.ShopItemMessage;
   import tuxwars.net.objects.ShowPaymentObject;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.logic.message.MessagePopUpLogic;
   import tuxwars.ui.popups.screen.crm.CRMMessagePopUpScreen;
   import tuxwars.ui.popups.states.nomoney.NoMoneyPopUpSubState;
   
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
      
      public function CRMMessagePopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      override public function init(params:*) : void
      {
         assert("CRM params is null",true,params is CRMPopUpData);
         super.init(params);
         if(!popupData.sendCRMEventTracking("ondisplay"))
         {
            CRMService.sendEvent("Game","Shown","CRM_Message_PopUp");
         }
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("ItemBought",enableButton);
         MessageCenter.removeListener("showMoneyState",openMoneyState);
         shopItem = null;
         super.dispose();
      }
      
      override public function exit() : void
      {
         if(!popupData.sendCRMEventTracking("onclose"))
         {
            CRMService.sendEvent("Game","CRM_Message","Clicked","Close_CRM_Message");
         }
         super.exit();
      }
      
      public function runAction() : void
      {
         var sound:* = null;
         var parentName:* = null;
         var sound2:* = null;
         if(!popupData.sendCRMEventTracking("onclick"))
         {
            CRMService.sendEvent("Game","CRM_Message","Clicked","Click_CRM_Message");
         }
         var _loc1_:TuxWarsGame = game;
         switch(popupData.actionCode)
         {
            case "directbuy":
               shopItem = ShopItemManager.getShopItemWithId(popupData.actionParameters.id);
               if(shopItem)
               {
                  if(canAffordItem)
                  {
                     sound = Sounds.getSoundReference("Buy");
                     if(sound)
                     {
                        MessageCenter.sendEvent(new SoundMessage("PlaySound",sound.getMusicID(),sound.getStart(),sound.getType(),"PlaySound"));
                     }
                     MessageCenter.sendEvent(new ShopItemMessage(shopItem,crmMessagePopUpScreen));
                     parentName = CRMService.classChecker(crmMessagePopUpScreen);
                     if(parentName != "NotSpecified")
                     {
                        CRMService.sendEvent("Action","Button_Pressed","Clicked",parentName,shopItem.id);
                     }
                     if(shopItem.priceObject.isPremium)
                     {
                        crmMessagePopUpScreen.cashButton.setVisible(canAffordItem);
                     }
                     else
                     {
                        crmMessagePopUpScreen.coinsButton.setVisible(canAffordItem);
                     }
                     disableButtonUntillServerResponse();
                     break;
                  }
                  sound2 = Sounds.getSoundReference("Nomoney");
                  if(sound2)
                  {
                     MessageCenter.sendEvent(new SoundMessage("PlaySound",sound2.getMusicID(),sound2.getStart(),sound2.getType(),"PlaySound"));
                  }
                  var _loc5_:PopUpManager = PopUpManager;
                  if(!tuxwars.ui.popups.PopUpManager._instance)
                  {
                     tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
                  }
                  tuxwars.ui.popups.PopUpManager._instance.triggerPopup(new NoMoneyPopUpSubState(game,shopItem.priceObject.isPremium ? "Cash" : "Coins"),game.currentState);
                  break;
               }
               break;
            case "gotobuycoins":
               super.exit();
               MessageCenter.addListener("showMoneyState",openMoneyState);
               JavaScriptServices.callJavascript(new ShowPaymentObject("Coins"));
               break;
            case "gotobuycash":
               super.exit();
               MessageCenter.addListener("showMoneyState",openMoneyState);
               JavaScriptServices.callJavascript(new ShowPaymentObject("Cash"));
               break;
            case "gotocustomization":
               super.exit();
               _loc1_.homeState.changeState(new EquipmentState(_loc1_));
               break;
            case "gotostore":
               super.exit();
               _loc1_.homeState.changeState(new ShopState(_loc1_));
               break;
            case "gotovipmenu":
               super.exit();
               _loc1_.homeState.changeState(new VIPState(_loc1_));
               break;
            case "gototournament":
               if(_loc1_.player.isTournamentAvailable())
               {
                  super.exit();
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
               DCUtils.loadPage(popupData.getActionParameterValue("url"),popupData.getActionParameterValue("window"));
               break;
            case "ok":
            default:
               super.exit();
         }
      }
      
      private function disableButtonUntillServerResponse() : void
      {
         crmMessagePopUpScreen.okButton.setEnabled(false);
         MessageCenter.addListener("ItemBought",enableButton);
      }
      
      private function enableButton(msg:Message) : void
      {
         MessageCenter.removeListener("ItemBought",enableButton);
         crmMessagePopUpScreen.okButton.setEnabled(canAffordItem);
      }
      
      private function get canAffordItem() : Boolean
      {
         if(shopItem.priceObject.isPremium)
         {
            return shopItem.priceObject.priceValue <= game.player.premiumMoney;
         }
         return shopItem.priceObject.priceValue <= game.player.ingameMoney;
      }
      
      private function openMoneyState(msg:Message) : void
      {
         LogUtils.log("Entered the openMoneyState",null,2,"Messages",true,false,false);
         MessageCenter.removeListener("showMoneyState",openMoneyState);
         var _loc2_:* = JSON.parse(msg.data);
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
         return popupData.title;
      }
      
      override public function get messageText() : String
      {
         return popupData.description;
      }
      
      override public function get picture() : String
      {
         return popupData.imageURL;
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
