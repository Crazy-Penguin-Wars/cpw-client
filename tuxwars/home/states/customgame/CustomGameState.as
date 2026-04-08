package tuxwars.home.states.customgame
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class CustomGameState extends TuxState
   {
      public function CustomGameState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
         param1.battleServer.init(param1);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new CustomGameLoadAssetsSubState(tuxGame));
      }
   }
}

