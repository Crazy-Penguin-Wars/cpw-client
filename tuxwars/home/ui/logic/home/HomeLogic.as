package tuxwars.home.ui.logic.home
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.home.HomeScreen;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.Tutorial;
   
   public class HomeLogic extends TuxUILogic
   {
       
      
      private var _levelElementLogic:LevelElementLogic;
      
      private var _moneyResourceElementLogic:MoneyResourceElementLogic;
      
      private var _characterFrameLogic:CharacterFrameElementLogic;
      
      public function HomeLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
         _levelElementLogic = new LevelElementLogic(game);
         _moneyResourceElementLogic = new MoneyResourceElementLogic(game);
         _characterFrameLogic = new CharacterFrameElementLogic(game);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         _levelElementLogic.init(params);
         _moneyResourceElementLogic.init(params);
         _characterFrameLogic.init(params);
         var _loc2_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial && tuxwars.tutorial.Tutorial._tutorialStep != "TutorialMatchPlayed")
         {
            _moneyResourceElementLogic.disableButtons();
            _characterFrameLogic.characterFrameElementScreen.playCustom.setEnabled(false);
         }
      }
      
      override public function dispose() : void
      {
         _levelElementLogic.dispose();
         _levelElementLogic = null;
         _moneyResourceElementLogic.dispose();
         _moneyResourceElementLogic = null;
         _characterFrameLogic.dispose();
         _characterFrameLogic = null;
         super.dispose();
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         _levelElementLogic.logicUpdate(deltaTime);
         _moneyResourceElementLogic.logicUpdate(deltaTime);
         _characterFrameLogic.logicUpdate(deltaTime);
      }
      
      override public function set screen(screen:*) : void
      {
         super.screen = screen;
         _characterFrameLogic.screen = homeScreen.characterFrameElementScreen;
         _levelElementLogic.screen = homeScreen.levelElementScreen;
         _moneyResourceElementLogic.screen = homeScreen.moneyResourceElementScreen;
      }
      
      public function get homeScreen() : HomeScreen
      {
         return screen;
      }
      
      public function get moneyResourceElementLogic() : MoneyResourceElementLogic
      {
         return _moneyResourceElementLogic;
      }
      
      public function get characterFrameLogic() : CharacterFrameElementLogic
      {
         return _characterFrameLogic;
      }
   }
}
