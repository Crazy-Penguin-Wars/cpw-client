package tuxwars.home.states.tournament
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class TournamentState extends TuxState
   {
      public function TournamentState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new TournamentLoadAssetsSubState(tuxGame));
      }
   }
}

