package tuxwars.home.states.inbox
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class InboxLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function InboxLoadAssetsSubState(param1:DCGame, param2:* = null)
      {
         super(param1,AssetsData.getInboxScreenAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new InboxUISubState(tuxGame));
      }
   }
}

