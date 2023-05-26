package tuxwars.home.ui.logic.matchloading
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.messages.ServerResponseReceivedMessage;
   import com.dchoc.net.Server;
   import com.dchoc.net.ServerResponse;
   import com.dchoc.states.StateMachine;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.matchloading.TournamentMatchLoadingSubState;
   import tuxwars.home.states.matchloading.connecting.ConnectToBattleServerSubState;
   import tuxwars.states.TuxState;
   
   public class TournamentMatchLoadingLogic extends MatchLoadingLogic
   {
       
      
      private var serverResponseData:Object;
      
      public function TournamentMatchLoadingLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         serverResponseData = null;
         var _loc2_:ServerResponse = Server.findResponse(matchLoadingState.request.callId);
         if(_loc2_)
         {
            handleServerResponse(_loc2_);
         }
         else
         {
            MessageCenter.addListener("ResponseReceived_" + matchLoadingState.request.serviceId,serverCallback);
         }
      }
      
      override public function bettingReady() : void
      {
         super.bettingReady();
         if(serverResponseData)
         {
            state.changeState(new ConnectToBattleServerSubState(game,serverResponseData));
         }
      }
      
      override public function close(exitState:StateMachine = null) : void
      {
         MessageCenter.removeListener("ResponseReceived_" + matchLoadingState.request.serviceId,serverCallback);
         super.exit();
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("ResponseReceived_" + matchLoadingState.request.serviceId,serverCallback);
         super.dispose();
      }
      
      private function handleServerResponse(response:ServerResponse) : void
      {
         serverResponseData = response.data;
         serverResponseData["tournament"] = true;
         serverResponseData["game_identifier"] = matchLoadingState.request.data.game_identifier;
         serverResponseData["player_count"] = matchLoadingState.request.data.player_count;
         if(isBettingReady())
         {
            state.changeState(new ConnectToBattleServerSubState(game,serverResponseData));
         }
      }
      
      private function serverCallback(msg:ServerResponseReceivedMessage) : void
      {
         MessageCenter.removeListener("ResponseReceived_" + matchLoadingState.request.serviceId,serverCallback);
         handleServerResponse(msg.response);
      }
      
      private function get matchLoadingState() : TournamentMatchLoadingSubState
      {
         return state.parent as TournamentMatchLoadingSubState;
      }
   }
}
