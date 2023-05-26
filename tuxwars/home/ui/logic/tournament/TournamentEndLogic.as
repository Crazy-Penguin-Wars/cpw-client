package tuxwars.home.ui.logic.tournament
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.tournament.TournamentEndScreen;
   import tuxwars.net.FeedService;
   import tuxwars.states.TuxState;
   
   public class TournamentEndLogic extends TuxUILogic
   {
       
      
      public function TournamentEndLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      private function get tournamentEndScreen() : TournamentEndScreen
      {
         return screen;
      }
      
      public function postBragFeed(position:int) : void
      {
         var _loc2_:String = position == 1 ? "TOURNAMENT_WON" : "TOURNAMENT_FINISHED";
         FeedService.publishMessage(_loc2_);
         MessageCenter.addListener("facebookFeedPostedCallback",feedPosted);
      }
      
      public function feedPosted(msg:Message) : void
      {
         MessageCenter.removeListener("facebookFeedPostedCallback",feedPosted);
         tournamentEndScreen.shareButton.setEnabled(false);
      }
   }
}
