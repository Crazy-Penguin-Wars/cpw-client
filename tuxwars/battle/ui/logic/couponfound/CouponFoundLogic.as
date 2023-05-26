package tuxwars.battle.ui.logic.couponfound
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.couponfound.CouponFoundScreen;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.states.TuxState;
   
   public class CouponFoundLogic extends TuxUILogic
   {
       
      
      public function CouponFoundLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function getShopItem(isWinner:Boolean, ndx:int) : ShopItem
      {
         var table:* = null;
         if(isWinner)
         {
            var _loc4_:ProjectManager = ProjectManager;
            table = com.dchoc.projectdata.ProjectManager.projectData.findTable("AfterResultsSalesWinner");
         }
         else
         {
            var _loc5_:ProjectManager = ProjectManager;
            table = com.dchoc.projectdata.ProjectManager.projectData.findTable("AfterResultsSalesLoser");
         }
         var _loc11_:* = "" + ndx;
         var _loc6_:* = table;
         §§push(§§findproperty(ShopItem));
         §§push(ItemManager);
         if(!_loc6_._cache[_loc11_])
         {
            var _loc12_:Row = com.dchoc.utils.DCUtils.find(_loc6_.rows,"id",_loc11_);
            if(!_loc12_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc11_ + "\' was found in table: \'" + _loc6_.name + "\'",_loc6_,3);
            }
            _loc6_._cache[_loc11_] = _loc12_;
         }
         var _loc7_:* = _loc6_._cache[_loc11_];
         if(!_loc7_._cache["ItemId"])
         {
            _loc7_._cache["ItemId"] = com.dchoc.utils.DCUtils.find(_loc7_._fields,"name","ItemId");
         }
         var _loc8_:* = _loc7_._cache["ItemId"];
         return new §§pop().ShopItem(§§pop().getItemData(_loc8_.overrideValue != null ? _loc8_.overrideValue : _loc8_._value));
      }
      
      public function get couponFoundScreen() : CouponFoundScreen
      {
         return screen;
      }
   }
}
