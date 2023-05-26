package tuxwars.ui.popups.screen
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.Tuner;
   import tuxwars.home.states.shop.ShopState;
   import tuxwars.net.CRMService;
   
   public class NotEnoughAmmoScreen extends PopUpBaseImageScreen
   {
       
      
      public function NotEnoughAmmoScreen(game:TuxWarsGame, swf:String = "flash/ui/popups.swf", exportName:String = "popup_message")
      {
         super(game,swf,exportName);
         okButton.setText(ProjectManager.getText("BUTTON_NOT_ENOUGH_AMMO"));
      }
      
      override public function get tidDescriptionParams() : Array
      {
         var _loc1_:Tuner = Tuner;
         var _loc2_:Field = tuxwars.data.Tuner.getField("MinimumAmmoForMatch");
         return [!!_loc2_ ? _loc2_.value : 0];
      }
      
      override protected function okPressed(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Menu","Clicked","NotEnoughAmmoToSupplies");
         _game.homeState.changeState(new ShopState(_game));
         super.okPressed(event);
      }
   }
}
