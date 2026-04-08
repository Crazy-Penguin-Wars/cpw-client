package tuxwars.ui.popups.states
{
   import com.dchoc.game.DCGame;
   import tuxwars.*;
   import tuxwars.home.states.TuxUIState;
   
   public class PopUpBaseUISubState extends TuxUIState
   {
      public function PopUpBaseUISubState(param1:DCGame, param2:Class, param3:Class, param4:* = null)
      {
         super(param2,param3,param1 as TuxWarsGame,param4);
      }
   }
}

