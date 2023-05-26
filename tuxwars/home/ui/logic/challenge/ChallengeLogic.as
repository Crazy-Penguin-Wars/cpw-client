package tuxwars.home.ui.logic.challenge
{
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.states.TuxState;
   
   public class ChallengeLogic extends TuxUILogic
   {
       
      
      public function ChallengeLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function quit() : void
      {
         close();
      }
      
      public function getActiveChallenges() : Vector.<Challenge>
      {
         var _loc1_:ChallengeManager = ChallengeManager;
         if(!tuxwars.challenges.ChallengeManager._instance)
         {
            tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
         }
         return tuxwars.challenges.ChallengeManager._instance.getPlayerChallenges(game.player.id).activeChallenges;
      }
   }
}
