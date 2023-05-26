package tuxwars.home.ui.logic.shop
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import tuxwars.GameSettings;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.home.states.matchloading.MultiplayerMatchLoadingSubState;
   import tuxwars.home.states.matchloading.PracticeMatchLoadingSubState;
   import tuxwars.home.states.matchloading.TournamentMatchLoadingSubState;
   import tuxwars.home.ui.logic.TuxPageSubTabLogic;
   import tuxwars.home.ui.logic.home.CharacterAvatarElementLogic;
   import tuxwars.home.ui.screen.shop.ShopScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.net.ServerServices;
   import tuxwars.player.Player;
   import tuxwars.player.WornItems;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.Tutorial;
   
   public class ShopLogic extends TuxPageSubTabLogic
   {
      
      private static const TABLE:String = "Screen";
      
      private static const SHOP:String = "Shop";
      
      private static const WEAPON_SELECTION_TUTORIAL:String = "WeaponSelectionPractice";
       
      
      private var _characterAvatarLogic:CharacterAvatarElementLogic;
      
      public function ShopLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
         MessageCenter.addListener("VipStatusChanged",vipStatusChanged);
         _characterAvatarLogic = new CharacterAvatarElementLogic(game);
      }
      
      public static function getStaticData() : Row
      {
         var _loc1_:ProjectManager = ProjectManager;
         var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("Screen");
         if(!_loc2_._cache["Shop"])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id","Shop");
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Shop" + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_._cache["Shop"] = _loc5_;
         }
         return _loc2_._cache["Shop"];
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
            shopScreen.updatePageContent(_loc2_);
            shopScreen.tabGroup.setSelectedIndex(1);
            shopScreen.tabGroup.getButtonAt(0).setEnabled(false);
            shopScreen.tabGroup.getButtonAt(2).setEnabled(false);
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
         MessageCenter.removeListener("VipStatusChanged",vipStatusChanged);
      }
      
      override public function getData() : Row
      {
         var rowName:* = null;
         var _loc2_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            rowName = "WeaponSelectionPractice";
         }
         else
         {
            rowName = "Shop";
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
      
      override public function itemSelected(shopItem:ShopItem) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:Boolean = false;
         if(shopItem && (shopItem.type == "Clothing" || shopItem.type == "Customization" || shopItem.type == "Trophy"))
         {
            if(ServerServices.isEquipmentChangingBusy())
            {
               return;
            }
            _loc2_ = game.player;
            _loc3_ = _loc2_.wornItemsContainer;
            _loc4_ = _loc3_.containsClothingItem(_loc2_.inventory.getItem(shopItem.id));
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
      }
      
      override public function itemDetails(shopItem:ShopItem) : void
      {
      }
      
      public function get shopScreen() : ShopScreen
      {
         return screen;
      }
      
      private function vipStatusChanged(msg:Message) : void
      {
         if(msg.data)
         {
            shopScreen.createScreen(false);
         }
      }
      
      private function get battleResults() : BattleResults
      {
         return params;
      }
      
      public function playAgain() : void
      {
         var _loc1_:TuxWarsGame = game;
         if(!game.homeState)
         {
            _loc1_.changeState(new HomeState(_loc1_),true);
         }
         if(battleResults && battleResults.isPracticeMode)
         {
            GameSettings.setShowAllWeaponsInPractice(false);
            _loc1_.homeState.changeState(new PracticeMatchLoadingSubState(_loc1_));
         }
         else if(battleResults && battleResults.isTournamentMode)
         {
            _loc1_.homeState.changeState(new TournamentMatchLoadingSubState(_loc1_,new ServerRequest("PlayNow",{"tournament":true})));
         }
         else
         {
            _loc1_.homeState.changeState(new MultiplayerMatchLoadingSubState(_loc1_,new ServerRequest("PlayNow")));
         }
      }
      
      public function get characterAvatarLogic() : CharacterAvatarElementLogic
      {
         return _characterAvatarLogic;
      }
      
      override public function set screen(screen:*) : void
      {
         super.screen = screen;
         _characterAvatarLogic.screen = shopScreen.getCharacterAvatarScreen();
      }
   }
}
