package tuxwars.home.states.equipment
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class EquipmentLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function EquipmentLoadAssetsSubState(param1:DCGame, param2:* = null)
      {
         super(param1,AssetsData.getEquipmentAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new EquipmentUISubState(tuxGame));
      }
   }
}

