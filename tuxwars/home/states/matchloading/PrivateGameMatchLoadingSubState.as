package tuxwars.home.states.matchloading
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.matchloading.*;
   
   public class PrivateGameMatchLoadingSubState extends MatchLoadingSubState
   {
      public function PrivateGameMatchLoadingSubState(param1:TuxWarsGame, param2:Object)
      {
         super(param1,param2);
      }
      
      override public function get logicClass() : Class
      {
         return PrivateGameMatchLoadingLogic;
      }
   }
}

