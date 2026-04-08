package tuxwars.home.states.matchloading
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.home.states.BattleLoadAssetsSubState;
   
   public class MatchLoadingLoadAssetsSubState extends BattleLoadAssetsSubState
   {
      public function MatchLoadingLoadAssetsSubState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,AssetsData.getMatchLoadingAssets(),param2);
      }
      
      override protected function finished() : void
      {
         parent.changeState(new MatchLoadingUISubState(tuxGame,MatchLoadingSubState(parent).logicClass,params));
      }
   }
}

