package tuxwars.home.ui.logic.crafting
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
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
         var _loc1_:ProjectManager = ProjectManager;
         var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("Screen");
         if(!_loc2_._cache["Crafting"])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id","Crafting");
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Crafting" + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_._cache["Crafting"] = _loc5_;
         }
         return _loc2_._cache["Crafting"];
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
