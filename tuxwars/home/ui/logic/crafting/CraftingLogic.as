package tuxwars.home.ui.logic.crafting
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxPageSubTabLogic;
   import tuxwars.home.ui.screen.crafting.CraftingScreen;
   import tuxwars.home.ui.screen.crafting.Research;
   import tuxwars.items.ShopItem;
   import tuxwars.states.TuxState;
   
   public class CraftingLogic extends TuxPageSubTabLogic
   {
      private static const TABLE:String = "Screen";
      
      private static const SHOP:String = "Crafting";
      
      public function CraftingLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public static function getStaticData() : Row
      {
         var _loc3_:String = "Screen";
         var _loc1_:ProjectManager = ProjectManager;
         var _loc4_:String = "Crafting";
         var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc3_);
         if(!_loc2_._cache[_loc4_])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id",_loc4_);
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_._cache[_loc4_] = _loc5_;
         }
         return _loc2_._cache[_loc4_];
      }
      
      override public function getData() : Row
      {
         return getStaticData();
      }
      
      override public function itemSelected(shopItem:ShopItem) : void
      {
         var _loc2_:Research = Research;
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         tuxwars.home.ui.screen.crafting.Research._instance.addIngridient(shopItem.id);
      }
      
      public function get craftingScreen() : CraftingScreen
      {
         return screen;
      }
      
      override public function itemDetails(shopItem:ShopItem) : void
      {
      }
   }
}

