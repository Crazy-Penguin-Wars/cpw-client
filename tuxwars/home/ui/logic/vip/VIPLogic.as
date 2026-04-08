package tuxwars.home.ui.logic.vip
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.VIPPriceData;
   import tuxwars.home.states.vip.*;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.vip.*;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   import tuxwars.net.*;
   import tuxwars.net.messages.*;
   import tuxwars.states.TuxState;
   
   public class VIPLogic extends TuxUILogic
   {
      public static const VIP_EXPIRED_FLAG:String = "ShowVIPExpired";
      
      private var priceData:VIPPriceData;
      
      public function VIPLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      public function buyVIP(param1:VIPPriceData) : void
      {
         this.priceData = param1;
         this.vipScreen.disableOtherButtons(param1.id);
         var _loc2_:ServerRequest = new ServerRequest("BuyVIPMembership",{"vip_price_id":param1.id},false,this.serverCallback);
         MessageCenter.sendEvent(_loc2_);
         CRMService.sendEvent("Economy","Buy VIP","VIPMEMBERSHIP",param1.id);
      }
      
      public function exit() : void
      {
         if(game.homeState.state is VIPState)
         {
            super.close();
         }
         else
         {
            super.close(state.parent);
         }
      }
      
      public function get vipScreen() : VIPScreen
      {
         return screen as VIPScreen;
      }
      
      private function serverCallback(param1:ServerResponse) : void
      {
         var _loc2_:Row = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:* = undefined;
         var _loc14_:String = null;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:Row = null;
         var _loc18_:Row = null;
         _loc2_ = null;
         var _loc3_:ItemData = null;
         var _loc4_:Object = null;
         if(param1.data.vip_active_until)
         {
            MessageCenter.sendEvent(new SetFlagMessage("ShowVIPExpired","true"));
            game.player.vipMembership.vip = true;
            game.player.vipMembership.timeLeft = param1.data.vip_active_until;
            game.player.vipMembership.boughtPackId = param1.data.vip_price_id;
            switch(game.player.vipMembership.boughtPackId)
            {
               case "Price1":
                  this.vipScreen.memberShipContainer1.init(game.player.vipMembership,true);
                  this.vipScreen.memberShipContainer2.init(game.player.vipMembership,false);
                  this.vipScreen.memberShipContainer3.init(game.player.vipMembership,false);
                  break;
               case "Price2":
                  this.vipScreen.memberShipContainer1.init(game.player.vipMembership,false);
                  this.vipScreen.memberShipContainer2.init(game.player.vipMembership,true);
                  this.vipScreen.memberShipContainer3.init(game.player.vipMembership,false);
                  _loc5_ = "VIPPrice";
                  _loc6_ = "Price2";
                  _loc7_ = ProjectManager.findTable(_loc5_);
                  if(!_loc7_.getCache[_loc6_])
                  {
                     _loc17_ = DCUtils.find(_loc7_.rows,"id",_loc6_);
                     if(!_loc17_)
                     {
                        LogUtils.log("No row with name: \'" + _loc6_ + "\' was found in table: \'" + _loc7_.name + "\'",_loc7_,3);
                     }
                     _loc7_.getCache[_loc6_] = _loc17_;
                  }
                  _loc2_ = _loc7_.getCache[_loc6_];
                  _loc8_ = "Item";
                  _loc9_ = _loc2_;
                  if(!_loc9_.getCache[_loc8_])
                  {
                     _loc9_.getCache[_loc8_] = DCUtils.find(_loc9_.getFields(),"name",_loc8_);
                  }
                  _loc10_ = _loc9_.getCache[_loc8_];
                  _loc4_ = _loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value;
                  _loc3_ = ItemManager.getItemData(_loc4_.id);
                  if(_loc3_)
                  {
                     game.player.inventory.addItem(_loc3_.id,5);
                  }
                  break;
               case "Price3":
                  this.vipScreen.memberShipContainer1.init(game.player.vipMembership,false);
                  this.vipScreen.memberShipContainer2.init(game.player.vipMembership,false);
                  this.vipScreen.memberShipContainer3.init(game.player.vipMembership,true);
                  _loc11_ = "VIPPrice";
                  _loc12_ = "Price3";
                  _loc13_ = ProjectManager.findTable(_loc11_);
                  if(!_loc13_.getCache[_loc12_])
                  {
                     _loc18_ = DCUtils.find(_loc13_.rows,"id",_loc12_);
                     if(!_loc18_)
                     {
                        LogUtils.log("No row with name: \'" + _loc12_ + "\' was found in table: \'" + _loc13_.name + "\'",_loc13_,3);
                     }
                     _loc13_.getCache[_loc12_] = _loc18_;
                  }
                  _loc2_ = _loc13_.getCache[_loc12_];
                  _loc14_ = "Item";
                  _loc15_ = _loc2_;
                  if(!_loc15_.getCache[_loc14_])
                  {
                     _loc15_.getCache[_loc14_] = DCUtils.find(_loc15_.getFields(),"name",_loc14_);
                  }
                  _loc16_ = _loc15_.getCache[_loc14_];
                  _loc4_ = _loc16_.overrideValue != null ? _loc16_.overrideValue : _loc16_._value;
                  _loc3_ = ItemManager.getItemData(_loc4_.id);
                  if(_loc3_)
                  {
                     game.player.inventory.addItem(_loc3_.id,5);
                  }
            }
            this.vipScreen.disableOtherButtons(game.player.vipMembership.boughtPackId);
            this.vipScreen.updateButtonState(game.player.vipMembership.boughtPackId);
            game.player.addPremiumMoney(-this.priceData.price);
            MessageCenter.sendMessage("VipStatusChanged",true);
         }
      }
   }
}

