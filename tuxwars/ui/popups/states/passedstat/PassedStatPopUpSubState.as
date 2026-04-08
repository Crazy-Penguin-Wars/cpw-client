package tuxwars.ui.popups.states.passedstat
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.ui.popups.logic.passedstat.*;
   import tuxwars.ui.popups.screen.passedstat.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class PassedStatPopUpSubState extends PopUpBaseSubState
   {
      public static const TYPE_PASSED_STAT:String = "PassedStat";
      
      public function PassedStatPopUpSubState(param1:TuxWarsGame, param2:PassedStatData)
      {
         super("PassedStat",param1,PassedStatPopUpScreen,PassedStatPopUpLogic,AssetsData.getPopupAssets(),param2);
      }
   }
}

