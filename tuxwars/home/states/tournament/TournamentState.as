package tuxwars.home.states.tournament
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class TournamentState extends TuxState
   {
       
      
      public function TournamentState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new TournamentLoadAssetsSubState(tuxGame));
      }
   }
}
