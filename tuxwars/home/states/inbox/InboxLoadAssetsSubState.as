package tuxwars.home.states.inbox
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class InboxLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function InboxLoadAssetsSubState(game:DCGame, params:* = null)
      {
         super(game,AssetsData.getInboxScreenAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new InboxUISubState(tuxGame));
      }
   }
}
