package tuxwars.ui.popups.screen
{
   import com.dchoc.projectdata.*;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.home.states.shop.*;
   import tuxwars.net.*;
   
   public class NotEnoughAmmoScreen extends PopUpBaseImageScreen
   {
      public function NotEnoughAmmoScreen(param1:TuxWarsGame, param2:String = "flash/ui/popups.swf", param3:String = "popup_message")
      {
         super(param1,param2,param3);
         okButton.setText(ProjectManager.getText("BUTTON_NOT_ENOUGH_AMMO"));
      }
      
      override public function get tidDescriptionParams() : Array
      {
         var _loc1_:Field = Tuner.getField("MinimumAmmoForMatch");
         return [!!_loc1_ ? _loc1_.value : 0];
      }
      
      override protected function okPressed(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Menu","Clicked","NotEnoughAmmoToSupplies");
         _game.homeState.changeState(new ShopState(_game));
         super.okPressed(param1);
      }
   }
}

