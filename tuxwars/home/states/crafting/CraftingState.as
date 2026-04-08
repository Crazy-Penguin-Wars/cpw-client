package tuxwars.home.states.crafting
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class CraftingState extends TuxState
   {
      public function CraftingState(param1:DCGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new CraftingLoadAssetsSubState(tuxGame));
      }
   }
}

