package tuxwars.home.states.friendselector
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class FriendSelectorState extends TuxState
   {
      public function FriendSelectorState(param1:DCGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new FriendSelectorLoadAssetsSubState(tuxGame,params));
      }
   }
}

