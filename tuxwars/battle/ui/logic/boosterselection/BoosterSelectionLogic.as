package tuxwars.battle.ui.logic.boosterselection
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.boosterselection.BoosterSelectionScreen;
   import tuxwars.home.ui.logic.TuxPageSubTabLogic;
   import tuxwars.items.BoosterItem;
   import tuxwars.items.ShopItem;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.Tutorial;
   
   public class BoosterSelectionLogic extends TuxPageSubTabLogic
   {
      
      private static const TABLE:String = "Screen";
      
      private static const SHOP:String = "BoosterSelection";
      
      private static const BOOSTER_SELECTION_TUTORIAL:String = "BoosterSelectionTutorial";
       
      
      public function BoosterSelectionLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public static function getStaticData() : Row
      {
         var rowName:* = null;
         var _loc2_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            rowName = "BoosterSelectionTutorial";
         }
         else
         {
            rowName = "BoosterSelection";
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
         if(tuxwars.tutorial.Tutorial._tutorial && tuxwars.tutorial.Tutorial._tutorialStep == "TutorialChangeBooster")
         {
            boosterSelectionScreen.subTabGroup.getSelectedButton().setEnabled(false);
            boosterSelectionScreen.closeButton.setEnabled(false);
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
      
      override public function itemSelected(shopItem:ShopItem) : void
      {
         var _loc2_:BoosterItem = game.player.inventory.getItem(shopItem.id) as BoosterItem;
         if(_loc2_)
         {
            MessageCenter.sendMessage("BooserSelected",_loc2_);
         }
         exit();
      }
      
      override public function itemDetails(shopItem:ShopItem) : void
      {
         boosterSelectionScreen.setItemDetails(shopItem);
      }
      
      public function get boosterSelectionScreen() : BoosterSelectionScreen
      {
         return screen;
      }
   }
}
