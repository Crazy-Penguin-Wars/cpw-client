package tuxwars.home.states.help
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class HelpState extends TuxState
   {
      public function HelpState(param1:DCGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new HelpLoadAssetsSubState(tuxGame,params));
      }
   }
}

