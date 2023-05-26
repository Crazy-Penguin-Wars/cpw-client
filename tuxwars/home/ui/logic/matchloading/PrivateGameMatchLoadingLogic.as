package tuxwars.home.ui.logic.matchloading
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.matchloading.connecting.ConnectToBattleServerSubState;
   import tuxwars.states.TuxState;
   
   public class PrivateGameMatchLoadingLogic extends MatchLoadingLogic
   {
       
      
      public function PrivateGameMatchLoadingLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         state.changeState(new ConnectToBattleServerSubState(game,params));
      }
   }
}
