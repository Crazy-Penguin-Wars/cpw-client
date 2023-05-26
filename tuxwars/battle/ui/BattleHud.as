package tuxwars.battle.ui
{
   import com.dchoc.states.StateMachine;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.BattleHudLogic;
   import tuxwars.battle.ui.screen.BattleHudScreen;
   import tuxwars.home.ui.screenhandlers.ScreenHandler;
   
   public class BattleHud extends StateMachine
   {
       
      
      private var _screenHandler:ScreenHandler;
      
      private var _helpHud:HelpHud;
      
      public function BattleHud(game:TuxWarsGame)
      {
         super();
         _screenHandler = new ScreenHandler(BattleHudScreen,BattleHudLogic,game,null);
         _screenHandler.init(this);
         _helpHud = new HelpHud(game);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _screenHandler.dispose();
         _screenHandler = null;
         _helpHud.dispose();
         _helpHud = null;
      }
      
      public function get screenHandler() : ScreenHandler
      {
         return _screenHandler;
      }
      
      public function get logic() : BattleHudLogic
      {
         return _screenHandler.logic as BattleHudLogic;
      }
      
      public function get screen() : BattleHudScreen
      {
         return _screenHandler.screen as BattleHudScreen;
      }
      
      public function hideHud() : void
      {
         screen.hideHud();
      }
      
      public function showHud() : void
      {
         screen.showHud();
      }
   }
}
