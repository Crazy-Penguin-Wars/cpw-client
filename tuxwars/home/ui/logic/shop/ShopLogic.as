package tuxwars.home.ui.logic.shop
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import tuxwars.*;
   import tuxwars.battle.BattleResults;
   import tuxwars.home.states.homestate.*;
   import tuxwars.home.states.matchloading.*;
   import tuxwars.home.ui.logic.TuxPageSubTabLogic;
   import tuxwars.home.ui.logic.home.*;
   import tuxwars.home.ui.screen.shop.ShopScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.net.*;
   import tuxwars.player.Player;
   import tuxwars.player.WornItems;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.*;
   
   public class ShopLogic extends TuxPageSubTabLogic
   {
      private static const TABLE:String = "Screen";
      
      private static const SHOP:String = "Shop";
      
      private static const WEAPON_SELECTION_TUTORIAL:String = "WeaponSelectionPractice";
      
      private var _characterAvatarLogic:CharacterAvatarElementLogic;
      
      public function ShopLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
         MessageCenter.addListener("VipStatusChanged",this.vipStatusChanged);
         this._characterAvatarLogic = new CharacterAvatarElementLogic(param1);
      }
      
      public static function getStaticData() : Row
      {
         var _loc4_:Row = null;
         var _loc1_:String = "Screen";
         var _loc2_:String = "Shop";
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
            this.shopScreen.updatePageContent(_loc2_);
            this.shopScreen.tabGroup.setSelectedIndex(1);
            this.shopScreen.tabGroup.getButtonAt(0).setEnabled(false);
            this.shopScreen.tabGroup.getButtonAt(2).setEnabled(false);
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
         MessageCenter.removeListener("VipStatusChanged",this.vipStatusChanged);
      }
      
      override public function getData() : Row
      {
         var _loc5_:Row = null;
         var _loc1_:String = null;
         if(Tutorial._tutorial)
         {
            _loc1_ = "WeaponSelectionPractice";
         }
         else
         {
            _loc1_ = "Shop";
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
      
      override public function itemSelected(param1:ShopItem) : void
      {
         var _loc2_:Player = null;
         var _loc3_:WornItems = null;
         var _loc4_:Boolean = false;
         if(Boolean(param1) && (param1.type == "Clothing" || param1.type == "Customization" || param1.type == "Trophy"))
         {
            if(ServerServices.isEquipmentChangingBusy())
            {
               return;
            }
            _loc2_ = game.player;
            _loc3_ = _loc2_.wornItemsContainer;
            _loc4_ = _loc3_.containsClothingItem(_loc2_.inventory.getItem(param1.id));
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
      }
      
      override public function itemDetails(param1:ShopItem) : void
      {
      }
      
      public function get shopScreen() : ShopScreen
      {
         return screen;
      }
      
      private function vipStatusChanged(param1:Message) : void
      {
         if(param1.data)
         {
            this.shopScreen.createScreen(false);
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
         if(Boolean(this.battleResults) && Boolean(this.battleResults.isPracticeMode))
         {
            GameSettings.setShowAllWeaponsInPractice(false);
            _loc1_.homeState.changeState(new PracticeMatchLoadingSubState(_loc1_));
         }
         else if(Boolean(this.battleResults) && Boolean(this.battleResults.isTournamentMode))
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
         return this._characterAvatarLogic;
      }
      
      override public function set screen(param1:*) : void
      {
         super.screen = param1;
         this._characterAvatarLogic.screen = this.shopScreen.getCharacterAvatarScreen();
      }
   }
}

