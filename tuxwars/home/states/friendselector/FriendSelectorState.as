package tuxwars.home.states.friendselector
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class FriendSelectorState extends TuxState
   {
       
      
      public function FriendSelectorState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new FriendSelectorLoadAssetsSubState(tuxGame,params));
      }
   }
}
