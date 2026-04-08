package tuxwars.home.ui.logic.crafting
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxPageSubTabLogic;
   import tuxwars.home.ui.screen.crafting.*;
   import tuxwars.items.ShopItem;
   import tuxwars.states.TuxState;
   
   public class CraftingLogic extends TuxPageSubTabLogic
   {
      private static const TABLE:String = "Screen";
      
      private static const SHOP:String = "Crafting";
      
      public function CraftingLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      public static function getStaticData() : Row
      {
         var _loc4_:Row = null;
         var _loc1_:String = "Screen";
         var _loc2_:String = "Crafting";
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
      
      override public function itemSelected(param1:ShopItem) : void
      {
         if(!Research._instance)
         {
            new Research();
         }
         Research._instance.addIngridient(param1.id);
      }
      
      public function get craftingScreen() : CraftingScreen
      {
         return screen;
      }
      
      override public function itemDetails(param1:ShopItem) : void
      {
      }
   }
}

