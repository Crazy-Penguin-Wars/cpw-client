package tuxwars.home.ui.logic.matchloading
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.states.StateMachine;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.matchloading.*;
   import tuxwars.home.states.matchloading.connecting.*;
   import tuxwars.states.TuxState;
   
   public class TournamentMatchLoadingLogic extends MatchLoadingLogic
   {
      private var serverResponseData:Object;
      
      public function TournamentMatchLoadingLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.serverResponseData = null;
         var _loc2_:ServerResponse = Server.findResponse(this.matchLoadingState.request.callId);
         if(_loc2_)
         {
            this.handleServerResponse(_loc2_);
         }
         else
         {
            MessageCenter.addListener("ResponseReceived_" + this.matchLoadingState.request.serviceId,this.serverCallback);
         }
      }
      
      override public function bettingReady() : void
      {
         super.bettingReady();
         if(this.serverResponseData)
         {
            state.changeState(new ConnectToBattleServerSubState(game,this.serverResponseData));
         }
      }
      
      override public function close(param1:StateMachine = null) : void
      {
         MessageCenter.removeListener("ResponseReceived_" + this.matchLoadingState.request.serviceId,this.serverCallback);
         super.exit();
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("ResponseReceived_" + this.matchLoadingState.request.serviceId,this.serverCallback);
         super.dispose();
      }
      
      private function handleServerResponse(param1:ServerResponse) : void
      {
         this.serverResponseData = param1.data;
         this.serverResponseData["tournament"] = true;
         this.serverResponseData["game_identifier"] = this.matchLoadingState.request.data.game_identifier;
         this.serverResponseData["player_count"] = this.matchLoadingState.request.data.player_count;
         if(isBettingReady())
         {
            state.changeState(new ConnectToBattleServerSubState(game,this.serverResponseData));
         }
      }
      
      private function serverCallback(param1:ServerResponseReceivedMessage) : void
      {
         MessageCenter.removeListener("ResponseReceived_" + this.matchLoadingState.request.serviceId,this.serverCallback);
         this.handleServerResponse(param1.response);
      }
      
      private function get matchLoadingState() : TournamentMatchLoadingSubState
      {
         return state.parent as TournamentMatchLoadingSubState;
      }
   }
}

