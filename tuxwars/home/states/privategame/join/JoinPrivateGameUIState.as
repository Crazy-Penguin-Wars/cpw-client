package tuxwars.home.states.privategame.join
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.privategame.join.JoinPrivateGameLogic;
   import tuxwars.home.ui.screen.privategame.join.JoinPrivateGameScreen;
   
   public class JoinPrivateGameUIState extends TuxUIState
   {
       
      
      public function JoinPrivateGameUIState(game:TuxWarsGame, params:* = null)
      {
         super(JoinPrivateGameScreen,JoinPrivateGameLogic,game,params);
      }
   }
}
