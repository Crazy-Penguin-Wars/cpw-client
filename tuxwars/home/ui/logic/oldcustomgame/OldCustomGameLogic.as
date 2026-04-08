package tuxwars.home.ui.logic.oldcustomgame
{
   import com.dchoc.net.*;
   import tuxwars.*;
   import tuxwars.battle.data.*;
   import tuxwars.home.states.matchloading.*;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.oldcustomgame.OldCustomGameScreen;
   import tuxwars.states.TuxState;
   
   public class OldCustomGameLogic extends TuxUILogic
   {
      private static const DEFAULT_PLAYER_NUMBER:String = "2";
      
      private static const DEFAULT_MATCH_TIME:String = "300";
      
      private static const DEFAULT_TURN_TIME:String = "20";
      
      public function OldCustomGameLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      public function play(param1:Object) : void
      {
         this.customGameScreen.disableButtons();
         var _loc2_:ServerRequest = new ServerRequest("CustomGame",param1);
         game.homeState.changeState(new MultiplayerMatchLoadingSubState(game,_loc2_));
      }
      
      public function practice(param1:Object) : void
      {
         this.customGameScreen.disableButtons();
         GameSettings.setShowAllWeaponsInPractice(true);
         game.homeState.changeState(new PracticeMatchLoadingSubState(game,param1));
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

