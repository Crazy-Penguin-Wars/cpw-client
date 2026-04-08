package tuxwars.home.states.shop
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class ShopState extends TuxState
   {
      public function ShopState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new ShopLoadAssetsSubState(tuxGame,params));
      }
   }
}

