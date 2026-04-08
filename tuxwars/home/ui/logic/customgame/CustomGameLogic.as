package tuxwars.home.ui.logic.customgame
{
   import com.dchoc.net.*;
   import tuxwars.*;
   import tuxwars.home.states.customgame.*;
   import tuxwars.home.states.matchloading.*;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.states.TuxState;
   
   public class CustomGameLogic extends TuxUILogic
   {
      public function CustomGameLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
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
      
      public function createGame(param1:String) : void
      {
         if(!(game.currentState is CustomGameUISubState))
         {
            return;
         }
         state.changeState(new CustomGameHostSubState(game,param1,new ServerRequest("PlayNow",{"private_game":true})));
      }
      
      public function joinGame(param1:String) : void
      {
         if(!(game.currentState is CustomGameUISubState))
         {
            return;
         }
         state.changeState(new CustomGameJoinSubState(game,param1,new ServerRequest("PlayNow",{"private_game":true})));
      }
   }
}

