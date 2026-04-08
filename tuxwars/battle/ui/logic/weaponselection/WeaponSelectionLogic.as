package tuxwars.battle.ui.logic.weaponselection
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import tuxwars.*;
   import tuxwars.battle.*;
   import tuxwars.battle.ui.screen.weaponselection.WeaponSelectionScreen;
   import tuxwars.home.ui.logic.TuxPageSubTabLogic;
   import tuxwars.items.*;
   import tuxwars.items.managers.*;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.*;
   
   public class WeaponSelectionLogic extends TuxPageSubTabLogic
   {
      private static const TABLE:String = "Screen";
      
      private static const WEAPON_SELECTION:String = "WeaponSelection";
      
      private static const WEAPON_SELECTION_PRACTICE:String = "WeaponSelectionPractice";
      
      private static const WEAPON_SELECTION_TUTORIAL:String = "WeaponSelectionTutorial";
      
      public function WeaponSelectionLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      public static function getStaticData() : Row
      {
         var _loc5_:Row = null;
         var _loc1_:String = null;
         if(Tutorial._tutorial)
         {
            _loc1_ = "WeaponSelectionTutorial";
         }
         else if(Boolean(BattleManager.isPracticeMode()) && !GameSettings.getShowAllWeaponsInPractice())
         {
            _loc1_ = "WeaponSelectionPractice";
         }
         else
         {
            _loc1_ = "WeaponSelection";
         }
         var _loc2_:String = "Screen";
         var _loc3_:* = _loc1_;
         var _loc4_:* = ProjectManager.findTable(_loc2_);
         if(!_loc4_.getCache[_loc3_])
         {
            _loc5_ = DCUtils.find(_loc4_.rows,"id",_loc3_);
            if(!_loc5_)
            {
               LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_.getCache[_loc3_] = _loc5_;
         }
         return _loc4_.getCache[_loc3_];
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         if(Boolean(Tutorial._tutorial) && Tutorial._tutorialStep == "TutorialChangeWeapon")
         {
            this.weaponSelectionScreen.subTabGroup.getSelectedButton().setEnabled(false);
            this.weaponSelectionScreen.closeButton.setEnabled(false);
         }
      }
      
      override public function getData() : Row
      {
         return getStaticData();
      }
      
      public function getItemsNoVIP(param1:String, param2:Array = null) : Vector.<ShopItem>
      {
         return ShopItemManager.getShopItems(param1,param2,false);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function exit() : void
      {
         close(game.battleState.hud);
         trace("Ducktape fix: doing this twice because for some reason it won\'t dispose the first time.");
      }
      
      private function weaponSelected(param1:Message) : void
      {
         this.exit();
      }
      
      override public function itemSelected(param1:ShopItem) : void
      {
         var _loc2_:WeaponItem = game.player.inventory.getItem(param1.id,BattleManager.isPracticeMode()) as WeaponItem;
         if(_loc2_ is WeaponItem)
         {
            MessageCenter.sendMessage("WeaponSelected",_loc2_);
         }
         this.exit();
      }
      
      override public function itemDetails(param1:ShopItem) : void
      {
         this.weaponSelectionScreen.setItemDetails(param1);
      }
      
      public function get weaponSelectionScreen() : WeaponSelectionScreen
      {
         return screen;
      }
   }
}

