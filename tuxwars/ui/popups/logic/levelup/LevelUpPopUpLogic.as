package tuxwars.ui.popups.logic.levelup
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.utils.*;
   import org.as3commons.lang.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   import tuxwars.ui.popups.screen.levelup.*;
   
   public class LevelUpPopUpLogic extends PopUpBaseLogic
   {
      private var _unlockedItems:Vector.<ItemData>;
      
      public const itemDatas:Vector.<ItemData> = new Vector.<ItemData>();
      
      public function LevelUpPopUpLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function preInit(param1:*) : void
      {
         super.preInit(param1);
         this._unlockedItems = ItemManager.getItemsUnlockedAtLevel(this.levelReached);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         var _loc2_:Object = {"sectors":"basic"};
         MessageCenter.sendEvent(new ServerRequest("GetAccountInformation",_loc2_,false,this.accountCallback));
      }
      
      private function accountCallback(param1:ServerResponse) : void
      {
         var _loc2_:int = 0;
         var _loc3_:VipData = null;
         var _loc4_:int = 0;
         var _loc5_:CoinData = null;
         var _loc6_:int = 0;
         var _loc7_:CashData = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:ItemData = null;
         if(!game || !game.player || !this.getScreen())
         {
            LogUtils.log("Level up popup logic has been disposed!",this,3,"UI");
            return;
         }
         var _loc14_:int = int(param1.data.level);
         if(_loc14_ >= this.levelReached)
         {
            _loc2_ = this.rewardDaysOfVip;
            if(_loc2_ > 0)
            {
               _loc3_ = new VipData();
               _loc3_.setAmount(_loc2_);
               this.itemDatas.push(_loc3_);
               if(param1.data.vip_active_until)
               {
                  game.player.vipMembership.vip = true;
                  game.player.vipMembership.timeLeft = param1.data.vip_active_until;
                  game.player.vipMembership.boughtPackId = "Price1";
                  MessageCenter.sendMessage("VipStatusChanged",true);
               }
            }
            _loc4_ = this.rewardCoins;
            if(_loc4_ > 0)
            {
               _loc5_ = new CoinData();
               _loc5_.setAmount(_loc4_);
               this.itemDatas.push(_loc5_);
               game.player.addIngameMoney(_loc4_);
            }
            _loc6_ = this.rewardCash;
            if(_loc6_ > 0)
            {
               _loc7_ = new CashData();
               _loc7_.setAmount(_loc6_);
               this.itemDatas.push(_loc7_);
               game.player.addPremiumMoney(_loc6_);
            }
            _loc8_ = this.rewardItems;
            if(_loc8_ != null && _loc8_.length > 0)
            {
               _loc9_ = this.rewardItemsAmount;
               if(_loc9_ == null || _loc9_.length == 0)
               {
                  LogUtils.log("ItemsAmount array missing",this,4,"LevelUp",true,true,true);
               }
               else if(_loc8_.length != _loc9_.length)
               {
                  LogUtils.log("Items and ItemsAmount arrays are not equal in lenght",this,3,"LevelUp",true,true,true);
               }
               else
               {
                  while(_loc10_ < _loc8_.length)
                  {
                     if(_loc8_[_loc10_] != null && _loc9_[_loc10_] != null && StringUtils.compareToIgnoreCase(_loc8_[_loc10_],"NULL") != 0)
                     {
                        _loc11_ = _loc8_[_loc10_].id;
                        _loc12_ = int(_loc9_ != null && _loc9_.length > 0 ? _loc9_[_loc10_] : 1);
                        _loc13_ = new ItemData(_loc8_[_loc10_]);
                        _loc13_.setAmount(_loc12_);
                        this.itemDatas.push(_loc13_);
                        game.player.inventory.addItem(_loc11_,_loc12_);
                     }
                     _loc10_++;
                  }
               }
            }
         }
         this.getScreen().initRewardContainer(this.itemDatas);
      }
      
      public function get unlockedItems() : Vector.<ItemData>
      {
         return this._unlockedItems;
      }
      
      public function get rewardCoins() : int
      {
         return Experience.getRewardCoins(this.levelReached);
      }
      
      public function get rewardCash() : int
      {
         return Experience.getRewardCash(this.levelReached);
      }
      
      public function get rewardDaysOfVip() : int
      {
         return Experience.getRewardDaysOfVip(this.levelReached);
      }
      
      public function get rewardItems() : Array
      {
         return Experience.getRewardItems(this.levelReached);
      }
      
      public function get rewardItemsAmount() : Array
      {
         return Experience.getRewardItemsAmount(this.levelReached);
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
         return this.itemDatas;
      }
   }
}

