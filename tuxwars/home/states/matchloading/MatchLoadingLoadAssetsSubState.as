package tuxwars.home.states.matchloading
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.home.states.BattleLoadAssetsSubState;
   
   public class MatchLoadingLoadAssetsSubState extends BattleLoadAssetsSubState
   {
       
      
      public function MatchLoadingLoadAssetsSubState(game:TuxWarsGame, params:* = null)
      {
         super(game,AssetsData.getMatchLoadingAssets(),params);
      }
      
      override protected function finished() : void
      {
         parent.changeState(new MatchLoadingUISubState(tuxGame,MatchLoadingSubState(parent).logicClass,params));
      }
   }
}
