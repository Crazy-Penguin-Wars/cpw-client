package tuxwars.home.ui.logic.matchloading
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.utils.*;
   import flash.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.matchloading.*;
   import tuxwars.home.states.matchloading.connecting.*;
   import tuxwars.states.TuxState;
   
   public class MultiplayerMatchLoadingLogic extends MatchLoadingLogic
   {
      private var serverResponseData:Object;
      
      public function MultiplayerMatchLoadingLogic(param1:TuxWarsGame, param2:TuxState)
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
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("ResponseReceived_" + this.matchLoadingState.request.serviceId,this.serverCallback);
         super.dispose();
      }
      
      private function handleServerResponse(param1:ServerResponse) : void
      {
         this.serverResponseData = param1.data;
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
      
      private function get matchLoadingState() : MultiplayerMatchLoadingSubState
      {
         var _loc1_:MultiplayerMatchLoadingSubState = null;
         var _loc2_:String = null;
         if(Config.isDev())
         {
            _loc1_ = state.parent as MultiplayerMatchLoadingSubState;
            if(_loc1_ == null)
            {
               _loc2_ = "";
               if(state.parent)
               {
                  _loc2_ = getQualifiedClassName(state.parent);
               }
               LogUtils.log("State.parent is not MultiplayerMatchLoadingSubState it is: " + state.parent + " and qualified name: " + _loc2_ + " state is: " + state,this,0,"Warning",true,true,false);
            }
         }
         return state.parent as MultiplayerMatchLoadingSubState;
      }
      
      override public function isRematch() : Boolean
      {
         return Boolean(this.matchLoadingState.request.data.game_identifier) && Boolean(this.matchLoadingState.request.data.player_count) && this.matchLoadingState.request.data.player_count > 0;
      }
   }
}

