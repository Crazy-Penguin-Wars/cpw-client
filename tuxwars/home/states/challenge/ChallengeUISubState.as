package tuxwars.home.states.challenge
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.challenge.*;
   import tuxwars.home.ui.screen.challenge.*;
   
   public class ChallengeUISubState extends TuxUIState
   {
      public function ChallengeUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(ChallengesScreen,ChallengeLogic,param1,param2);
      }
   }
}

