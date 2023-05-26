package tuxwars.battle.ui.states
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.boosterselection.BoosterSelectionLogic;
   import tuxwars.battle.ui.screen.boosterselection.BoosterSelectionScreen;
   import tuxwars.home.ui.screenhandlers.ILogic;
   import tuxwars.home.ui.screenhandlers.IScreen;
   import tuxwars.home.ui.screenhandlers.ScreenHandler;
   import tuxwars.states.TuxState;
   
   public class HUDBoosterSelectionSubState extends TuxState
   {
       
      
      private var screenHandler:ScreenHandler;
      
      public function HUDBoosterSelectionSubState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
         screenHandler = new ScreenHandler(BoosterSelectionScreen,BoosterSelectionLogic,game,this);
      }
      
      override public function enter() : void
      {
         super.enter();
         screenHandler.init(params);
      }
      
      override public function exit() : void
      {
         screenHandler.dispose();
         screenHandler = null;
         super.exit();
      }
      
      public function get logic() : ILogic
      {
         return screenHandler.logic;
      }
      
      public function get screen() : IScreen
      {
         return screenHandler.screen;
      }
   }
}
