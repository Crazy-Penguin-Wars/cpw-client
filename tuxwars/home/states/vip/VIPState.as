package tuxwars.home.states.vip
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class VIPState extends TuxState
   {
      public function VIPState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new VIPLoadAssetsSubState(tuxGame));
      }
   }
}

