package tuxwars.home.states.help
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class HelpState extends TuxState
   {
       
      
      public function HelpState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new HelpLoadAssetsSubState(tuxGame,params));
      }
   }
}
