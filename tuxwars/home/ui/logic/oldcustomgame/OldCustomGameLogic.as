package tuxwars.home.ui.logic.oldcustomgame
{
   import com.dchoc.net.ServerRequest;
   import tuxwars.GameSettings;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.LevelData;
   import tuxwars.battle.data.Levels;
   import tuxwars.home.states.matchloading.MultiplayerMatchLoadingSubState;
   import tuxwars.home.states.matchloading.PracticeMatchLoadingSubState;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.oldcustomgame.OldCustomGameScreen;
   import tuxwars.states.TuxState;
   
   public class OldCustomGameLogic extends TuxUILogic
   {
      
      private static const DEFAULT_PLAYER_NUMBER:String = "2";
      
      private static const DEFAULT_MATCH_TIME:String = "300";
      
      private static const DEFAULT_TURN_TIME:String = "20";
       
      
      public function OldCustomGameLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function play(params:Object) : void
      {
         customGameScreen.disableButtons();
         var _loc2_:ServerRequest = new ServerRequest("CustomGame",params);
         game.homeState.changeState(new MultiplayerMatchLoadingSubState(game,_loc2_));
      }
      
      public function practice(params:Object) : void
      {
         customGameScreen.disableButtons();
         GameSettings.setShowAllWeaponsInPractice(true);
         game.homeState.changeState(new PracticeMatchLoadingSubState(game,params));
      }
      
      public function quit() : void
      {
         close();
      }
      
      public function getLevels() : Vector.<LevelData>
      {
         return Levels.getLevels();
      }
      
      public function getDefaultPlayerNumber() : String
      {
         return "2";
      }
      
      public function getDefaultMatchTime() : String
      {
         return "300";
      }
      
      public function getDefaultTurnTime() : String
      {
         return "20";
      }
      
      private function get customGameScreen() : OldCustomGameScreen
      {
         return screen;
      }
   }
}
