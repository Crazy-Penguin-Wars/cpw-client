package tuxwars.battle.ui.states.couponfound
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class CouponFoundState extends TuxState
   {
      public function CouponFoundState(param1:DCGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new CouponFoundLoadAssetsSubState(tuxGame,params));
      }
   }
}

