package tuxwars.battle.ui.logic.couponfound
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.couponfound.CouponFoundScreen;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.items.*;
   import tuxwars.items.managers.*;
   import tuxwars.states.TuxState;
   
   public class CouponFoundLogic extends TuxUILogic
   {
      public function CouponFoundLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      public function getShopItem(param1:Boolean, param2:int) : ShopItem
      {
         var _loc3_:Table = null;
         var _loc8_:Row = null;
         if(param1)
         {
            _loc3_ = ProjectManager.findTable("AfterResultsSalesWinner");
         }
         else
         {
            _loc3_ = ProjectManager.findTable("AfterResultsSalesLoser");
         }
         var _loc4_:String = "" + param2;
         if(!_loc3_.getCache[_loc4_])
         {
            _loc8_ = DCUtils.find(_loc3_.rows,"id",_loc4_);
            if(!_loc8_)
            {
               LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc4_] = _loc8_;
         }
         var _loc5_:Row = _loc3_.getCache[_loc4_];
         if(!_loc5_.getCache["ItemId"])
         {
            _loc5_.getCache["ItemId"] = DCUtils.find(_loc5_.getFields(),"name","ItemId");
         }
         var _loc6_:Field = _loc5_.getCache["ItemId"];
         var _loc7_:* = _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value;
         return new ShopItem(ItemManager.getItemData(_loc7_));
      }
      
      public function get couponFoundScreen() : CouponFoundScreen
      {
         return screen;
      }
   }
}

