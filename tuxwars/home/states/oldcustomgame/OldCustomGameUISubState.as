package tuxwars.home.states.oldcustomgame
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.oldcustomgame.*;
   import tuxwars.home.ui.screen.oldcustomgame.*;
   
   public class OldCustomGameUISubState extends TuxUIState
   {
      public function OldCustomGameUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(OldCustomGameScreen,OldCustomGameLogic,param1,param2);
      }
   }
}

