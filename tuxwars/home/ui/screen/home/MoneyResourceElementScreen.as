package tuxwars.home.ui.screen.home
{
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.external.*;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.money.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.net.*;
   import tuxwars.net.objects.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
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
      
      public function MoneyResourceElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         var _loc3_:MovieClip = param1.getChildByName("Saldo") as MovieClip;
         if(_loc3_)
         {
            this._inGame = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Add_Coins",this.addInGameMoneyCallback,"BUTTON_ADD_INGAME");
            this._inGame.setEnabled(!Tutorial._tutorial);
            this._premium = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Add_Cash",this.addPremiumMoneyCallback,"BUTTON_ADD_PREMIUM");
            this._premium.setEnabled(!Tutorial._tutorial);
            this.premiumField = TuxUiUtils.createAutoTextField(_loc3_.getChildByName("Text_Cash") as TextField,"0",null);
            this.inGameField = TuxUiUtils.createAutoTextField(_loc3_.getChildByName("Text_Coins") as TextField,"0",null);
            this.setInGameMoney(param2.player.ingameMoney.toString());
            this.setPremiumMoney(param2.player.premiumMoney.toString());
            this._inGame.getDesignMovieClip().addEventListener("mouseOut",this.mouseOut,false,0,true);
            this._premium.getDesignMovieClip().addEventListener("mouseOut",this.mouseOut,false,0,true);
            this._inGame.getDesignMovieClip().addEventListener("mouseOver",this.mouseOver,false,0,true);
            this._premium.getDesignMovieClip().addEventListener("mouseOver",this.mouseOver,false,0,true);
         }
         super(param1,param2);
      }
      
      override public function dispose() : void
      {
         if(this._inGame)
         {
            this._inGame.getDesignMovieClip().removeEventListener("mouseOut",this.mouseOut);
            this._inGame.getDesignMovieClip().removeEventListener("mouseOver",this.mouseOver);
            this._inGame.dispose();
            this._inGame = null;
         }
         if(this._premium)
         {
            this._premium.getDesignMovieClip().removeEventListener("mouseOut",this.mouseOut);
            this._premium.getDesignMovieClip().removeEventListener("mouseOver",this.mouseOver);
            this._premium.dispose();
            this._premium = null;
         }
         MessageCenter.removeListener("showMoneyState",this.openMoneyState);
         this.inGameField = null;
         this.premiumField = null;
         super.dispose();
      }
      
      public function setInGameMoney(param1:String) : void
      {
         if(this.inGameField)
         {
            this.inGameField.setText(param1);
         }
      }
      
      public function setPremiumMoney(param1:String) : void
      {
         if(this.premiumField)
         {
            this.premiumField.setText(param1);
         }
      }
      
      public function disableButtons() : void
      {
         this._inGame.setEnabled(false);
         this._premium.setEnabled(false);
      }
      
      public function enableButtons() : void
      {
         this._inGame.setEnabled(true);
         this._premium.setEnabled(true);
      }
      
      public function hideButtons() : void
      {
         this._inGame.setVisible(false);
         this._premium.setVisible(false);
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name == "Button_Add_Coins" ? "TOOLTIP_ADD_COINS" : "TOOLTIP_ADD_CASH";
         TooltipManager.showTooltip(new GenericTooltip(_loc2_),param1.target as DisplayObject);
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      private function addInGameMoneyCallback(param1:MouseEvent) : void
      {
         MessageCenter.addListener("showMoneyState",this.openMoneyState);
         CRMService.sendEvent("Game","Menu","Clicked","Add_Coins",!!game.homeState ? "MainMenu" : "BattleState");
         JavaScriptServices.callJavascript(new ShowPaymentObject("Coins"));
      }
      
      private function addPremiumMoneyCallback(param1:MouseEvent) : void
      {
         MessageCenter.addListener("showMoneyState",this.openMoneyState);
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
      
      private function openMoneyState(param1:Message) : void
      {
         var _loc2_:* = undefined;
         LogUtils.log("Entered the openMoneyState",null,2,"Messages",false,false,false);
         MessageCenter.removeListener("showMoneyState",this.openMoneyState);
         if(ExternalInterface.available)
         {
            _loc2_ = JSON.parse(param1.data);
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

