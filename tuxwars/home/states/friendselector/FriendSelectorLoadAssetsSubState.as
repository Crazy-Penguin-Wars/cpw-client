package tuxwars.home.states.friendselector
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class FriendSelectorLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function FriendSelectorLoadAssetsSubState(param1:DCGame, param2:* = null)
      {
         super(param1,AssetsData.getFriendSelectorAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new FriendSelectorUISubState(tuxGame,params));
      }
   }
}

