package tuxwars.battle.ui.logic.boosterselection
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.boosterselection.BoosterSelectionScreen;
   import tuxwars.home.ui.logic.TuxPageSubTabLogic;
   import tuxwars.items.*;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.*;
   
   public class BoosterSelectionLogic extends TuxPageSubTabLogic
   {
      private static const TABLE:String = "Screen";
      
      private static const SHOP:String = "BoosterSelection";
      
      private static const BOOSTER_SELECTION_TUTORIAL:String = "BoosterSelectionTutorial";
      
      public function BoosterSelectionLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      public static function getStaticData() : Row
      {
         var _loc5_:Row = null;
         var _loc1_:String = null;
         if(Tutorial._tutorial)
         {
            _loc1_ = "BoosterSelectionTutorial";
         }
         else
         {
            _loc1_ = "BoosterSelection";
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
         if(Boolean(Tutorial._tutorial) && Tutorial._tutorialStep == "TutorialChangeBooster")
         {
            this.boosterSelectionScreen.subTabGroup.getSelectedButton().setEnabled(false);
            this.boosterSelectionScreen.closeButton.setEnabled(false);
         }
      }
      
      override public function getData() : Row
      {
         return getStaticData();
      }
      
      public function exit() : void
      {
         close(game.battleState.hud);
      }
      
      override public function itemSelected(param1:ShopItem) : void
      {
         var _loc2_:BoosterItem = game.player.inventory.getItem(param1.id) as BoosterItem;
         if(_loc2_)
         {
            MessageCenter.sendMessage("BooserSelected",_loc2_);
         }
         this.exit();
      }
      
      override public function itemDetails(param1:ShopItem) : void
      {
         this.boosterSelectionScreen.setItemDetails(param1);
      }
      
      public function get boosterSelectionScreen() : BoosterSelectionScreen
      {
         return screen;
      }
   }
}

