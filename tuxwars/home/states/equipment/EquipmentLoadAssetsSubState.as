package tuxwars.home.states.equipment
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class EquipmentLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function EquipmentLoadAssetsSubState(game:DCGame, params:* = null)
      {
         super(game,AssetsData.getEquipmentAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new EquipmentUISubState(tuxGame));
      }
   }
}
