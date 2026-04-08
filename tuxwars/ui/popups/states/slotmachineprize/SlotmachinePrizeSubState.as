package tuxwars.ui.popups.states.slotmachineprize
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.ui.popups.logic.slotmachineprizelogic.*;
   import tuxwars.ui.popups.screen.slotmachineprize.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class SlotmachinePrizeSubState extends PopUpBaseSubState
   {
      public static const TYPE_PRIZE:String = "SlotMachinePrize";
      
      public function SlotmachinePrizeSubState(param1:DCGame, param2:* = null)
      {
         super("SlotMachinePrize",param1,SlotMachinePrizePopUpScreen,SlotMachinePrizeLogic,AssetsData.getPopupAssets(),param2);
      }
   }
}

