package tuxwars.battle.ui.states.results
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.result.*;
   import tuxwars.battle.ui.screen.result.*;
   import tuxwars.home.states.TuxUIState;
   
   public class ResultsUISubState extends TuxUIState
   {
      public function ResultsUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(ResultScreen,ResultLogic,param1,param2);
      }
   }
}

