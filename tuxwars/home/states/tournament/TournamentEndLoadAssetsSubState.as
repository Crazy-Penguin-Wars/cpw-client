package tuxwars.home.states.tournament
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.home.states.BattleLoadAssetsSubState;
   
   public class TournamentEndLoadAssetsSubState extends BattleLoadAssetsSubState
   {
      public function TournamentEndLoadAssetsSubState(param1:TuxWarsGame, param2:* = null)
      {
         var _loc3_:AssetsData = AssetsData;
         super(param1,new AssetsData("TournamentScreen"),param2);
      }
      
      override protected function finished() : void
      {
         parent.changeState(new TournamentEndUISubState(tuxGame));
      }
   }
}

