package tuxwars.battle.ui.logic.weaponselection
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import tuxwars.GameSettings;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.ui.screen.weaponselection.WeaponSelectionScreen;
   import tuxwars.home.ui.logic.TuxPageSubTabLogic;
   import tuxwars.items.ShopItem;
   import tuxwars.items.WeaponItem;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.Tutorial;
   
   public class WeaponSelectionLogic extends TuxPageSubTabLogic
   {
      
      private static const TABLE:String = "Screen";
      
      private static const WEAPON_SELECTION:String = "WeaponSelection";
      
      private static const WEAPON_SELECTION_PRACTICE:String = "WeaponSelectionPractice";
      
      private static const WEAPON_SELECTION_TUTORIAL:String = "WeaponSelectionTutorial";
       
      
      public function WeaponSelectionLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public static function getStaticData() : Row
      {
         var rowName:* = null;
         var _loc2_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            rowName = "WeaponSelectionTutorial";
         }
         else if(BattleManager.isPracticeMode() && !GameSettings.getShowAllWeaponsInPractice())
         {
            rowName = "WeaponSelectionPractice";
         }
         else
         {
            rowName = "WeaponSelection";
         }
         var _loc3_:ProjectManager = ProjectManager;
         var _loc6_:* = rowName;
         var _loc4_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("Screen");
         if(!_loc4_._cache[_loc6_])
         {
            var _loc7_:Row = com.dchoc.utils.DCUtils.find(_loc4_.rows,"id",_loc6_);
            if(!_loc7_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc6_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_._cache[_loc6_] = _loc7_;
         }
         return _loc4_._cache[_loc6_];
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         var _loc2_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial && tuxwars.tutorial.Tutorial._tutorialStep == "TutorialChangeWeapon")
         {
            weaponSelectionScreen.subTabGroup.getSelectedButton().setEnabled(false);
            weaponSelectionScreen.closeButton.setEnabled(false);
         }
      }
      
      override public function getData() : Row
      {
         return getStaticData();
      }
      
      public function getItemsNoVIP(type:String, categories:Array = null) : Vector.<ShopItem>
      {
         return ShopItemManager.getShopItems(type,categories,false);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function exit() : void
      {
         close(game.battleState.hud);
      }
      
      private function weaponSelected(msg:Message) : void
      {
         exit();
      }
      
      override public function itemSelected(shopItem:ShopItem) : void
      {
         var _loc2_:WeaponItem = game.player.inventory.getItem(shopItem.id,BattleManager.isPracticeMode()) as WeaponItem;
         if(_loc2_ is WeaponItem)
         {
            MessageCenter.sendMessage("WeaponSelected",_loc2_);
         }
         exit();
      }
      
      override public function itemDetails(shopItem:ShopItem) : void
      {
         weaponSelectionScreen.setItemDetails(shopItem);
      }
      
      public function get weaponSelectionScreen() : WeaponSelectionScreen
      {
         return screen;
      }
   }
}
