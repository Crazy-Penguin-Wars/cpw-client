package tuxwars.home.states.tournament
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class TournamentEndState extends TuxState
   {
       
      
      public function TournamentEndState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new TournamentEndLoadAssetsSubState(tuxGame));
      }
   }
}
