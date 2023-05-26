package tuxwars.home.ui.logic.equipment
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxPageSubTabLogic;
   import tuxwars.home.ui.logic.home.CharacterAvatarElementLogic;
   import tuxwars.home.ui.screen.equipment.EquipmentScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.net.ServerServices;
   import tuxwars.player.Player;
   import tuxwars.player.WornItems;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.Tutorial;
   
   public class EquipmentLogic extends TuxPageSubTabLogic
   {
      
      private static const TABLE:String = "Screen";
      
      private static const CHARACTER:String = "Character";
       
      
      private var _characterAvatarLogic:CharacterAvatarElementLogic;
      
      public function EquipmentLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
         _characterAvatarLogic = new CharacterAvatarElementLogic(game);
      }
      
      public static function getStaticData() : Row
      {
         var _loc1_:ProjectManager = ProjectManager;
         var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("Screen");
         if(!_loc2_._cache["Character"])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id","Character");
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Character" + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_._cache["Character"] = _loc5_;
         }
         return _loc2_._cache["Character"];
      }
      
      override public function getData() : Row
      {
         return getStaticData();
      }
      
      override public function init(params:*) : void
      {
         var _loc2_:* = null;
         super.init(params);
         _characterAvatarLogic.init(params);
         var _loc3_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial && tuxwars.tutorial.Tutorial._tutorialStep == "TutorialStart")
         {
            var _loc5_:ProjectManager = ProjectManager;
            var _loc6_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("Page");
            if(!_loc6_._cache["Customization"])
            {
               var _loc9_:Row = com.dchoc.utils.DCUtils.find(_loc6_.rows,"id","Customization");
               if(!_loc9_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + "Customization" + "\' was found in table: \'" + _loc6_.name + "\'",_loc6_,3);
               }
               _loc6_._cache["Customization"] = _loc9_;
            }
            _loc2_ = _loc6_._cache["Customization"];
            setCurrentPage(_loc2_);
            equipmentScreen.updatePageContent(_loc2_);
            equipmentScreen.tabGroup.setSelectedIndex(1);
            equipmentScreen.tabGroup.getButtonAt(0).setEnabled(false);
            equipmentScreen.tabGroup.getButtonAt(2).setEnabled(false);
         }
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         _characterAvatarLogic.logicUpdate(deltaTime);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _characterAvatarLogic.dispose();
         _characterAvatarLogic = null;
      }
      
      override public function itemSelected(shopItem:ShopItem) : void
      {
         if(ServerServices.isEquipmentChangingBusy())
         {
            return;
         }
         var _loc2_:Player = game.player;
         var _loc3_:WornItems = _loc2_.wornItemsContainer;
         var _loc4_:Boolean = _loc3_.containsClothingItem(_loc2_.inventory.getItem(shopItem.id));
         if(_loc4_)
         {
            if(!shopItem.categoryDefault)
            {
               MessageCenter.sendMessage("UnequipItem",shopItem);
            }
         }
         else
         {
            MessageCenter.sendMessage("EquipItem",shopItem);
         }
      }
      
      override public function itemDetails(shopItem:ShopItem) : void
      {
      }
      
      public function get characterAvatarLogic() : CharacterAvatarElementLogic
      {
         return _characterAvatarLogic;
      }
      
      override public function set screen(screen:*) : void
      {
         super.screen = screen;
         _characterAvatarLogic.screen = equipmentScreen.getCharacterAvatarScreen();
      }
      
      public function get equipmentScreen() : EquipmentScreen
      {
         return screen;
      }
      
      public function exit() : void
      {
         var _loc1_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial && tuxwars.tutorial.Tutorial._tutorialStep == "TutorialStart")
         {
            Tutorial.saveTutorialStep("TutorialCustomizationDone");
         }
      }
   }
}
