package tuxwars.ui.popups.logic.confirmbattleend
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.battle.ui.states.results.*;
   import tuxwars.data.*;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.message.MessagePopUpLogic;
   
   public class ConfirmBattleEndPopUpLogic extends MessagePopUpLogic
   {
      private var battleResults:BattleResults;
      
      protected var showResultScreen:Boolean = true;
      
      public function ConfirmBattleEndPopUpLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
         MessageCenter.addListener("ResponseReceived_" + "ConfirmBattleEnded",this.battleEndCallback);
         MessageCenter.sendEvent(new ServerRequest("ConfirmBattleEnded",null,true));
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.battleResults = param1;
         messageScreen.closeButton.setEnabled(false);
         messageScreen.okButton.setEnabled(false);
      }
      
      override public function exit() : void
      {
         super.exit();
         if(this.showResultScreen)
         {
            game.homeState.changeState(new ResultsState(game,this.battleResults));
         }
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("ResponseReceived_" + "ConfirmBattleEnded",this.battleEndCallback);
         super.dispose();
      }
      
      override public function get picture() : String
      {
         return PopUpData.getPicture("errorpopup_1");
      }
      
      private function battleEndCallback(param1:ServerResponseReceivedMessage) : void
      {
         LogUtils.log("Battle end callback: " + param1,this,1,"Server",false);
         if(param1 && param1.response && param1.response.data && param1.response.data.internal_code == 1070)
         {
            MessageCenter.sendEvent(new ServerRequest("ConfirmBattleEnded",null,true));
         }
         else
         {
            MessageCenter.removeListener("ResponseReceived_" + "ConfirmBattleEnded",this.battleEndCallback);
            LogUtils.log("Sending get account info call.",this,1,"Server",false);
            messageScreen.closeButton.setEnabled(true);
            messageScreen.okButton.setEnabled(true);
         }
      }
   }
}

