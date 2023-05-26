package tuxwars.home.states.customgame
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class CustomGameState extends TuxState
   {
       
      
      public function CustomGameState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
         game.battleServer.init(game);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new CustomGameLoadAssetsSubState(tuxGame));
      }
   }
}
