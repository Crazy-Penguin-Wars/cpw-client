package tuxwars.home.states.tournament
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.home.states.BattleLoadAssetsSubState;
   
   public class TournamentLoadAssetsSubState extends BattleLoadAssetsSubState
   {
      public function TournamentLoadAssetsSubState(param1:TuxWarsGame, param2:* = null)
      {
         var _loc3_:AssetsData = AssetsData;
         super(param1,new AssetsData("TournamentScreen"),param2);
      }
      
      override protected function finished() : void
      {
         parent.changeState(new TournamentUISubState(tuxGame));
      }
   }
}

