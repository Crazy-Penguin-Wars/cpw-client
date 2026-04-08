package tuxwars.home.ui.logic.tournament
{
   import com.dchoc.messages.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.tournament.TournamentEndScreen;
   import tuxwars.net.*;
   import tuxwars.states.TuxState;
   
   public class TournamentEndLogic extends TuxUILogic
   {
      public function TournamentEndLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      private function get tournamentEndScreen() : TournamentEndScreen
      {
         return screen;
      }
      
      public function postBragFeed(param1:int) : void
      {
         var _loc2_:String = param1 == 1 ? "TOURNAMENT_WON" : "TOURNAMENT_FINISHED";
         FeedService.publishMessage(_loc2_);
         MessageCenter.addListener("facebookFeedPostedCallback",this.feedPosted);
      }
      
      public function feedPosted(param1:Message) : void
      {
         MessageCenter.removeListener("facebookFeedPostedCallback",this.feedPosted);
         this.tournamentEndScreen.shareButton.setEnabled(false);
      }
   }
}

