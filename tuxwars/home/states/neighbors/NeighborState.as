package tuxwars.home.states.neighbors
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class NeighborState extends TuxState
   {
       
      
      public function NeighborState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new NeighborLoadAssetsSubState(tuxGame));
      }
   }
}
