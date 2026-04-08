package tuxwars.battle.ui.states.couponfound
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.couponfound.*;
   import tuxwars.battle.ui.screen.couponfound.*;
   import tuxwars.home.states.TuxUIState;
   
   public class CouponFoundUISubState extends TuxUIState
   {
      public function CouponFoundUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(CouponFoundScreen,CouponFoundLogic,param1,param2);
      }
   }
}

