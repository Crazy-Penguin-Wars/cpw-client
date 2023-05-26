package tuxwars.ui.popups.states.loot
{
   import com.dchoc.game.DCGame;
   import no.olog.utilfunctions.assert;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.items.data.ItemData;
   import tuxwars.ui.popups.logic.loot.LootPopUpLogic;
   import tuxwars.ui.popups.screen.loot.LootPopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class LootPopupSubState extends PopUpBaseSubState
   {
      
      public static const TYPE_LOOT:String = "TypeLoot";
       
      
      public function LootPopupSubState(game:DCGame, item:ItemData)
      {
         assert("params is not itemData!",true,item is ItemData);
         super("TypeLoot",game,LootPopUpScreen,LootPopUpLogic,AssetsData.getPopupAssets(),item);
      }
   }
}
