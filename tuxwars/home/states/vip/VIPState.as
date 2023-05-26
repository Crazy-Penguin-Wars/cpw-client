package tuxwars.home.states.vip
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class VIPState extends TuxState
   {
       
      
      public function VIPState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new VIPLoadAssetsSubState(tuxGame));
      }
   }
}
