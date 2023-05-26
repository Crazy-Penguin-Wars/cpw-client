package tuxwars.home.ui.screen.money
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.money.CashPackage;
   import tuxwars.money.CoinPackage;
   import tuxwars.net.CRMService;
   import tuxwars.net.MoneyService;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function MoneySlot(design:MovieClip, game:TuxWarsGame)
      {
         super();
         _design = design;
         _game = game;
         moneyAmountTextField = new UIAutoTextField(design.getChildByName("Text") as TextField);
         moneyAmountFreeTextField = new UIAutoTextField(design.getChildByName("Text_Free") as TextField);
         buttonBuy = TuxUiUtils.createButton(UIButton,design,"Button_Buy",buyCallback);
         setData(null,null);
      }
      
      public function setData(cash:CashPackage, coin:CoinPackage) : void
      {
         _cashPackage = cash;
         _coinPackage = coin;
         if(_cashPackage)
         {
            design.visible = true;
            moneyAmountTextField.setText(TuxUiUtils.numberFormat(_cashPackage.amount,0,false,false));
            if(_cashPackage.extraAmount > 0)
            {
               moneyAmountFreeTextField.setText(ProjectManager.getText("MONEY_SCREEN_EXTRA_TEXT",[_cashPackage.extraAmount.toString()]));
            }
            else
            {
               moneyAmountFreeTextField.setText("");
            }
            buttonBuy.setText(ProjectManager.getText("BUTTON_MONEY_SCREEN_BUY",[_cashPackage.creditCost.toString()]));
         }
         else if(_coinPackage)
         {
            design.visible = true;
            moneyAmountTextField.setText(TuxUiUtils.numberFormat(_coinPackage.amount,0,false,false));
            if(_coinPackage.extraAmount > 0)
            {
               moneyAmountFreeTextField.setText(ProjectManager.getText("MONEY_SCREEN_EXTRA_TEXT",[_coinPackage.extraAmount.toString()]));
            }
            else
            {
               moneyAmountFreeTextField.setText("");
            }
            buttonBuy.setText(ProjectManager.getText("BUTTON_MONEY_SCREEN_BUY",[_coinPackage.creditCost.toString()]));
         }
         else
         {
            moneyAmountTextField.setText("");
            moneyAmountFreeTextField.setText("");
            design.visible = false;
         }
      }
      
      public function get design() : MovieClip
      {
         return _design;
      }
      
      private function buyCallback(event:MouseEvent) : void
      {
         if(_cashPackage)
         {
            CRMService.sendEvent("Economy","Purchase PC","Started",_cashPackage.id);
            MoneyService.purchaseMoney(_cashPackage.id,_cashPackage.creditCost,"CASH","PURCHASE_CASH");
         }
         else if(_coinPackage)
         {
            CRMService.sendEvent("Economy","Purchase GC","Started",_coinPackage.id);
            MoneyService.purchaseMoney(_coinPackage.id,_coinPackage.creditCost,"COINS","PURCHASE_COINS");
         }
      }
   }
}
