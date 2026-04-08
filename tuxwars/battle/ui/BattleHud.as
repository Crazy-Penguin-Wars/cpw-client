package tuxwars.battle.ui
{
   import com.dchoc.states.StateMachine;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.*;
   import tuxwars.battle.ui.screen.*;
   import tuxwars.home.ui.screenhandlers.*;
   
   public class BattleHud extends StateMachine
   {
      private var _screenHandler:ScreenHandler;
      
      private var _helpHud:HelpHud;
      
      public function BattleHud(param1:TuxWarsGame)
      {
         super();
         this._screenHandler = new ScreenHandler(BattleHudScreen,BattleHudLogic,param1,null);
         this._screenHandler.init(this);
         this._helpHud = new HelpHud(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._screenHandler.dispose();
         this._screenHandler = null;
         this._helpHud.dispose();
         this._helpHud = null;
      }
      
      public function get screenHandler() : ScreenHandler
      {
         return this._screenHandler;
      }
      
      public function get logic() : BattleHudLogic
      {
         return this._screenHandler.logic as BattleHudLogic;
      }
      
      public function get screen() : BattleHudScreen
      {
         return this._screenHandler.screen as BattleHudScreen;
      }
      
      public function hideHud() : void
      {
         this.screen.hideHud();
      }
      
      public function showHud() : void
      {
         this.screen.showHud();
      }
   }
}

