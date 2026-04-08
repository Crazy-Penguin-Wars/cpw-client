package tuxwars.home.ui.logic.challenge
{
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.*;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.states.TuxState;
   
   public class ChallengeLogic extends TuxUILogic
   {
      public function ChallengeLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      public function quit() : void
      {
         close();
      }
      
      public function getActiveChallenges() : Vector.<Challenge>
      {
         if(!ChallengeManager.instance)
         {
            ChallengeManager.instance = new ChallengeManager();
         }
         return ChallengeManager.instance.getPlayerChallenges(game.player.id).activeChallenges;
      }
   }
}

