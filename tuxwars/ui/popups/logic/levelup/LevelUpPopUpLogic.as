package tuxwars.ui.popups.logic.levelup
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.net.ServerResponse;
   import com.dchoc.utils.LogUtils;
   import org.as3commons.lang.StringUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.Experience;
   import tuxwars.items.data.CashData;
   import tuxwars.items.data.CoinData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.data.VipData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   import tuxwars.ui.popups.screen.levelup.LevelUpPopUpScreen;
   
   public class LevelUpPopUpLogic extends PopUpBaseLogic
   {
       
      
      private var _unlockedItems:Vector.<ItemData>;
      
      public const itemDatas:Vector.<ItemData> = new Vector.<ItemData>();
      
      public function LevelUpPopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      override public function preInit(params:*) : void
      {
         super.preInit(params);
         _unlockedItems = ItemManager.getItemsUnlockedAtLevel(levelReached);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         var _loc2_:Object = {"sectors":"basic"};
         MessageCenter.sendEvent(new ServerRequest("GetAccountInformation",_loc2_,false,accountCallback));
      }
      
      private function accountCallback(response:ServerResponse) : void
      {
         var _loc10_:int = 0;
         var _loc3_:* = null;
         var _loc11_:int = 0;
         var _loc4_:* = null;
         var _loc13_:int = 0;
         var _loc2_:* = null;
         var _loc12_:* = null;
         var _loc14_:* = null;
         var i:int = 0;
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         if(!game || !game.player || !getScreen())
         {
            LogUtils.log("Level up popup logic has been disposed!",this,3,"UI");
            return;
         }
         var _loc9_:int = int(response.data.level);
         if(_loc9_ >= levelReached)
         {
            _loc10_ = rewardDaysOfVip;
            if(_loc10_ > 0)
            {
               _loc3_ = new VipData();
               _loc3_.setAmount(_loc10_);
               itemDatas.push(_loc3_);
               if(response.data.vip_active_until)
               {
                  game.player.vipMembership.vip = true;
                  game.player.vipMembership.timeLeft = response.data.vip_active_until;
                  game.player.vipMembership.boughtPackId = "Price1";
                  MessageCenter.sendMessage("VipStatusChanged",true);
               }
            }
            _loc11_ = rewardCoins;
            if(_loc11_ > 0)
            {
               _loc4_ = new CoinData();
               _loc4_.setAmount(_loc11_);
               itemDatas.push(_loc4_);
               game.player.addIngameMoney(_loc11_);
            }
            _loc13_ = rewardCash;
            if(_loc13_ > 0)
            {
               _loc2_ = new CashData();
               _loc2_.setAmount(_loc13_);
               itemDatas.push(_loc2_);
               game.player.addPremiumMoney(_loc13_);
            }
            _loc12_ = rewardItems;
            if(_loc12_ != null && _loc12_.length > 0)
            {
               _loc14_ = rewardItemsAmount;
               if(_loc14_ == null || _loc14_.length == 0)
               {
                  LogUtils.log("ItemsAmount array missing",this,4,"LevelUp",true,true,true);
               }
               else if(_loc12_.length != _loc14_.length)
               {
                  LogUtils.log("Items and ItemsAmount arrays are not equal in lenght",this,3,"LevelUp",true,true,true);
               }
               else
               {
                  while(i < _loc12_.length)
                  {
                     if(_loc12_[i] != null && _loc14_[i] != null && StringUtils.compareToIgnoreCase(_loc12_[i],"NULL") != 0)
                     {
                        _loc5_ = _loc12_[i].id;
                        _loc7_ = int(_loc14_ != null && _loc14_.length > 0 ? _loc14_[i] : 1);
                        _loc8_ = new ItemData(_loc12_[i]);
                        _loc8_.setAmount(_loc7_);
                        itemDatas.push(_loc8_);
                        game.player.inventory.addItem(_loc5_,_loc7_);
                     }
                     i++;
                  }
               }
            }
         }
         getScreen().initRewardContainer(itemDatas);
      }
      
      public function get unlockedItems() : Vector.<ItemData>
      {
         return _unlockedItems;
      }
      
      public function get rewardCoins() : int
      {
         return Experience.getRewardCoins(levelReached);
      }
      
      public function get rewardCash() : int
      {
         return Experience.getRewardCash(levelReached);
      }
      
      public function get rewardDaysOfVip() : int
      {
         return Experience.getRewardDaysOfVip(levelReached);
      }
      
      public function get rewardItems() : Array
      {
         return Experience.getRewardItems(levelReached);
      }
      
      public function get rewardItemsAmount() : Array
      {
         return Experience.getRewardItemsAmount(levelReached);
      }
      
      public function get levelReached() : int
      {
         return params;
      }
      
      private function getScreen() : LevelUpPopUpScreen
      {
         return screen as LevelUpPopUpScreen;
      }
      
      public function returnItemData() : Vector.<ItemData>
      {
         return itemDatas;
      }
   }
}
