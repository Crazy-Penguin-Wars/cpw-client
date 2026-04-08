package tuxwars.home.states.challenge
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class ChallengeLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function ChallengeLoadAssetsSubState(param1:DCGame, param2:* = null)
      {
         super(param1,AssetsData.getChallengeAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new ChallengeUISubState(tuxGame));
      }
   }
}

