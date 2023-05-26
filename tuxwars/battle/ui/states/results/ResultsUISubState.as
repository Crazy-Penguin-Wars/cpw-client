package tuxwars.battle.ui.states.results
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.result.ResultLogic;
   import tuxwars.battle.ui.screen.result.ResultScreen;
   import tuxwars.home.states.TuxUIState;
   
   public class ResultsUISubState extends TuxUIState
   {
       
      
      public function ResultsUISubState(game:TuxWarsGame, params:* = null)
      {
         super(ResultScreen,ResultLogic,game,params);
      }
   }
}
