package tuxwars.home.states.oldcustomgame
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.home.states.BattleLoadAssetsSubState;
   
   public class OldCustomGameLoadAssetsSubState extends BattleLoadAssetsSubState
   {
       
      
      public function OldCustomGameLoadAssetsSubState(game:TuxWarsGame, params:* = null)
      {
         super(game,AssetsData.getCustomGameAssets(),params);
      }
      
      override protected function finished() : void
      {
         parent.changeState(new OldCustomGameUISubState(tuxGame));
      }
   }
}
