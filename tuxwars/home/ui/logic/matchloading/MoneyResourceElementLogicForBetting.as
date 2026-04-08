package tuxwars.home.ui.logic.matchloading
{
   import com.dchoc.messages.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.events.IngameMoneyChangedMessage;
   import tuxwars.events.PremiumMoneyChangedMessage;
   import tuxwars.home.ui.logic.home.MoneyResourceElementLogic;
   import tuxwars.home.ui.screen.home.MoneyResourceElementScreen;
   
   public class MoneyResourceElementLogicForBetting extends MoneyResourceElementLogic
   {
      private var cashBet:int;
      
      private var coinBet:int;
      
      public function MoneyResourceElementLogicForBetting(param1:TuxWarsGame)
      {
         super(param1);
         MessageCenter.addListener("IngameMoneyChanged",this.inGameMoneyChanged);
         MessageCenter.addListener("PremiumMoneyChanged",this.premiumMoneyChanged);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("IngameMoneyChanged",this.inGameMoneyChanged);
         MessageCenter.removeListener("PremiumMoneyChanged",this.premiumMoneyChanged);
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
      }
      
      private function premiumMoneyChanged(param1:PremiumMoneyChangedMessage) : void
      {
         this.moneyResourceElementScreen.setPremiumMoney(param1.premiumMoney.toString());
      }
      
      private function inGameMoneyChanged(param1:IngameMoneyChangedMessage) : void
      {
         this.moneyResourceElementScreen.setInGameMoney(param1.ingameMoney.toString());
      }
      
      private function get moneyResourceElementScreen() : MoneyResourceElementScreen
      {
         return screen;
      }
      
      public function setPremiumBet(param1:int) : void
      {
         this.cashBet = param1;
      }
      
      public function setIngameBet(param1:int) : void
      {
         this.coinBet = param1;
      }
      
      override public function hideButtons() : void
      {
         this.moneyResourceElementScreen.hideButtons();
      }
      
      override public function disableButtons() : void
      {
         this.moneyResourceElementScreen.disableButtons();
      }
      
      override public function enableButtons() : void
      {
         this.moneyResourceElementScreen.enableButtons();
      }
   }
}

