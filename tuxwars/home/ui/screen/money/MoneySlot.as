package tuxwars.home.ui.screen.money
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.money.CashPackage;
   import tuxwars.money.CoinPackage;
   import tuxwars.net.*;
   import tuxwars.utils.*;
   
   public class MoneySlot
   {
      private static const TEXT_FIELD:String = "Text";
      
      private static const TEXT_FREE_FIELD:String = "Text_Free";
      
      private static const BUTTON_BUY:String = "Button_Buy";
      
      private var moneyAmountTextField:UIAutoTextField;
      
      private var moneyAmountFreeTextField:UIAutoTextField;
      
      private var buttonBuy:UIButton;
      
      private var _design:MovieClip;
      
      private var _cashPackage:CashPackage;
      
      private var _coinPackage:CoinPackage;
      
      private var _game:TuxWarsGame;
      
      public function MoneySlot(param1:MovieClip, param2:TuxWarsGame)
      {
         super();
         this._design = param1;
         this._game = param2;
         this.moneyAmountTextField = new UIAutoTextField(param1.getChildByName("Text") as TextField);
         this.moneyAmountFreeTextField = new UIAutoTextField(param1.getChildByName("Text_Free") as TextField);
         this.buttonBuy = TuxUiUtils.createButton(UIButton,param1,"Button_Buy",this.buyCallback);
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
            this.buttonBuy.setText(ProjectManager.getText("BUTTON_MONEY_SCREEN_BUY",[this._cashPackage.creditCost.toString()]));
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
      
      private function buyCallback(param1:MouseEvent) : void
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
   }
}

