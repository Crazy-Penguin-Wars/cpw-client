package tuxwars.player
{
   import com.dchoc.friends.*;
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.gameobjects.stats.modifier.*;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.*;
   import tuxwars.battle.events.PlayerFiredMessage;
   import tuxwars.battle.net.messages.history.*;
   import tuxwars.battle.weapons.Weapon;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.*;
   import tuxwars.data.*;
   import tuxwars.events.*;
   import tuxwars.home.ui.screen.crafting.*;
   import tuxwars.items.*;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   import tuxwars.items.references.PriceObject;
   import tuxwars.net.messages.*;
   import tuxwars.tournament.Tournament;
   import tuxwars.trophys.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.popups.*;
   
   public class Player extends TuxFriend
   {
      private const _vipMembership:VIPMembership = new VIPMembership();
      
      private const _friends:Friends = new Friends();
      
      private var _playerSpecificStats:Stats;
      
      private var _ingameMoney:int;
      
      private var _premiumMoney:int;
      
      private var _slotMachineSpinsUsed:int;
      
      private var _ai:Boolean;
      
      private var _local:Boolean;
      
      private var _dummy:Boolean;
      
      private var _dailyRewards:Array = [];
      
      private var _dailyReward1:Array = [];
      
      private var _dailyReward2:Array = [];
      
      private var _dailyReward3:Array = [];
      
      private var _dailyReward4:Array = [];
      
      private var _dailyReward5:Array = [];
      
      private var _dailyRewardDay:int;
      
      private var _controlLevelUp:int;
      
      private var challengesData:Object;
      
      private var _betData:BetData;
      
      private var _tournamentAvailable:Boolean;
      
      private var _tournament:Tournament;
      
      private var _tournamentMatchLeagueId:String;
      
      private var _tournamentMatch:Boolean;
      
      public var _expiredVipMembershipPopup:Boolean = false;
      
      public function Player(param1:Boolean)
      {
         super();
         this._local = param1;
         this._playerSpecificStats = new Stats();
         this._playerSpecificStats.create("Exp",null);
         this._tournamentMatchLeagueId = null;
         this._tournamentMatch = false;
         this._friends.addFriend(this);
      }
      
      override public function init(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         assert("Loading player data.",true,param1 != null);
         super.init(param1);
         name = param1.name != null ? param1.name : ProjectManager.getText("DEFAULT_FRIEND_NAME");
         picUrl = param1.pic_url;
         level = param1.level;
         status = "Player";
         if(param1.dcg_id != null)
         {
            id = param1.dcg_id.toString();
         }
         else if(param1.id != null)
         {
            id = param1.id.toString();
         }
         else
         {
            LogUtils.log("Did not find a USER ID in data!",this,3,"Warning",false,false,true);
         }
         this._ingameMoney = param1.coins;
         this._premiumMoney = param1.cash;
         this._slotMachineSpinsUsed = param1.slot_machine_used_spins;
         var _loc4_:int = int(param1.score != null ? param1.score : Experience.getScore(param1.level));
         this.loadStat("Exp",_loc4_);
         this._controlLevelUp = this.level;
         this.loadFriends(param1.neighbors,param1.user_data);
         if(param1.vip_active_until)
         {
            this.vipMembership.vip = true;
            this.vipMembership.timeLeft = param1.vip_active_until;
            if(param1.vip_price_id)
            {
               this.vipMembership.boughtPackId = param1.vip_price_id;
            }
            else
            {
               _loc2_ = param1.vip_active_until / 86400;
               if(_loc2_ > 7)
               {
                  this.vipMembership.boughtPackId = "Price3";
               }
               else if(_loc2_ > 1)
               {
                  this.vipMembership.boughtPackId = "Price2";
               }
               else
               {
                  this.vipMembership.boughtPackId = "Price1";
               }
            }
         }
         else
         {
            this.vipMembership.boughtPackId = param1.vip_price_id;
            if(param1.flags)
            {
               _loc3_ = this.getFlagFromId(param1.flags,"ShowVIPExpired");
               if(Boolean(_loc3_) && Boolean(_loc3_.value))
               {
                  this._expiredVipMembershipPopup = true;
                  this.vipMembership.wasWip = true;
                  MessageCenter.sendEvent(new SetFlagMessage("ShowVIPExpired","false"));
               }
               else
               {
                  this._expiredVipMembershipPopup = false;
               }
            }
         }
         this.loadItems(param1.items);
         this.loadFreeEquipment();
         this.loadRecipes(param1.known_recipes);
         this.unlockItems(param1.unlocked_items);
         this.wearItems(param1.worn_items);
         if(!Research._instance)
         {
            new Research();
         }
         Research._instance.load(param1.ongoing_research);
         if(Tutorial._tutorial)
         {
            this.challengesData = !!param1.active_challenges ? param1.active_challenges : param1.challenges;
         }
         else if(param1.active_challenges != null || param1.challenges != null)
         {
            if(!ChallengeManager.instance)
            {
               ChallengeManager.instance = new ChallengeManager();
            }
            ChallengeManager.instance.addPlayerChallenges(id,!!param1.active_challenges ? param1.active_challenges : param1.challenges,this._local);
            TrophyManager.addTrophies(this);
            MessageCenter.sendEvent(new ChallengeReachLevelMessage(this.level,id));
         }
         if(param1.dailyRewards)
         {
            this._dailyRewardDay = param1.dailyRewards.currentDay;
            this.createDailyRewards(param1);
         }
         if(param1.flags)
         {
            SoundManager.loadSoundsStates(param1.flags);
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.loadFlags(param1.flags);
         }
         if(param1.available_features)
         {
            this._tournamentAvailable = param1.available_features.tournament;
         }
         this.addListeners();
      }
      
      override public function dispose() : void
      {
         this._playerSpecificStats.dispose();
         this._playerSpecificStats = null;
         this.removeListeners();
         super.dispose();
      }
      
      override public function isMe() : Boolean
      {
         return this._local;
      }
      
      override public function toString() : String
      {
         return name + " (" + id + ")";
      }
      
      public function get vipMembership() : VIPMembership
      {
         return this._vipMembership;
      }
      
      public function getNextBooster() : BoosterItem
      {
         var _loc3_:* = undefined;
         var _loc1_:BoosterItem = null;
         var _loc2_:Vector.<ShopItem> = ShopItemManager.getShopItems("Booster");
         for each(_loc3_ in _loc2_)
         {
            if(inventory.hasItem(_loc3_.id))
            {
               if(_loc1_)
               {
                  if(_loc1_.sortPriority > _loc3_.sortPriority)
                  {
                     _loc1_ = inventory.getItem(_loc3_.id) as BoosterItem;
                  }
               }
               else
               {
                  _loc1_ = inventory.getItem(_loc3_.id) as BoosterItem;
               }
            }
         }
         return _loc1_;
      }
      
      public function set ai(param1:Boolean) : void
      {
         this._ai = param1;
      }
      
      public function get ai() : Boolean
      {
         return this._ai;
      }
      
      public function get dummy() : Boolean
      {
         return this._dummy;
      }
      
      public function set dummy(param1:Boolean) : void
      {
         this._dummy = param1;
      }
      
      public function get expValue() : int
      {
         return this._playerSpecificStats.getStat("Exp").calculateRoundedValue();
      }
      
      public function addExp(param1:int) : void
      {
         var _loc2_:int = 0;
         if(param1 != 0)
         {
            this._playerSpecificStats.getStat("Exp").addModifier(new StatAdd("ExperienceAdded",param1));
            MessageCenter.sendEvent(new ExpChangedMessage(this.expValue,param1));
            if(this.level > this._controlLevelUp)
            {
               _loc2_ = this.level;
               LogUtils.log("Level Up from: " + this._controlLevelUp + " to: " + _loc2_,this,4,"Player",false,false,false);
               MessageCenter.sendMessage("LevelUp",_loc2_);
               MessageCenter.sendEvent(new ChallengeReachLevelMessage(_loc2_,id));
               while(this._controlLevelUp < _loc2_)
               {
                  this._controlLevelUp += 1;
                  if(!PopUpManager.instance)
                  {
                     PopUpManager.instance = new PopUpManager();
                  }
                  PopUpManager.instance.triggerLevelUpPopup(this._controlLevelUp,this._controlLevelUp >= _loc2_);
               }
            }
         }
      }
      
      override public function get level() : int
      {
         return Experience.getLevel(this.expValue);
      }
      
      public function get ingameMoney() : int
      {
         return this._ingameMoney;
      }
      
      public function set ingameMoney(param1:int) : void
      {
         this._ingameMoney = param1;
      }
      
      public function get premiumMoney() : int
      {
         return this._premiumMoney;
      }
      
      public function set premiumMoney(param1:int) : void
      {
         this._premiumMoney = param1;
      }
      
      public function get slotMachineSpinsUsed() : int
      {
         return this._slotMachineSpinsUsed;
      }
      
      public function set slotMachineSpinsUsed(param1:int) : void
      {
         this._slotMachineSpinsUsed = param1;
         MessageCenter.sendMessage("SlotMachineFreeSpinsUsed");
      }
      
      public function addIngameMoney(param1:int, param2:Boolean = true) : void
      {
         if(param1 != 0)
         {
            LogUtils.log("Adding ingame money: " + param1 + " to player: " + this,this,1,"Player",false,false,false);
            this._ingameMoney += param1;
            MessageCenter.sendEvent(new IngameMoneyChangedMessage(this._ingameMoney,param1));
            if(param2 && param1 > 0)
            {
               MessageCenter.sendEvent(new ChallengeGainedCoinsMessage(param1,id));
            }
         }
      }
      
      public function addPremiumMoney(param1:int) : void
      {
         if(param1 != 0)
         {
            LogUtils.log("Adding premium money: " + param1 + " to player: " + this,this,1,"Player",false,false,false);
            this._premiumMoney += param1;
            MessageCenter.sendEvent(new PremiumMoneyChangedMessage(this._premiumMoney,param1));
         }
      }
      
      public function get friends() : Friends
      {
         return this._friends;
      }
      
      public function get dailyRewards() : Array
      {
         return this._dailyRewards;
      }
      
      public function get dailyRewardDay() : int
      {
         return this._dailyRewardDay;
      }
      
      public function get betData() : BetData
      {
         return this._betData;
      }
      
      public function set betData(param1:BetData) : void
      {
         this._betData = param1;
      }
      
      public function isTournamentAvailable() : Boolean
      {
         return Boolean(this._tournamentAvailable) && Boolean(this._tournament) && this.level >= this._tournament.requiredLevel;
      }
      
      public function isTournamentFinished() : Boolean
      {
         if(this.isTournamentAvailable() && this._tournament.league && Boolean(this._tournament.league.isLeagueFinished()))
         {
            return true;
         }
         return false;
      }
      
      public function get tournament() : Tournament
      {
         return this._tournament;
      }
      
      public function set tournament(param1:Tournament) : void
      {
         this._tournament = param1;
      }
      
      public function setMatchLeagueInfo(param1:Boolean, param2:String) : void
      {
         this._tournamentMatch = param1;
         this._tournamentMatchLeagueId = param2;
      }
      
      public function getMatchLeagueInfo() : String
      {
         if(this._tournamentMatch)
         {
            return this._tournamentMatchLeagueId;
         }
         return null;
      }
      
      public function initChallenges() : void
      {
         if(this.challengesData)
         {
            if(!ChallengeManager.instance)
            {
               ChallengeManager.instance = new ChallengeManager();
            }
            ChallengeManager.instance.addPlayerChallenges(id,this.challengesData,this._local);
            this.challengesData = null;
            TrophyManager.addTrophies(this);
            MessageCenter.sendMessage("ChallengesUpdated");
         }
      }
      
      private function loadFriends(param1:Object, param2:Object) : void
      {
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:TuxFriend = null;
         var _loc8_:Boolean = false;
         if(param2)
         {
            _loc3_ = param2.user != null ? param2.user : param2;
            _loc4_ = _loc3_ is Array ? _loc3_ as Array : [_loc3_];
            _loc5_ = [];
            if(param1)
            {
               _loc6_ = param1.dcg_id != null ? param1.dcg_id : param1;
               _loc5_ = _loc6_ is Array ? _loc6_ as Array : [_loc6_];
            }
            for each(_loc9_ in _loc4_)
            {
               if(_loc9_)
               {
                  _loc7_ = new TuxFriend();
                  _loc7_.init(_loc9_);
                  _loc8_ = false;
                  for each(_loc10_ in _loc5_)
                  {
                     if(_loc10_)
                     {
                        if(_loc9_.dcg_id == _loc10_)
                        {
                           _loc8_ = true;
                           break;
                        }
                     }
                  }
                  _loc7_.status = _loc8_ ? "Neighbor" : "NoNeighbor";
                  this._friends.addFriend(_loc7_);
               }
            }
         }
      }
      
      private function loadStat(param1:String, param2:Number) : void
      {
         if(!isNaN(param2))
         {
            this._playerSpecificStats.getStat(param1).getBaseModifier().value = param2;
         }
      }
      
      private function loadItems(param1:Object) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         if(param1)
         {
            _loc2_ = param1.item != null ? param1.item : param1;
            _loc3_ = _loc2_ is Array ? _loc2_ as Array : [_loc2_];
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_)
               {
                  LogUtils.addDebugLine("Player","Adding item: " + _loc4_.item_id + " amount: " + _loc4_.amount,"Player");
                  inventory.setItem(_loc4_.item_id,_loc4_.amount);
               }
            }
         }
      }
      
      private function loadFreeEquipment() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Vector.<ShopItem> = null;
         var _loc4_:Vector.<ShopItem> = null;
         var _loc1_:Vector.<ShopItem> = ShopItemManager.getShopItems("Clothing");
         for each(_loc2_ in _loc1_)
         {
            if(Boolean(_loc2_.isFree()) && !inventory.getItem(_loc2_.id))
            {
               inventory.addItem(_loc2_.id);
            }
         }
         _loc3_ = ShopItemManager.getShopItems("Customization");
         for each(_loc2_ in _loc3_)
         {
            if(Boolean(_loc2_.isFree()) && !inventory.getItem(_loc2_.id))
            {
               inventory.addItem(_loc2_.id);
            }
         }
         _loc4_ = ShopItemManager.getShopItems("Booster");
         for each(_loc2_ in _loc4_)
         {
            if(Boolean(_loc2_.isFree()) && !inventory.getItem(_loc2_.id))
            {
               inventory.addItem(_loc2_.id);
            }
         }
      }
      
      private function loadRecipes(param1:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = null;
         if(param1)
         {
            _loc2_ = param1 is Array ? param1 as Array : [param1];
            for each(_loc3_ in _loc2_)
            {
               if(_loc3_ && !inventory.getItem(_loc3_.recipe_id))
               {
                  LogUtils.addDebugLine("Player","Adding recipe item: " + _loc3_.item_id,"Player");
                  inventory.addItem(_loc3_.recipe_id);
               }
            }
         }
      }
      
      private function unlockItems(param1:Object) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         if(param1)
         {
            _loc2_ = param1.unlocked_item != null ? param1.unlocked_item : param1;
            _loc3_ = _loc2_ is Array ? _loc2_ as Array : [_loc2_];
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_ != null)
               {
                  LogUtils.addDebugLine("Player","Unlocking item: " + _loc4_.item_id,"Player");
                  ItemManager.unlockItemWithId(_loc4_.item_id);
               }
            }
         }
      }
      
      private function wearItems(param1:Object) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         this.wearDefaultValues();
         if(param1)
         {
            _loc2_ = param1.worn_item != null ? param1.worn_item : param1;
            _loc3_ = _loc2_ is Array ? _loc2_ as Array : [_loc2_];
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_ != null)
               {
                  this.wearItem(_loc4_ is String ? _loc4_ as String : _loc4_.item_id);
               }
            }
         }
         wornItemsContainer.wornItemsIncludedItemCheck();
      }
      
      private function wearDefaultValues() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:Vector.<Item> = inventory.findItems("Customization");
         for each(_loc2_ in _loc1_)
         {
            if(CustomizationItem(_loc2_).isDefaultValue())
            {
               this.wearItem(_loc2_.id);
            }
         }
      }
      
      private function wearItem(param1:String) : void
      {
         LogUtils.addDebugLine("Player","Wearing item: " + param1,"Player");
         wornItemsContainer.wearItem(param1);
      }
      
      private function itemBoughtLevelUpSales(param1:Message) : void
      {
         if(param1 && param1.data && Boolean(param1.data.item))
         {
            if(param1.data.item.reduced_cash > 0)
            {
               this.itemBought(param1,param1.data.item.reduced_cash);
            }
            else
            {
               this.itemBought(param1,param1.data.item.reduced_coins);
            }
         }
         else
         {
            LogUtils.log("Incorrect message data",this,2,"Warning");
         }
      }
      
      private function itemBoughtCouponSales(param1:Message) : void
      {
         var _loc2_:ShopItem = null;
         var _loc3_:PriceObject = null;
         var _loc4_:CouponData = ItemManager.getItemData(param1.data.item.coupon_id) as CouponData;
         if(_loc4_)
         {
            _loc2_ = ShopItemManager.getShopItemWithId(param1.data.item.item_id);
            _loc3_ = _loc2_.priceObject;
            this.itemBought(param1,_loc3_.isPremium ? _loc4_.couponPremiumPrice : _loc4_.couponInGamePrice);
         }
      }
      
      private function itemBought(param1:Message, param2:int = -1) : void
      {
         var _loc3_:MegaPackData = null;
         var _loc4_:int = 0;
         var _loc5_:Row = null;
         var _loc6_:int = 0;
         var _loc7_:ItemData = null;
         var _loc8_:Object = null;
         var _loc9_:Object = param1.data;
         var _loc10_:String = _loc9_.item.item_id;
         var _loc11_:int = int(_loc9_.item.total_amount);
         var _loc12_:int = int(_loc9_.item.bought_amount);
         var _loc13_:ShopItem = ShopItemManager.getShopItemWithId(_loc10_);
         var _loc14_:PriceObject = _loc13_.priceObject;
         var _loc15_:int = param2 != -1 ? param2 : _loc14_.priceValue;
         var _loc16_:ItemData = ItemManager.getItemData(_loc9_.item.item_id);
         if((Boolean(_loc16_)) && _loc16_.type == "MegaPack")
         {
            _loc3_ = _loc16_ as MegaPackData;
            if(_loc3_.itemList)
            {
               while(_loc4_ < _loc3_.itemList.length)
               {
                  _loc5_ = _loc3_.itemList[_loc4_];
                  _loc6_ = int(_loc4_ < _loc3_.itemAmountList.length ? _loc3_.itemAmountList[_loc4_] : 0);
                  _loc7_ = ItemManager.getItemData(_loc5_.id);
                  if(_loc7_)
                  {
                     inventory.addItem(_loc7_.id,_loc6_);
                  }
                  else
                  {
                     LogUtils.log("Itemdata is null for ItemID: " + _loc5_.id + " for MegaPackID " + _loc3_.id,this,3,"ItemData");
                  }
                  _loc4_++;
               }
            }
            else
            {
               LogUtils.log("MegaPackItem list is empty for ID: " + _loc3_.id,this,3,"ItemData");
            }
         }
         else
         {
            inventory.addItem(_loc10_,_loc12_);
            if(_loc13_.autoEquip)
            {
               _loc8_ = {};
               _loc8_.item_id = _loc9_.item.item_id;
               this.itemEquipped(new Message("yo",_loc8_));
            }
         }
         if(Config.debugMode)
         {
            if(_loc12_ <= 0)
            {
               LogUtils.log("Server says we bought " + _loc12_ + " of item: " + _loc13_.toString(),this,3,"Items",false,true);
            }
            else if(_loc14_.isPremium && Boolean(isNaN(_loc9_.item.reduced_cash)))
            {
               LogUtils.log("Disagree on currency type (premium: <client:" + _loc14_.isPremium + " ,server:" + (_loc9_.item.reduced_cash <= 0) + ">) for Item: " + _loc13_.toString(),this,3,"Items",true,true);
            }
            else if(!_loc14_.isPremium && Boolean(isNaN(_loc9_.item.reduced_coins)))
            {
               LogUtils.log("Disagree on currency type (inGame: <client:" + !_loc14_.isPremium + " ,server:" + (_loc9_.item.reduced_coins <= 0) + ">) for Item: " + _loc13_.toString(),this,3,"Items",true,true);
            }
            else if(Math.max(!!isNaN(_loc9_.item.reduced_cash) ? 0 : Number(_loc9_.item.reduced_cash),!!isNaN(_loc9_.item.reduced_coins) ? 0 : Number(_loc9_.item.reduced_coins)) != _loc15_)
            {
               LogUtils.log("Disagree on price (<client:" + _loc15_ + " ,server:" + Math.max(!!isNaN(_loc9_.item.reduced_cash) ? 0 : Number(_loc9_.item.reduced_cash),!!isNaN(_loc9_.item.reduced_coins) ? 0 : Number(_loc9_.item.reduced_coins)) + ">) for Item: " + _loc13_.toString() + " REBUILD SERVER OR UPDATE CONFIGS!",this,3,"Items",true,true);
            }
         }
         if(_loc14_.isPremium)
         {
            this.addPremiumMoney(-_loc15_);
         }
         else
         {
            this.addIngameMoney(-_loc15_);
         }
      }
      
      private function itemUnlocked(param1:Message) : void
      {
         var _loc2_:Object = param1.data;
         ItemManager.unlockItemWithId(_loc2_.item_id);
         var _loc3_:Item = ItemManager.createItem(_loc2_.item_id);
         this.addPremiumMoney(-_loc3_.priceInfo.unlockPricePremium);
         MessageCenter.sendEvent(new InventoryUpdatedMessage(this,_loc3_,"ItemUnlocked"));
      }
      
      private function itemEquipped(param1:Message) : void
      {
         var _loc2_:Object = param1.data;
         wornItemsContainer.wearItem(_loc2_.item_id);
         wornItemsContainer.wornItemsIncludedItemCheck();
      }
      
      private function itemUnequipped(param1:Message) : void
      {
         var _loc2_:Object = param1.data;
         var _loc3_:ClothingItem = inventory.getItem(_loc2_.item_id) as ClothingItem;
         wornItemsContainer.unwearItemInSlot(_loc3_.slot);
         wornItemsContainer.wornItemsIncludedItemCheck();
      }
      
      private function itemCrafted(param1:Message) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:Object = null;
         var _loc3_:Object = param1.data;
         if(_loc3_ && _loc3_.crafted_item && Boolean(_loc3_.crafted_item.amount) && Boolean(_loc3_.crafted_item.item_id) && Boolean(_loc3_.consumed_ingredients))
         {
            _loc2_ = _loc3_.consumed_ingredients;
            for each(_loc4_ in _loc2_)
            {
               if(_loc4_)
               {
                  for each(_loc5_ in _loc4_)
                  {
                     inventory.removeItem(_loc5_);
                  }
                  LogUtils.log("Crafting consume item ID: " + _loc4_.item_id,this,0,"Crafting",false,false,true);
               }
            }
            inventory.setItem(_loc3_.crafted_item.item_id,_loc3_.crafted_item.amount);
            LogUtils.log("Crafting Success item ID: " + _loc3_.crafted_item.item_id + " amount: " + _loc3_.crafted_item.amount,this,4,"Crafting",false,false,true);
         }
         else
         {
            LogUtils.log("Not a valid crafting message data!",this,3,"Crafting",false,false,true);
            LogUtils.log(_loc3_,null,2,"Crafting",false,false,true);
         }
      }
      
      private function removeFiredWeaponFromInventory(param1:PlayerFiredMessage) : void
      {
         var _loc2_:Weapon = null;
         var _loc3_:* = param1.player;
         if(_loc3_._id == id)
         {
            _loc2_ = param1.weapon;
            if(!BattleManager.isPracticeMode())
            {
               inventory.removeItemWithId(_loc2_.id);
               HistoryMessageFactory.sendUsedItemsMessage(id,_loc2_.id);
            }
         }
      }
      
      private function addListeners() : void
      {
         if(this._local)
         {
            MessageCenter.addListener("ItemBought",this.itemBought);
            MessageCenter.addListener("ItemBoughtLevelUpSales",this.itemBoughtLevelUpSales);
            MessageCenter.addListener("ItemBoughtCouponSales",this.itemBoughtCouponSales);
            MessageCenter.addListener("ItemUnlocked",this.itemUnlocked);
            MessageCenter.addListener("ItemEquipped",this.itemEquipped);
            MessageCenter.addListener("ItemUnEquipped",this.itemUnequipped);
            MessageCenter.addListener("ItemCrafted",this.itemCrafted);
         }
         MessageCenter.addListener("PlayerFired",this.removeFiredWeaponFromInventory);
      }
      
      private function removeListeners() : void
      {
         if(this._local)
         {
            MessageCenter.removeListener("ItemBought",this.itemBought);
            MessageCenter.removeListener("ItemBoughtLevelUpSales",this.itemBoughtLevelUpSales);
            MessageCenter.removeListener("ItemBoughtCouponSales",this.itemBoughtCouponSales);
            MessageCenter.removeListener("ItemUnlocked",this.itemUnlocked);
            MessageCenter.removeListener("ItemEquipped",this.itemEquipped);
            MessageCenter.removeListener("ItemUnEquipped",this.itemUnequipped);
            MessageCenter.removeListener("ItemCrafted",this.itemCrafted);
         }
         MessageCenter.removeListener("PlayerFired",this.removeFiredWeaponFromInventory);
      }
      
      private function getFlagFromId(param1:Object, param2:String) : Object
      {
         var _loc3_:* = undefined;
         if(param1 == null || param1.flag == null)
         {
            return null;
         }
         if(param1.flag is Array)
         {
            param1 = param1.flag;
         }
         for each(_loc3_ in param1)
         {
            if(_loc3_.key == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function createDailyRewards(param1:Object) : void
      {
         this._dailyReward1.push(param1.dailyRewards.rewards.reward_0.id);
         this._dailyReward1.push(param1.dailyRewards.rewards.reward_0.value);
         this._dailyRewards.push(this._dailyReward1);
         this._dailyReward2.push(param1.dailyRewards.rewards.reward_1.id);
         this._dailyReward2.push(param1.dailyRewards.rewards.reward_1.value);
         this._dailyRewards.push(this._dailyReward2);
         this._dailyReward3.push(param1.dailyRewards.rewards.reward_2.id);
         this._dailyReward3.push(param1.dailyRewards.rewards.reward_2.value);
         this._dailyRewards.push(this._dailyReward3);
         this._dailyReward4.push(param1.dailyRewards.rewards.reward_3.id);
         this._dailyReward4.push(param1.dailyRewards.rewards.reward_3.value);
         this._dailyRewards.push(this._dailyReward4);
         this._dailyReward5.push(param1.dailyRewards.rewards.reward_4.id);
         this._dailyReward5.push(param1.dailyRewards.rewards.reward_4.value);
         this._dailyRewards.push(this._dailyReward5);
      }
   }
}

