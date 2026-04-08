package tuxwars.battle.ui.states
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.weaponselection.*;
   import tuxwars.battle.ui.screen.weaponselection.*;
   import tuxwars.home.ui.screenhandlers.*;
   import tuxwars.states.TuxState;
   
   public class HUDWeaponSelectionSubState extends TuxState
   {
      private var screenHandler:ScreenHandler;
      
      public function HUDWeaponSelectionSubState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
         this.screenHandler = new ScreenHandler(WeaponSelectionScreen,WeaponSelectionLogic,param1,this);
      }
      
      override public function enter() : void
      {
         super.enter();
         this.screenHandler.init(params);
      }
      
      override public function exit() : void
      {
         this.screenHandler.dispose();
         this.screenHandler = null;
         super.exit();
      }
      
      public function get logic() : ILogic
      {
         return this.screenHandler.logic;
      }
      
      public function get screen() : IScreen
      {
         return this.screenHandler.screen;
      }
   }
}

