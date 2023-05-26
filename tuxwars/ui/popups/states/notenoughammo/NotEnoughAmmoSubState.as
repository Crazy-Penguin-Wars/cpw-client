package tuxwars.ui.popups.states.notenoughammo
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   import tuxwars.ui.popups.screen.NotEnoughAmmoScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class NotEnoughAmmoSubState extends PopUpBaseSubState
   {
      
      public static const TYPE_NOT_ENOUGH_AMMO:String = "TypeNotEnoughAmmo";
       
      
      public function NotEnoughAmmoSubState(game:DCGame, params:* = null)
      {
         super("TypeNotEnoughAmmo",game,NotEnoughAmmoScreen,PopUpBaseLogic,AssetsData.getPopupAssets(),{
            "popupDataID":"not_enough_ammo",
            "params":params
         });
      }
   }
}
