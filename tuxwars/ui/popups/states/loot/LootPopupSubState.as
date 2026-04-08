package tuxwars.ui.popups.states.loot
{
   import com.dchoc.game.DCGame;
   import no.olog.utilfunctions.*;
   import tuxwars.data.assets.*;
   import tuxwars.items.data.*;
   import tuxwars.ui.popups.logic.loot.*;
   import tuxwars.ui.popups.screen.loot.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class LootPopupSubState extends PopUpBaseSubState
   {
      public static const TYPE_LOOT:String = "TypeLoot";
      
      public function LootPopupSubState(param1:DCGame, param2:ItemData)
      {
         assert("params is not itemData!",true,param2 is ItemData);
         super("TypeLoot",param1,LootPopUpScreen,LootPopUpLogic,AssetsData.getPopupAssets(),param2);
      }
   }
}

