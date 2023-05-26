package tuxwars.home.states.gifts
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class GiftState extends TuxState
   {
       
      
      public function GiftState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new GiftLoadAssetsSubState(tuxGame,params));
      }
   }
}
