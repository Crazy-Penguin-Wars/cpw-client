package tuxwars.home.ui.logic.equipment
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxPageSubTabLogic;
   import tuxwars.home.ui.logic.home.*;
   import tuxwars.home.ui.screen.equipment.EquipmentScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.net.*;
   import tuxwars.player.Player;
   import tuxwars.player.WornItems;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.*;
   
   public class EquipmentLogic extends TuxPageSubTabLogic
   {
      private static const TABLE:String = "Screen";
      
      private static const CHARACTER:String = "Character";
      
      private var _characterAvatarLogic:CharacterAvatarElementLogic;
      
      public function EquipmentLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
         this._characterAvatarLogic = new CharacterAvatarElementLogic(param1);
      }
      
      public static function getStaticData() : Row
      {
         var _loc4_:Row = null;
         var _loc1_:String = "Screen";
         var _loc2_:String = "Character";
         var _loc3_:* = ProjectManager.findTable(_loc1_);
         if(!_loc3_.getCache[_loc2_])
         {
            _loc4_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
            if(!_loc4_)
            {
               LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc2_] = _loc4_;
         }
         return _loc3_.getCache[_loc2_];
      }
      
      override public function getData() : Row
      {
         return getStaticData();
      }
      
      override public function init(param1:*) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:* = undefined;
         var _loc6_:Row = null;
         var _loc2_:Row = null;
         super.init(param1);
         this._characterAvatarLogic.init(param1);
         if(Boolean(Tutorial._tutorial) && Tutorial._tutorialStep == "TutorialStart")
         {
            _loc3_ = "Page";
            _loc4_ = "Customization";
            _loc5_ = ProjectManager.findTable(_loc3_);
            if(!_loc5_.getCache[_loc4_])
            {
               _loc6_ = DCUtils.find(_loc5_.rows,"id",_loc4_);
               if(!_loc6_)
               {
                  LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc5_.name + "\'",_loc5_,3);
               }
               _loc5_.getCache[_loc4_] = _loc6_;
            }
            _loc2_ = _loc5_.getCache[_loc4_];
            setCurrentPage(_loc2_);
            this.equipmentScreen.updatePageContent(_loc2_);
            this.equipmentScreen.tabGroup.setSelectedIndex(1);
            this.equipmentScreen.tabGroup.getButtonAt(0).setEnabled(false);
            this.equipmentScreen.tabGroup.getButtonAt(2).setEnabled(false);
         }
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         this._characterAvatarLogic.logicUpdate(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._characterAvatarLogic.dispose();
         this._characterAvatarLogic = null;
      }
      
      override public function itemSelected(param1:ShopItem) : void
      {
         if(ServerServices.isEquipmentChangingBusy())
         {
            return;
         }
         var _loc2_:Player = game.player;
         var _loc3_:WornItems = _loc2_.wornItemsContainer;
         var _loc4_:Boolean = _loc3_.containsClothingItem(_loc2_.inventory.getItem(param1.id));
         if(_loc4_)
         {
            if(!param1.categoryDefault)
            {
               MessageCenter.sendMessage("UnequipItem",param1);
            }
         }
         else
         {
            MessageCenter.sendMessage("EquipItem",param1);
         }
      }
      
      override public function itemDetails(param1:ShopItem) : void
      {
      }
      
      public function get characterAvatarLogic() : CharacterAvatarElementLogic
      {
         return this._characterAvatarLogic;
      }
      
      override public function set screen(param1:*) : void
      {
         super.screen = param1;
         this._characterAvatarLogic.screen = this.equipmentScreen.getCharacterAvatarScreen();
      }
      
      public function get equipmentScreen() : EquipmentScreen
      {
         return screen;
      }
      
      public function exit() : void
      {
         if(Boolean(Tutorial._tutorial) && Tutorial._tutorialStep == "TutorialStart")
         {
            Tutorial.saveTutorialStep("TutorialCustomizationDone");
         }
      }
   }
}

