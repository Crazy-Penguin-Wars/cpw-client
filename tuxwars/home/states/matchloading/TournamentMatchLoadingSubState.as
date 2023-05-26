package tuxwars.home.states.matchloading
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.matchloading.TournamentMatchLoadingLogic;
   
   public class TournamentMatchLoadingSubState extends MatchLoadingSubState
   {
       
      
      public function TournamentMatchLoadingSubState(game:TuxWarsGame, request:ServerRequest)
      {
         super(game,request);
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
            request.buffered = true;
            MessageCenter.sendEvent(request);
         }
      }
      
      public function get request() : ServerRequest
      {
         return params;
      }
   }
}
