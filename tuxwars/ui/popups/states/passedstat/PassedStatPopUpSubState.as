package tuxwars.ui.popups.states.passedstat
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.logic.passedstat.PassedStatData;
   import tuxwars.ui.popups.logic.passedstat.PassedStatPopUpLogic;
   import tuxwars.ui.popups.screen.passedstat.PassedStatPopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class PassedStatPopUpSubState extends PopUpBaseSubState
   {
      
      public static const TYPE_PASSED_STAT:String = "PassedStat";
       
      
      public function PassedStatPopUpSubState(game:TuxWarsGame, data:PassedStatData)
      {
         super("PassedStat",game,PassedStatPopUpScreen,PassedStatPopUpLogic,AssetsData.getPopupAssets(),data);
      }
   }
}
