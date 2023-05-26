package tuxwars.home.ui.logic.home
{
   import com.dchoc.messages.MessageCenter;
   import tuxwars.TuxWarsGame;
   import tuxwars.events.IngameMoneyChangedMessage;
   import tuxwars.events.PremiumMoneyChangedMessage;
   import tuxwars.home.ui.logic.TuxUIElementLogic;
   import tuxwars.home.ui.screen.home.MoneyResourceElementScreen;
   
   public class MoneyResourceElementLogic extends TuxUIElementLogic
   {
       
      
      public function MoneyResourceElementLogic(game:TuxWarsGame)
      {
         super(game);
         MessageCenter.addListener("IngameMoneyChanged",inGameMoneyChanged);
         MessageCenter.addListener("PremiumMoneyChanged",premiumMoneyChanged);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("IngameMoneyChanged",inGameMoneyChanged);
         MessageCenter.removeListener("PremiumMoneyChanged",premiumMoneyChanged);
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
      }
      
      private function premiumMoneyChanged(msg:PremiumMoneyChangedMessage) : void
      {
         moneyResourceElementScreen.setPremiumMoney(msg.premiumMoney.toString());
      }
      
      private function inGameMoneyChanged(msg:IngameMoneyChangedMessage) : void
      {
         moneyResourceElementScreen.setInGameMoney(msg.ingameMoney.toString());
      }
      
      private function get moneyResourceElementScreen() : MoneyResourceElementScreen
      {
         return screen;
      }
      
      public function hideButtons() : void
      {
         moneyResourceElementScreen.hideButtons();
      }
      
      public function disableButtons() : void
      {
         moneyResourceElementScreen.disableButtons();
      }
      
      public function enableButtons() : void
      {
         moneyResourceElementScreen.enableButtons();
      }
   }
}
