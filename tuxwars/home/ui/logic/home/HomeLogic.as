package tuxwars.home.ui.logic.home
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.home.HomeScreen;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.*;
   
   public class HomeLogic extends TuxUILogic
   {
      private var _levelElementLogic:LevelElementLogic;
      
      private var _moneyResourceElementLogic:MoneyResourceElementLogic;
      
      private var _characterFrameLogic:CharacterFrameElementLogic;
      
      public function HomeLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
         this._levelElementLogic = new LevelElementLogic(param1);
         this._moneyResourceElementLogic = new MoneyResourceElementLogic(param1);
         this._characterFrameLogic = new CharacterFrameElementLogic(param1);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this._levelElementLogic.init(param1);
         this._moneyResourceElementLogic.init(param1);
         this._characterFrameLogic.init(param1);
         if(Boolean(Tutorial._tutorial) && Tutorial._tutorialStep != "TutorialMatchPlayed")
         {
            this._moneyResourceElementLogic.disableButtons();
            this._characterFrameLogic.characterFrameElementScreen.playCustom.setEnabled(false);
         }
      }
      
      override public function dispose() : void
      {
         this._levelElementLogic.dispose();
         this._levelElementLogic = null;
         this._moneyResourceElementLogic.dispose();
         this._moneyResourceElementLogic = null;
         this._characterFrameLogic.dispose();
         this._characterFrameLogic = null;
         super.dispose();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         this._levelElementLogic.logicUpdate(param1);
         this._moneyResourceElementLogic.logicUpdate(param1);
         this._characterFrameLogic.logicUpdate(param1);
      }
      
      override public function set screen(param1:*) : void
      {
         super.screen = param1;
         this._characterFrameLogic.screen = this.homeScreen.characterFrameElementScreen;
         this._levelElementLogic.screen = this.homeScreen.levelElementScreen;
         this._moneyResourceElementLogic.screen = this.homeScreen.moneyResourceElementScreen;
      }
      
      public function get homeScreen() : HomeScreen
      {
         return screen;
      }
      
      public function get moneyResourceElementLogic() : MoneyResourceElementLogic
      {
         return this._moneyResourceElementLogic;
      }
      
      public function get characterFrameLogic() : CharacterFrameElementLogic
      {
         return this._characterFrameLogic;
      }
   }
}

