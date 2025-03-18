package tuxwars.home.ui.logic.vip
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.net.ServerResponse;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.VIPPriceData;
   import tuxwars.home.states.vip.VIPState;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.vip.VIPScreen;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.net.CRMService;
   import tuxwars.net.messages.SetFlagMessage;
   import tuxwars.states.TuxState;
   
   public class VIPLogic extends TuxUILogic
   {
      public static const VIP_EXPIRED_FLAG:String = "ShowVIPExpired";
      
      private var priceData:VIPPriceData;
      
      public function VIPLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function buyVIP(data:VIPPriceData) : void
      {
         priceData = data;
         vipScreen.disableOtherButtons(data.id);
         var _loc2_:ServerRequest = new ServerRequest("BuyVIPMembership",{"vip_price_id":data.id},false,serverCallback);
         MessageCenter.sendEvent(_loc2_);
         CRMService.sendEvent("Economy","Buy VIP","VIPMEMBERSHIP",data.id);
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
      
      private function serverCallback(response:ServerResponse) : void
      {
         var iconRow:Row = null;
         var giftItem:ItemData = null;
         var itemReference:Object = null;
         if(response.data.vip_active_until)
         {
            MessageCenter.sendEvent(new SetFlagMessage("ShowVIPExpired","true"));
            game.player.vipMembership.vip = true;
            game.player.vipMembership.timeLeft = response.data.vip_active_until;
            game.player.vipMembership.boughtPackId = response.data.vip_price_id;
            switch(game.player.vipMembership.boughtPackId)
            {
               case "Price1":
                  vipScreen.memberShipContainer1.init(game.player.vipMembership,true);
                  vipScreen.memberShipContainer2.init(game.player.vipMembership,false);
                  vipScreen.memberShipContainer3.init(game.player.vipMembership,false);
                  break;
               case "Price2":
                  vipScreen.memberShipContainer1.init(game.player.vipMembership,false);
                  vipScreen.memberShipContainer2.init(game.player.vipMembership,true);
                  vipScreen.memberShipContainer3.init(game.player.vipMembership,false);
                  var _loc13_:String = "VIPPrice";
                  var _loc5_:ProjectManager = ProjectManager;
                  var _loc14_:String = "Price2";
                  var _loc6_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc13_);
                  if(!_loc6_._cache[_loc14_])
                  {
                     var _loc15_:Row = com.dchoc.utils.DCUtils.find(_loc6_.rows,"id",_loc14_);
                     if(!_loc15_)
                     {
                        com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc14_ + "\' was found in table: \'" + _loc6_.name + "\'",_loc6_,3);
                     }
                     _loc6_._cache[_loc14_] = _loc15_;
                  }
                  iconRow = _loc6_._cache[_loc14_];
                  var _loc16_:String = "Item";
                  var _loc7_:* = iconRow;
                  if(!_loc7_._cache[_loc16_])
                  {
                     _loc7_._cache[_loc16_] = com.dchoc.utils.DCUtils.find(_loc7_._fields,"name",_loc16_);
                  }
                  var _loc8_:* = _loc7_._cache[_loc16_];
                  itemReference = _loc8_.overrideValue != null ? _loc8_.overrideValue : _loc8_._value;
                  giftItem = ItemManager.getItemData(itemReference.id);
                  if(giftItem)
                  {
                     game.player.inventory.addItem(giftItem.id,5);
                  }
                  break;
               case "Price3":
                  vipScreen.memberShipContainer1.init(game.player.vipMembership,false);
                  vipScreen.memberShipContainer2.init(game.player.vipMembership,false);
                  vipScreen.memberShipContainer3.init(game.player.vipMembership,true);
                  var _loc17_:String = "VIPPrice";
                  var _loc9_:ProjectManager = ProjectManager;
                  var _loc18_:String = "Price3";
                  var _loc10_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc17_);
                  if(!_loc10_._cache[_loc18_])
                  {
                     var _loc19_:Row = com.dchoc.utils.DCUtils.find(_loc10_.rows,"id",_loc18_);
                     if(!_loc19_)
                     {
                        com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc18_ + "\' was found in table: \'" + _loc10_.name + "\'",_loc10_,3);
                     }
                     _loc10_._cache[_loc18_] = _loc19_;
                  }
                  iconRow = _loc10_._cache[_loc18_];
                  var _loc20_:String = "Item";
                  var _loc11_:* = iconRow;
                  if(!_loc11_._cache[_loc20_])
                  {
                     _loc11_._cache[_loc20_] = com.dchoc.utils.DCUtils.find(_loc11_._fields,"name",_loc20_);
                  }
                  var _loc12_:* = _loc11_._cache[_loc20_];
                  itemReference = _loc12_.overrideValue != null ? _loc12_.overrideValue : _loc12_._value;
                  giftItem = ItemManager.getItemData(itemReference.id);
                  if(giftItem)
                  {
                     game.player.inventory.addItem(giftItem.id,5);
                  }
            }
            vipScreen.disableOtherButtons(game.player.vipMembership.boughtPackId);
            vipScreen.updateButtonState(game.player.vipMembership.boughtPackId);
            game.player.addPremiumMoney(-priceData.price);
            MessageCenter.sendMessage("VipStatusChanged",true);
         }
      }
   }
}

