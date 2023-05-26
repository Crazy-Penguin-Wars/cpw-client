package tuxwars.home.states.oldcustomgame
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.oldcustomgame.OldCustomGameLogic;
   import tuxwars.home.ui.screen.oldcustomgame.OldCustomGameScreen;
   
   public class OldCustomGameUISubState extends TuxUIState
   {
       
      
      public function OldCustomGameUISubState(game:TuxWarsGame, params:* = null)
      {
         super(OldCustomGameScreen,OldCustomGameLogic,game,params);
      }
   }
}
