package tuxwars.ui.popups.logic.freeammopackage
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   import tuxwars.ui.popups.screen.firstvip.VipFirstTimePopUpScreen;
   
   public class FreeAmmoPopUpLogic extends PopUpBaseLogic
   {
       
      
      public function FreeAmmoPopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
         MessageCenter.addListener("FreeWeaponPackageResponse",givePack);
         MessageCenter.sendMessage("FreeWeaponPackage");
      }
      
      public function get headerText() : String
      {
         return ProjectManager.getText("FREE_AMMO_PACKAGE_HEADER");
      }
      
      public function get messageText() : String
      {
         return ProjectManager.getText("FREE_AMMO_PACKAGE_TEXT");
      }
      
      public function get messageScreen() : VipFirstTimePopUpScreen
      {
         return screen;
      }
      
      public function get picture() : String
      {
         return null;
      }
      
      private function givePack(msg:Message) : void
      {
         var coins:int = 0;
         var weapons:* = null;
         var amount:int = 0;
         var _loc4_:Object = msg.data;
         if(_loc4_ != null)
         {
            if(_loc4_.help_package != null)
            {
               if(_loc4_.help_package.coins != null)
               {
                  coins = int(_loc4_.help_package.coins);
                  game.player.addIngameMoney(_loc4_.help_package.coins);
               }
               if(_loc4_.weapon != null && _loc4_.weapon.itemID != null)
               {
                  weapons = _loc4_.weapon.itemID;
                  amount = int(_loc4_.weapon.itemAmount);
                  game.player.inventory.addItem(weapons,amount);
               }
            }
         }
      }
   }
}
