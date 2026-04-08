package tuxwars.home.states.matchloading
{
   import com.dchoc.messages.*;
   import com.dchoc.net.ServerRequest;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.matchloading.*;
   
   public class TournamentMatchLoadingSubState extends MatchLoadingSubState
   {
      public function TournamentMatchLoadingSubState(param1:TuxWarsGame, param2:ServerRequest)
      {
         super(param1,param2);
      }
      
      override public function get logicClass() : Class
      {
         return TournamentMatchLoadingLogic;
      }
      
      override public function enter() : void
      {
         super.enter();
         if(allowEnterGame)
         {
            this.request.buffered = true;
            MessageCenter.sendEvent(this.request);
         }
      }
      
      public function get request() : ServerRequest
      {
         return params;
      }
   }
}

