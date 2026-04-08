package tuxwars.home.states.neighbors
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class NeighborState extends TuxState
   {
      public function NeighborState(param1:DCGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new NeighborLoadAssetsSubState(tuxGame));
      }
   }
}

