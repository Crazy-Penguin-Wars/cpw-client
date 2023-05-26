package tuxwars.home.states.tournament
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.home.states.BattleLoadAssetsSubState;
   
   public class TournamentEndLoadAssetsSubState extends BattleLoadAssetsSubState
   {
       
      
      public function TournamentEndLoadAssetsSubState(game:TuxWarsGame, params:* = null)
      {
         var _loc3_:AssetsData = AssetsData;
         super(game,new tuxwars.data.assets.AssetsData("TournamentScreen"),params);
      }
      
      override protected function finished() : void
      {
         parent.changeState(new TournamentEndUISubState(tuxGame));
      }
   }
}
