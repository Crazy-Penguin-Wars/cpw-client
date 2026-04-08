package tuxwars.home.states.oldcustomgame
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.home.states.BattleLoadAssetsSubState;
   
   public class OldCustomGameLoadAssetsSubState extends BattleLoadAssetsSubState
   {
      public function OldCustomGameLoadAssetsSubState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,AssetsData.getCustomGameAssets(),param2);
      }
      
      override protected function finished() : void
      {
         parent.changeState(new OldCustomGameUISubState(tuxGame));
      }
   }
}

