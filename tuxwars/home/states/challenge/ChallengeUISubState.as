package tuxwars.home.states.challenge
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.challenge.ChallengeLogic;
   import tuxwars.home.ui.screen.challenge.ChallengesScreen;
   
   public class ChallengeUISubState extends TuxUIState
   {
       
      
      public function ChallengeUISubState(game:TuxWarsGame, params:* = null)
      {
         super(ChallengesScreen,ChallengeLogic,game,params);
      }
   }
}
