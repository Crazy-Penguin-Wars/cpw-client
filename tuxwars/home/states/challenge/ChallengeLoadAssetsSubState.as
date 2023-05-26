package tuxwars.home.states.challenge
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class ChallengeLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function ChallengeLoadAssetsSubState(game:DCGame, params:* = null)
      {
         super(game,AssetsData.getChallengeAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new ChallengeUISubState(tuxGame));
      }
   }
}
