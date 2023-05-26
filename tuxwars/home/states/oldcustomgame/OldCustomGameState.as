package tuxwars.home.states.oldcustomgame
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class OldCustomGameState extends TuxState
   {
       
      
      public function OldCustomGameState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new OldCustomGameLoadAssetsSubState(tuxGame));
      }
   }
}
