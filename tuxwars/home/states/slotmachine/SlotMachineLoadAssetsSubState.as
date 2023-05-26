package tuxwars.home.states.slotmachine
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class SlotMachineLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function SlotMachineLoadAssetsSubState(game:DCGame, params:* = null)
      {
         super(game,AssetsData.getSlotMachineAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new SlotMachineUISubState(tuxGame));
      }
   }
}
