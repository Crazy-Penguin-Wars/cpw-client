package tuxwars.ui.popups.states.notenoughammo
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.ui.popups.logic.*;
   import tuxwars.ui.popups.screen.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class NotEnoughAmmoSubState extends PopUpBaseSubState
   {
      public static const TYPE_NOT_ENOUGH_AMMO:String = "TypeNotEnoughAmmo";
      
      public function NotEnoughAmmoSubState(param1:DCGame, param2:* = null)
      {
         super("TypeNotEnoughAmmo",param1,NotEnoughAmmoScreen,PopUpBaseLogic,AssetsData.getPopupAssets(),{
            "popupDataID":"not_enough_ammo",
            "params":param2
         });
      }
   }
}

