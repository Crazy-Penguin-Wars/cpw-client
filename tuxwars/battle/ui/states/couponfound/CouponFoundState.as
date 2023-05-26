package tuxwars.battle.ui.states.couponfound
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class CouponFoundState extends TuxState
   {
       
      
      public function CouponFoundState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new CouponFoundLoadAssetsSubState(tuxGame,params));
      }
   }
}
