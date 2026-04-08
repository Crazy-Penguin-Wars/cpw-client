package tuxwars.home.ui.logic.matchloading
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.matchloading.connecting.*;
   import tuxwars.states.TuxState;
   
   public class PrivateGameMatchLoadingLogic extends MatchLoadingLogic
   {
      public function PrivateGameMatchLoadingLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         state.changeState(new ConnectToBattleServerSubState(game,param1));
      }
   }
}

