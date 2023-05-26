package tuxwars.home.ui.screen.home
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.LogUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.money.MoneyState;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.net.CRMService;
   import tuxwars.net.JavaScriptServices;
   import tuxwars.net.objects.ShowPaymentObject;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class MoneyResourceElementScreen extends TuxUIElementScreen
   {
      
      private static const SALDO:String = "Saldo";
      
      private static const ADD_INGAME:String = "Button_Add_Coins";
      
      private static const ADD_PREMIUM:String = "Button_Add_Cash";
      
      private static const INGAME:String = "Text_Coins";
      
      private static const PREMIUM:String = "Text_Cash";
       
      
      private var inGameField:UIAutoTextField;
      
      private var premiumField:UIAutoTextField;
      
      private var _inGame:UIButton;
      
      private var _premium:UIButton;
      
      public function MoneyResourceElementScreen(from:MovieClip, game:TuxWarsGame)
      {
         var _loc3_:MovieClip = from.getChildByName("Saldo") as MovieClip;
         if(_loc3_)
         {
            _inGame = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Add_Coins",addInGameMoneyCallback,"BUTTON_ADD_INGAME");
            var _loc4_:Tutorial = Tutorial;
            _inGame.setEnabled(!tuxwars.tutorial.Tutorial._tutorial);
            _premium = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Add_Cash",addPremiumMoneyCallback,"BUTTON_ADD_PREMIUM");
            var _loc5_:Tutorial = Tutorial;
            _premium.setEnabled(!tuxwars.tutorial.Tutorial._tutorial);
            premiumField = TuxUiUtils.createAutoTextField(_loc3_.getChildByName("Text_Cash") as TextField,"0",null);
            inGameField = TuxUiUtils.createAutoTextField(_loc3_.getChildByName("Text_Coins") as TextField,"0",null);
            setInGameMoney(game.player.ingameMoney.toString());
            setPremiumMoney(game.player.premiumMoney.toString());
            _inGame.getDesignMovieClip().addEventListener("mouseOut",mouseOut,false,0,true);
            _premium.getDesignMovieClip().addEventListener("mouseOut",mouseOut,false,0,true);
            _inGame.getDesignMovieClip().addEventListener("mouseOver",mouseOver,false,0,true);
            _premium.getDesignMovieClip().addEventListener("mouseOver",mouseOver,false,0,true);
         }
         super(from,game);
      }
      
      override public function dispose() : void
      {
         if(_inGame)
         {
            _inGame.getDesignMovieClip().removeEventListener("mouseOut",mouseOut);
            _inGame.getDesignMovieClip().removeEventListener("mouseOver",mouseOver);
            _inGame.dispose();
            _inGame = null;
         }
         if(_premium)
         {
            _premium.getDesignMovieClip().removeEventListener("mouseOut",mouseOut);
            _premium.getDesignMovieClip().removeEventListener("mouseOver",mouseOver);
            _premium.dispose();
            _premium = null;
         }
         MessageCenter.removeListener("showMoneyState",openMoneyState);
         inGameField = null;
         premiumField = null;
         super.dispose();
      }
      
      public function setInGameMoney(value:String) : void
      {
         if(inGameField)
         {
            inGameField.setText(value);
         }
      }
      
      public function setPremiumMoney(value:String) : void
      {
         if(premiumField)
         {
            premiumField.setText(value);
         }
      }
      
      public function disableButtons() : void
      {
         _inGame.setEnabled(false);
         _premium.setEnabled(false);
      }
      
      public function enableButtons() : void
      {
         _inGame.setEnabled(true);
         _premium.setEnabled(true);
      }
      
      public function hideButtons() : void
      {
         _inGame.setVisible(false);
         _premium.setVisible(false);
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         var _loc2_:String = event.target.name == "Button_Add_Coins" ? "TOOLTIP_ADD_COINS" : "TOOLTIP_ADD_CASH";
         TooltipManager.showTooltip(new GenericTooltip(_loc2_),event.target as DisplayObject);
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      private function addInGameMoneyCallback(event:MouseEvent) : void
      {
         MessageCenter.addListener("showMoneyState",openMoneyState);
         CRMService.sendEvent("Game","Menu","Clicked","Add_Coins",!!game.homeState ? "MainMenu" : "BattleState");
         JavaScriptServices.callJavascript(new ShowPaymentObject("Coins"));
      }
      
      private function addPremiumMoneyCallback(event:MouseEvent) : void
      {
         MessageCenter.addListener("showMoneyState",openMoneyState);
         CRMService.sendEvent("Game","Menu","Clicked","Add_Cash",!!game.homeState ? "MainMenu" : "BattleState");
         if(ExternalInterface.available)
         {
            JavaScriptServices.callJavascript(new ShowPaymentObject("Cash"));
         }
         else
         {
            DCGame.setFullScreen(false,"showAll");
            MessageCenter.sendMessage("showMoneyState",false);
         }
      }
      
      private function openMoneyState(msg:Message) : void
      {
         var _loc2_:* = undefined;
         LogUtils.log("Entered the openMoneyState",null,2,"Messages",false,false,false);
         MessageCenter.removeListener("showMoneyState",openMoneyState);
         if(ExternalInterface.available)
         {
            _loc2_ = JSON.parse(msg.data);
            if(_loc2_ != null)
            {
               if(_loc2_.type == "Coins")
               {
                  game.homeState.changeState(new MoneyState(game,"popup_get_coins"));
               }
               else if(_loc2_.type == "Cash")
               {
                  game.homeState.changeState(new MoneyState(game,"popup_get_cash_new"));
               }
               else
               {
                  LogUtils.log("sendMessage: No eventListener for type: " + _loc2_.type,null,2,"Messages",false,false,false);
               }
            }
         }
         else
         {
            game.homeState.changeState(new MoneyState(game,"popup_get_cash_new"));
         }
      }
   }
}
