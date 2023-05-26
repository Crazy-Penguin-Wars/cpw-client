package tuxwars.home.states.friendselector
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class FriendSelectorLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function FriendSelectorLoadAssetsSubState(game:DCGame, params:* = null)
      {
         super(game,AssetsData.getFriendSelectorAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new FriendSelectorUISubState(tuxGame,params));
      }
   }
}
