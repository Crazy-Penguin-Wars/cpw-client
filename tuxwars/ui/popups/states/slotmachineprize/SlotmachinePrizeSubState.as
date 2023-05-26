package tuxwars.ui.popups.states.slotmachineprize
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.logic.slotmachineprizelogic.SlotMachinePrizeLogic;
   import tuxwars.ui.popups.screen.slotmachineprize.SlotMachinePrizePopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class SlotmachinePrizeSubState extends PopUpBaseSubState
   {
      
      public static const TYPE_PRIZE:String = "SlotMachinePrize";
       
      
      public function SlotmachinePrizeSubState(game:DCGame, params:* = null)
      {
         super("SlotMachinePrize",game,SlotMachinePrizePopUpScreen,SlotMachinePrizeLogic,AssetsData.getPopupAssets(),params);
      }
   }
}
