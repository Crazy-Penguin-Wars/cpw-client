package tuxwars.home.states.crafting
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class CraftingState extends TuxState
   {
       
      
      public function CraftingState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new CraftingLoadAssetsSubState(tuxGame));
      }
   }
}
