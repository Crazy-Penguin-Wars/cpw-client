package tuxwars.home.states.help
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class HelpLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function HelpLoadAssetsSubState(game:DCGame, params:* = null)
      {
         super(game,AssetsData.getHelpAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new HelpUISubState(tuxGame,params));
      }
   }
}
