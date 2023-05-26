package tuxwars.home.states.inbox
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class InboxState extends TuxState
   {
       
      
      public function InboxState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new InboxLoadAssetsSubState(tuxGame));
      }
   }
}
