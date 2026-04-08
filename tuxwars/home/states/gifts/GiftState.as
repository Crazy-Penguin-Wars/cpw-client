package tuxwars.home.states.gifts
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class GiftState extends TuxState
   {
      public function GiftState(param1:DCGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new GiftLoadAssetsSubState(tuxGame,params));
      }
   }
}

