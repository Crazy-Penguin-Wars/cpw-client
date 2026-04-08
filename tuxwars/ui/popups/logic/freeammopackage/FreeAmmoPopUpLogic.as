package tuxwars.ui.popups.logic.freeammopackage
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   import tuxwars.ui.popups.screen.firstvip.VipFirstTimePopUpScreen;
   
   public class FreeAmmoPopUpLogic extends PopUpBaseLogic
   {
      public function FreeAmmoPopUpLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
         MessageCenter.addListener("FreeWeaponPackageResponse",this.givePack);
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
      
      private function givePack(param1:Message) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:Object = param1.data;
         if(_loc5_ != null)
         {
            if(_loc5_.help_package != null)
            {
               if(_loc5_.help_package.coins != null)
               {
                  _loc2_ = int(_loc5_.help_package.coins);
                  game.player.addIngameMoney(_loc5_.help_package.coins);
               }
               if(_loc5_.weapon != null && _loc5_.weapon.itemID != null)
               {
                  _loc3_ = _loc5_.weapon.itemID;
                  _loc4_ = int(_loc5_.weapon.itemAmount);
                  game.player.inventory.addItem(_loc3_,_loc4_);
               }
            }
         }
      }
   }
}

