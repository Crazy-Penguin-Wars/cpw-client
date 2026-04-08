package tuxwars.home.states.money
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class MoneyState extends TuxState
   {
      public function MoneyState(param1:DCGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new MoneyLoadAssetsSubState(tuxGame,params));
      }
   }
}

