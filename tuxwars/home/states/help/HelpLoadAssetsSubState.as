package tuxwars.home.states.help
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class HelpLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function HelpLoadAssetsSubState(param1:DCGame, param2:* = null)
      {
         super(param1,AssetsData.getHelpAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new HelpUISubState(tuxGame,params));
      }
   }
}

