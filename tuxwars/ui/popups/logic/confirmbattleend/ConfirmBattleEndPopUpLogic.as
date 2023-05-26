package tuxwars.ui.popups.logic.confirmbattleend
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.messages.ServerResponseReceivedMessage;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.battle.ui.states.results.ResultsState;
   import tuxwars.data.PopUpData;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.message.MessagePopUpLogic;
   
   public class ConfirmBattleEndPopUpLogic extends MessagePopUpLogic
   {
       
      
      private var battleResults:BattleResults;
      
      protected var showResultScreen:Boolean = true;
      
      public function ConfirmBattleEndPopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
         MessageCenter.addListener("ResponseReceived_" + "ConfirmBattleEnded",battleEndCallback);
         MessageCenter.sendEvent(new ServerRequest("ConfirmBattleEnded",null,true));
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         battleResults = params;
         messageScreen.closeButton.setEnabled(false);
         messageScreen.okButton.setEnabled(false);
      }
      
      override public function exit() : void
      {
         super.exit();
         if(showResultScreen)
         {
            game.homeState.changeState(new ResultsState(game,battleResults));
         }
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("ResponseReceived_" + "ConfirmBattleEnded",battleEndCallback);
         super.dispose();
      }
      
      override public function get picture() : String
      {
         return PopUpData.getPicture("errorpopup_1");
      }
      
      private function battleEndCallback(response:ServerResponseReceivedMessage) : void
      {
         LogUtils.log("Battle end callback: " + response,this,1,"Server",false);
         if(response && response.response && response.response.data && response.response.data.internal_code == 1070)
         {
            MessageCenter.sendEvent(new ServerRequest("ConfirmBattleEnded",null,true));
         }
         else
         {
            MessageCenter.removeListener("ResponseReceived_" + "ConfirmBattleEnded",battleEndCallback);
            LogUtils.log("Sending get account info call.",this,1,"Server",false);
            messageScreen.closeButton.setEnabled(true);
            messageScreen.okButton.setEnabled(true);
         }
      }
   }
}
