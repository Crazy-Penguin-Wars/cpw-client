package tuxwars.home.ui.logic.customgame
{
   import com.dchoc.net.ServerRequest;
   import tuxwars.GameSettings;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.customgame.CustomGameHostSubState;
   import tuxwars.home.states.customgame.CustomGameJoinSubState;
   import tuxwars.home.states.customgame.CustomGameUISubState;
   import tuxwars.home.states.matchloading.PracticeMatchLoadingSubState;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.states.TuxState;
   
   public class CustomGameLogic extends TuxUILogic
   {
       
      
      public function CustomGameLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function practice() : void
      {
         GameSettings.setShowAllWeaponsInPractice(false);
         game.homeState.changeState(new PracticeMatchLoadingSubState(game));
      }
      
      public function quit() : void
      {
         close();
      }
      
      public function createGame(name:String) : void
      {
         if(!(game.currentState is CustomGameUISubState))
         {
            return;
         }
         state.changeState(new CustomGameHostSubState(game,name,new ServerRequest("PlayNow",{"private_game":true})));
      }
      
      public function joinGame(name:String) : void
      {
         if(!(game.currentState is CustomGameUISubState))
         {
            return;
         }
         state.changeState(new CustomGameJoinSubState(game,name,new ServerRequest("PlayNow",{"private_game":true})));
      }
   }
}
