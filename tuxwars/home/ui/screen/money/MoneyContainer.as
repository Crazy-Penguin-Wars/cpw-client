package tuxwars.home.ui.screen.money
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.text.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.money.CashPackage;
   import tuxwars.money.CoinPackage;
   import tuxwars.net.*;
   import tuxwars.utils.*;
   
   public class MoneyContainer
   {
      private static const TEXT_FIELD:String = "Text";
      
      private static const TEXT_FREE_FIELD:String = "Text_Free";
      
      private static const BUY_TEXT:String = "buy_text";
      
      private static const BUY_DISCOUNT_TEXT:String = "buy_text_discount";
      
      private var moneyAmountTextField:UIAutoTextField;
      
      private var moneyAmountFreeTextField:UIAutoTextField;
      
      private var buttonBuy:UIAutoTextField;
      
      private var buttonBuyDiscount:UIAutoTextField;
      
      private var _design:MovieClip;
      
      private var _discount:Boolean;
      
      private var _cashPackage:CashPackage;
      
      private var _coinPackage:CoinPackage;
      
      private var _game:TuxWarsGame;
      
      private var mBackgroundTab:MovieClip;
      
      public function MoneyContainer(param1:MovieClip, param2:TuxWarsGame, param3:Boolean)
      {
         super();
         this._design = param1;
         this._game = param2;
         this._discount = param3;
         this.mBackgroundTab = param1["back"];
         if(this.mBackgroundTab)
         {
            this.mBackgroundTab.gotoAndStop(1);
         }
         this._design.addEventListener("click",this.clickHandler);
         this._design.addEventListener("rollOver",this.rollOverHandler);
         this._design.addEventListener("rollOut",this.rollOutHandler);
         this.moneyAmountTextField = new UIAutoTextField(param1.getChildByName("Text") as TextField);
         this.moneyAmountFreeTextField = new UIAutoTextField(param1.getChildByName("Text_Free") as TextField);
         this.buttonBuy = new UIAutoTextField(param1.getChildByName("buy_text") as TextField);
         if(param3)
         {
            this.buttonBuyDiscount = new UIAutoTextField(param1.getChildByName("buy_text_discount") as TextField);
         }
         this.setData(null,null);
      }
      
      public function setData(param1:CashPackage, param2:CoinPackage) : void
      {
         this._cashPackage = param1;
         this._coinPackage = param2;
         if(this._cashPackage)
         {
            this.design.visible = true;
            this.moneyAmountTextField.setText(TuxUiUtils.numberFormat(this._cashPackage.amount,0,false,false));
            if(this._cashPackage.extraAmount > 0)
            {
               this.moneyAmountFreeTextField.setText(ProjectManager.getText("MONEY_SCREEN_EXTRA_TEXT",[this._cashPackage.extraAmount.toString()]));
            }
            else
            {
               this.moneyAmountFreeTextField.setText("");
            }
            this.buttonBuy.setText(ProjectManager.getText("BUTTON_MONEY_SCREEN_BUY",[this._cashPackage.creditOld.toString()]));
            if(this._discount)
            {
               this.buttonBuyDiscount.setText(ProjectManager.getText("BUTTON_MONEY_SCREEN_BUY",[this._cashPackage.creditCost.toString()]));
            }
         }
         else if(this._coinPackage)
         {
            this.design.visible = true;
            this.moneyAmountTextField.setText(TuxUiUtils.numberFormat(this._coinPackage.amount,0,false,false));
            if(this._coinPackage.extraAmount > 0)
            {
               this.moneyAmountFreeTextField.setText(ProjectManager.getText("MONEY_SCREEN_EXTRA_TEXT",[this._coinPackage.extraAmount.toString()]));
            }
            else
            {
               this.moneyAmountFreeTextField.setText("");
            }
            this.buttonBuy.setText(ProjectManager.getText("BUTTON_MONEY_SCREEN_BUY",[this._coinPackage.creditCost.toString()]));
         }
         else
         {
            this.moneyAmountTextField.setText("");
            this.moneyAmountFreeTextField.setText("");
            this.design.visible = false;
         }
      }
      
      public function get design() : MovieClip
      {
         return this._design;
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(this._cashPackage)
         {
            CRMService.sendEvent("Economy","Purchase PC","Started",this._cashPackage.id);
            MoneyService.purchaseMoney(this._cashPackage.id,this._cashPackage.creditCost,"CASH","PURCHASE_CASH");
         }
         else if(this._coinPackage)
         {
            CRMService.sendEvent("Economy","Purchase GC","Started",this._coinPackage.id);
            MoneyService.purchaseMoney(this._coinPackage.id,this._coinPackage.creditCost,"COINS","PURCHASE_COINS");
         }
      }
      
      private function rollOutHandler(param1:MouseEvent) : void
      {
         this.unSelect();
      }
      
      private function rollOverHandler(param1:MouseEvent) : void
      {
         this.select();
      }
      
      private function select() : void
      {
         if(this.mBackgroundTab)
         {
            this.mBackgroundTab.gotoAndStop(2);
         }
      }
      
      private function unSelect() : void
      {
         if(this.mBackgroundTab)
         {
            this.mBackgroundTab.gotoAndStop(1);
         }
      }
   }
}

