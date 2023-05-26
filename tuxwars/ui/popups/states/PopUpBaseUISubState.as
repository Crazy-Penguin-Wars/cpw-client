package tuxwars.ui.popups.states
{
   import com.dchoc.game.DCGame;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   
   public class PopUpBaseUISubState extends TuxUIState
   {
       
      
      public function PopUpBaseUISubState(game:DCGame, screen:Class, logic:Class, params:* = null)
      {
         super(screen,logic,game as TuxWarsGame,params);
      }
   }
}
