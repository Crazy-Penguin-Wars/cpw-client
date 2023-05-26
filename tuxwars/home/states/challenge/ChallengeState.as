package tuxwars.home.states.challenge
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class ChallengeState extends TuxState
   {
       
      
      public function ChallengeState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new ChallengeLoadAssetsSubState(tuxGame));
      }
   }
}
