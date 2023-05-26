package tuxwars.battle.ui.states.couponfound
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.couponfound.CouponFoundLogic;
   import tuxwars.battle.ui.screen.couponfound.CouponFoundScreen;
   import tuxwars.home.states.TuxUIState;
   
   public class CouponFoundUISubState extends TuxUIState
   {
       
      
      public function CouponFoundUISubState(game:TuxWarsGame, params:* = null)
      {
         super(CouponFoundScreen,CouponFoundLogic,game,params);
      }
   }
}
