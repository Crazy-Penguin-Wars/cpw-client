package tuxwars.home.states.money
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class MoneyState extends TuxState
   {
       
      
      public function MoneyState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new MoneyLoadAssetsSubState(tuxGame,params));
      }
   }
}
