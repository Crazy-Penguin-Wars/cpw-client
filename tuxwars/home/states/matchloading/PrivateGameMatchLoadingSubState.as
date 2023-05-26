package tuxwars.home.states.matchloading
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.matchloading.PrivateGameMatchLoadingLogic;
   
   public class PrivateGameMatchLoadingSubState extends MatchLoadingSubState
   {
       
      
      public function PrivateGameMatchLoadingSubState(game:TuxWarsGame, data:Object)
      {
         super(game,data);
      }
      
      override public function get logicClass() : Class
      {
         return PrivateGameMatchLoadingLogic;
      }
   }
}
