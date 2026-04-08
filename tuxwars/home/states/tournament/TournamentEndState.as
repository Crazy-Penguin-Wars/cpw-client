package tuxwars.home.states.tournament
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class TournamentEndState extends TuxState
   {
      public function TournamentEndState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new TournamentEndLoadAssetsSubState(tuxGame));
      }
   }
}

