package tuxwars.home.states.slotmachine
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class SlotMachineLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function SlotMachineLoadAssetsSubState(param1:DCGame, param2:* = null)
      {
         super(param1,AssetsData.getSlotMachineAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new SlotMachineUISubState(tuxGame));
      }
   }
}

