package tuxwars.home.states.shop
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class ShopState extends TuxState
   {
       
      
      public function ShopState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new ShopLoadAssetsSubState(tuxGame,params));
      }
   }
}
