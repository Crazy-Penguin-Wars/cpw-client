package tuxwars.player
{
   import com.dchoc.friends.Friends;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.gameobjects.stats.modifier.StatAdd;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.events.PlayerFiredMessage;
   import tuxwars.battle.net.messages.history.HistoryMessageFactory;
   import tuxwars.battle.weapons.Weapon;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.events.ChallengeGainedCoinsMessage;
   import tuxwars.challenges.events.ChallengeReachLevelMessage;
   import tuxwars.data.Experience;
   import tuxwars.data.SoundManager;
   import tuxwars.events.ExpChangedMessage;
   import tuxwars.events.IngameMoneyChangedMessage;
   import tuxwars.events.PremiumMoneyChangedMessage;
   import tuxwars.home.ui.screen.crafting.Research;
   import tuxwars.items.BoosterItem;
   import tuxwars.items.ClothingItem;
   import tuxwars.items.CustomizationItem;
   import tuxwars.items.Item;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.BetData;
   import tuxwars.items.data.CouponData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.data.MegaPackData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.items.references.PriceObject;
   import tuxwars.net.messages.InventoryUpdatedMessage;
   import tuxwars.net.messages.SetFlagMessage;
   import tuxwars.tournament.Tournament;
   import tuxwars.trophys.TrophyManager;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.popups.PopUpManager;
   
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
      
      private var _dailyRewards:Array;
      
      private var _dailyReward1:Array;
      
      private var _dailyReward2:Array;
      
      private var _dailyReward3:Array;
      
      private var _dailyReward4:Array;
      
      private var _dailyReward5:Array;
      
      private var _dailyRewardDay:int;
      
      private var _controlLevelUp:int;
      
      private var challengesData:Object;
      
      private var _betData:BetData;
      
      private var _tournamentAvailable:Boolean;
      
      private var _tournament:Tournament;
      
      private var _tournamentMatchLeagueId:String;
      
      private var _tournamentMatch:Boolean;
      
      public var _expiredVipMembershipPopup:Boolean = false;
      
      public function Player(local:Boolean)
      {
         _dailyRewards = [];
         _dailyReward1 = [];
         _dailyReward2 = [];
         _dailyReward3 = [];
         _dailyReward4 = [];
         _dailyReward5 = [];
         super();
         _local = local;
         _playerSpecificStats = new Stats();
         _playerSpecificStats.create("Exp",null);
         _tournamentMatchLeagueId = null;
         _tournamentMatch = false;
         _friends.addFriend(this);
      }
      
      override public function init(data:Object) : void
      {
         var days:int = 0;
         var flag:* = null;
         assert("Loading player data.",true,data != null);
         super.init(data);
         name = data.name != null ? data.name : ProjectManager.getText("DEFAULT_FRIEND_NAME");
         picUrl = data.pic_url;
         level = data.level;
         status = "Player";
         if(data.dcg_id != null)
         {
            id = data.dcg_id.toString();
         }
         else if(data.id != null)
         {
            id = data.id.toString();
         }
         else
         {
            LogUtils.log("Did not find a USER ID in data!",this,3,"Warning",false,false,true);
         }
         LogUtils.addDebugLine("Player","Loading Player " + name + " id: " + id,"Player");
         _ingameMoney = data.coins;
         _premiumMoney = data.cash;
         _slotMachineSpinsUsed = data.slot_machine_used_spins;
         LogUtils.addDebugLine("Player","Ingame money: " + _ingameMoney + " premium: " + _premiumMoney,"Player");
         var _loc4_:int = int(data.score != null ? data.score : Experience.getScore(data.level));
         loadStat("Exp",_loc4_);
         _controlLevelUp = level;
         LogUtils.addDebugLine("Player","Exp: " + expValue + " level: " + level,"Player");
         loadFriends(data.neighbors,data.user_data);
         if(data.vip_active_until)
         {
            vipMembership.vip = true;
            vipMembership.timeLeft = data.vip_active_until;
            if(data.vip_price_id)
            {
               vipMembership.boughtPackId = data.vip_price_id;
            }
            else
            {
               days = Number(data.vip_active_until) / 86400;
               if(days > 7)
               {
                  vipMembership.boughtPackId = "Price3";
               }
               else if(days > 1)
               {
                  vipMembership.boughtPackId = "Price2";
               }
               else
               {
                  vipMembership.boughtPackId = "Price1";
               }
            }
         }
         else
         {
            vipMembership.boughtPackId = data.vip_price_id;
            if(data.flags)
            {
               flag = getFlagFromId(data.flags,"ShowVIPExpired");
               if(flag && flag.value)
               {
                  _expiredVipMembershipPopup = true;
                  vipMembership.wasWip = true;
                  MessageCenter.sendEvent(new SetFlagMessage("ShowVIPExpired","false"));
               }
               else
               {
                  _expiredVipMembershipPopup = false;
               }
            }
         }
         loadItems(data.items);
         loadFreeEquipment();
         loadRecipes(data.known_recipes);
         unlockItems(data.unlocked_items);
         wearItems(data.worn_items);
         var _loc5_:Research = Research;
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         tuxwars.home.ui.screen.crafting.Research._instance.load(data.ongoing_research);
         var _loc6_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            challengesData = !!data.active_challenges ? data.active_challenges : data.challenges;
         }
         else if(data.active_challenges != null || data.challenges != null)
         {
            var _loc7_:ChallengeManager = ChallengeManager;
            if(!tuxwars.challenges.ChallengeManager._instance)
            {
               tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
            }
            tuxwars.challenges.ChallengeManager._instance.addPlayerChallenges(id,!!data.active_challenges ? data.active_challenges : data.challenges,_local);
            TrophyManager.addTrophies(this);
            MessageCenter.sendEvent(new ChallengeReachLevelMessage(level,id));
         }
         if(data.dailyRewards)
         {
            _dailyRewardDay = data.dailyRewards.currentDay;
            createDailyRewards(data);
         }
         if(data.flags)
         {
            SoundManager.loadSoundsStates(data.flags);
            var _loc8_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.loadFlags(data.flags);
         }
         if(data.available_features)
         {
            _tournamentAvailable = data.available_features.tournament;
         }
         addListeners();
      }
      
      override public function dispose() : void
      {
         _playerSpecificStats.dispose();
         _playerSpecificStats = null;
         removeListeners();
         super.dispose();
      }
      
      override public function isMe() : Boolean
      {
         return _local;
      }
      
      override public function toString() : String
      {
         return name + " (" + id + ")";
      }
      
      public function get vipMembership() : VIPMembership
      {
         return _vipMembership;
      }
      
      public function getNextBooster() : BoosterItem
      {
         var boosterItem:* = null;
         var _loc3_:Vector.<ShopItem> = ShopItemManager.getShopItems("Booster");
         for each(var item in _loc3_)
         {
            if(inventory.hasItem(item.id))
            {
               if(boosterItem)
               {
                  if(boosterItem.sortPriority > item.sortPriority)
                  {
                     boosterItem = inventory.getItem(item.id) as BoosterItem;
                  }
               }
               else
               {
                  boosterItem = inventory.getItem(item.id) as BoosterItem;
               }
            }
         }
         return boosterItem;
      }
      
      public function set ai(value:Boolean) : void
      {
         _ai = value;
      }
      
      public function get ai() : Boolean
      {
         return _ai;
      }
      
      public function get dummy() : Boolean
      {
         return _dummy;
      }
      
      public function set dummy(value:Boolean) : void
      {
         _dummy = value;
      }
      
      public function get expValue() : int
      {
         return _playerSpecificStats.getStat("Exp").calculateRoundedValue();
      }
      
      public function addExp(value:int) : void
      {
         var _loc2_:int = 0;
         if(value != 0)
         {
            _playerSpecificStats.getStat("Exp").addModifier(new StatAdd("ExperienceAdded",value));
            MessageCenter.sendEvent(new ExpChangedMessage(expValue,value));
            if(level > _controlLevelUp)
            {
               _loc2_ = level;
               LogUtils.log("Level Up from: " + _controlLevelUp + " to: " + _loc2_,this,4,"Player",false,false,false);
               MessageCenter.sendMessage("LevelUp",_loc2_);
               MessageCenter.sendEvent(new ChallengeReachLevelMessage(_loc2_,id));
               while(_controlLevelUp < _loc2_)
               {
                  _controlLevelUp += 1;
                  var _loc3_:PopUpManager = PopUpManager;
                  if(!tuxwars.ui.popups.PopUpManager._instance)
                  {
                     tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
                  }
                  tuxwars.ui.popups.PopUpManager._instance.triggerLevelUpPopup(_controlLevelUp,_controlLevelUp >= _loc2_);
               }
            }
         }
      }
      
      override public function get level() : int
      {
         return Experience.getLevel(expValue);
      }
      
      public function get ingameMoney() : int
      {
         return _ingameMoney;
      }
      
      public function set ingameMoney(value:int) : void
      {
         _ingameMoney = value;
      }
      
      public function get premiumMoney() : int
      {
         return _premiumMoney;
      }
      
      public function set premiumMoney(value:int) : void
      {
         _premiumMoney = value;
      }
      
      public function get slotMachineSpinsUsed() : int
      {
         return _slotMachineSpinsUsed;
      }
      
      public function set slotMachineSpinsUsed(value:int) : void
      {
         _slotMachineSpinsUsed = value;
         MessageCenter.sendMessage("SlotMachineFreeSpinsUsed");
      }
      
      public function addIngameMoney(value:int, sendChallengeUpdate:Boolean = true) : void
      {
         if(value != 0)
         {
            LogUtils.log("Adding ingame money: " + value + " to player: " + this,this,1,"Player",false,false,false);
            _ingameMoney += value;
            MessageCenter.sendEvent(new IngameMoneyChangedMessage(_ingameMoney,value));
            if(sendChallengeUpdate && value > 0)
            {
               MessageCenter.sendEvent(new ChallengeGainedCoinsMessage(value,id));
            }
         }
      }
      
      public function addPremiumMoney(value:int) : void
      {
         if(value != 0)
         {
            LogUtils.log("Adding premium money: " + value + " to player: " + this,this,1,"Player",false,false,false);
            _premiumMoney += value;
            MessageCenter.sendEvent(new PremiumMoneyChangedMessage(_premiumMoney,value));
         }
      }
      
      public function get friends() : Friends
      {
         return _friends;
      }
      
      public function get dailyRewards() : Array
      {
         return _dailyRewards;
      }
      
      public function get dailyRewardDay() : int
      {
         return _dailyRewardDay;
      }
      
      public function get betData() : BetData
      {
         return _betData;
      }
      
      public function set betData(item:BetData) : void
      {
         _betData = item;
      }
      
      public function isTournamentAvailable() : Boolean
      {
         return _tournamentAvailable && _tournament && level >= _tournament.requiredLevel;
      }
      
      public function isTournamentFinished() : Boolean
      {
         if(isTournamentAvailable() && _tournament.league && _tournament.league.isLeagueFinished())
         {
            return true;
         }
         return false;
      }
      
      public function get tournament() : Tournament
      {
         return _tournament;
      }
      
      public function set tournament(t:Tournament) : void
      {
         _tournament = t;
      }
      
      public function setMatchLeagueInfo(tournamentMatch:Boolean, tournamentMatchLeagueId:String) : void
      {
         _tournamentMatch = tournamentMatch;
         _tournamentMatchLeagueId = tournamentMatchLeagueId;
      }
      
      public function getMatchLeagueInfo() : String
      {
         if(_tournamentMatch)
         {
            return _tournamentMatchLeagueId;
         }
         return null;
      }
      
      public function initChallenges() : void
      {
         if(challengesData)
         {
            var _loc1_:ChallengeManager = ChallengeManager;
            if(!tuxwars.challenges.ChallengeManager._instance)
            {
               tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
            }
            tuxwars.challenges.ChallengeManager._instance.addPlayerChallenges(id,challengesData,_local);
            challengesData = null;
            TrophyManager.addTrophies(this);
            MessageCenter.sendMessage("ChallengesUpdated");
         }
      }
      
      private function loadFriends(neighborData:Object, userData:Object) : void
      {
         var _loc5_:* = null;
         var _loc7_:* = null;
         var neighbors:* = null;
         var _loc10_:* = null;
         var _loc9_:* = null;
         var neighborFound:Boolean = false;
         if(userData)
         {
            _loc5_ = userData.user != null ? userData.user : userData;
            _loc7_ = _loc5_ is Array ? _loc5_ as Array : [_loc5_];
            neighbors = [];
            if(neighborData)
            {
               _loc10_ = neighborData.dcg_id != null ? neighborData.dcg_id : neighborData;
               neighbors = _loc10_ is Array ? _loc10_ as Array : [_loc10_];
            }
            for each(var user in _loc7_)
            {
               if(user)
               {
                  _loc9_ = new TuxFriend();
                  _loc9_.init(user);
                  neighborFound = false;
                  for each(var neighborId in neighbors)
                  {
                     if(neighborId)
                     {
                        if(user.dcg_id == neighborId)
                        {
                           neighborFound = true;
                           break;
                        }
                     }
                  }
                  _loc9_.status = neighborFound ? "Neighbor" : "NoNeighbor";
                  _friends.addFriend(_loc9_);
               }
            }
         }
      }
      
      private function loadStat(statName:String, inputValue:Number) : void
      {
         if(!isNaN(inputValue))
         {
            _playerSpecificStats.getStat(statName).getBaseModifier().value = inputValue;
         }
      }
      
      private function loadItems(data:Object) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(data)
         {
            _loc4_ = data.item != null ? data.item : data;
            _loc3_ = _loc4_ is Array ? _loc4_ as Array : [_loc4_];
            for each(var itemData in _loc3_)
            {
               if(itemData)
               {
                  LogUtils.addDebugLine("Player","Adding item: " + itemData.item_id + " amount: " + itemData.amount,"Player");
                  inventory.setItem(itemData.item_id,itemData.amount);
               }
            }
         }
      }
      
      private function loadFreeEquipment() : void
      {
         var _loc1_:Vector.<ShopItem> = ShopItemManager.getShopItems("Clothing");
         for each(var item in _loc1_)
         {
            if(item.isFree() && !inventory.getItem(item.id))
            {
               inventory.addItem(item.id);
            }
         }
         var _loc4_:Vector.<ShopItem> = ShopItemManager.getShopItems("Customization");
         for each(item in _loc4_)
         {
            if(item.isFree() && !inventory.getItem(item.id))
            {
               inventory.addItem(item.id);
            }
         }
         var _loc3_:Vector.<ShopItem> = ShopItemManager.getShopItems("Booster");
         for each(item in _loc3_)
         {
            if(item.isFree() && !inventory.getItem(item.id))
            {
               inventory.addItem(item.id);
            }
         }
      }
      
      private function loadRecipes(data:Object) : void
      {
         var _loc2_:* = null;
         if(data)
         {
            _loc2_ = data is Array ? data as Array : [data];
            for each(var recipeData in _loc2_)
            {
               if(recipeData && !inventory.getItem(recipeData.recipe_id))
               {
                  LogUtils.addDebugLine("Player","Adding recipe item: " + recipeData.item_id,"Player");
                  inventory.addItem(recipeData.recipe_id);
               }
            }
         }
      }
      
      private function unlockItems(data:Object) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(data)
         {
            _loc4_ = data.unlocked_item != null ? data.unlocked_item : data;
            _loc3_ = _loc4_ is Array ? _loc4_ as Array : [_loc4_];
            for each(var itemData in _loc3_)
            {
               if(itemData != null)
               {
                  LogUtils.addDebugLine("Player","Unlocking item: " + itemData.item_id,"Player");
                  ItemManager.unlockItemWithId(itemData.item_id);
               }
            }
         }
      }
      
      private function wearItems(data:Object) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         wearDefaultValues();
         if(data)
         {
            _loc4_ = data.worn_item != null ? data.worn_item : data;
            _loc3_ = _loc4_ is Array ? _loc4_ as Array : [_loc4_];
            for each(var itemData in _loc3_)
            {
               if(itemData != null)
               {
                  wearItem(itemData is String ? itemData as String : itemData.item_id);
               }
            }
         }
         wornItemsContainer.wornItemsIncludedItemCheck();
      }
      
      private function wearDefaultValues() : void
      {
         var _loc1_:Vector.<Item> = inventory.findItems("Customization");
         for each(var i in _loc1_)
         {
            if(CustomizationItem(i).isDefaultValue())
            {
               wearItem(i.id);
            }
         }
      }
      
      private function wearItem(id:String) : void
      {
         LogUtils.addDebugLine("Player","Wearing item: " + id,"Player");
         wornItemsContainer.wearItem(id);
      }
      
      private function itemBoughtLevelUpSales(msg:Message) : void
      {
         if(msg && msg.data && msg.data.item)
         {
            if(msg.data.item.reduced_cash > 0)
            {
               itemBought(msg,msg.data.item.reduced_cash);
            }
            else
            {
               itemBought(msg,msg.data.item.reduced_coins);
            }
         }
         else
         {
            LogUtils.log("Incorrect message data",this,2,"Warning");
         }
      }
      
      private function itemBoughtCouponSales(msg:Message) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var coupon:CouponData = ItemManager.getItemData(msg.data.item.coupon_id) as CouponData;
         if(coupon)
         {
            _loc3_ = ShopItemManager.getShopItemWithId(msg.data.item.item_id);
            _loc2_ = _loc3_.priceObject;
            itemBought(msg,_loc2_.isPremium ? coupon.couponPremiumPrice : coupon.couponInGamePrice);
         }
      }
      
      private function itemBought(msg:Message, forcePrice:int = -1) : void
      {
         var _loc14_:* = null;
         var i:int = 0;
         var _loc13_:* = null;
         var _loc4_:int = 0;
         var _loc12_:* = null;
         var _loc6_:* = null;
         var _loc5_:Object = msg.data;
         var _loc10_:String = _loc5_.item.item_id;
         var _loc16_:int = int(_loc5_.item.total_amount);
         var _loc8_:int = int(_loc5_.item.bought_amount);
         var _loc7_:ShopItem = ShopItemManager.getShopItemWithId(_loc10_);
         var _loc11_:PriceObject = _loc7_.priceObject;
         var _loc3_:int = forcePrice != -1 ? forcePrice : _loc11_.priceValue;
         var _loc15_:ItemData = ItemManager.getItemData(_loc5_.item.item_id);
         if(_loc15_ && _loc15_.type == "MegaPack")
         {
            _loc14_ = _loc15_ as MegaPackData;
            if(_loc14_.itemList)
            {
               while(i < _loc14_.itemList.length)
               {
                  _loc13_ = _loc14_.itemList[i];
                  _loc4_ = int(i < _loc14_.itemAmountList.length ? _loc14_.itemAmountList[i] : 0);
                  _loc12_ = ItemManager.getItemData(_loc13_.id);
                  if(_loc12_)
                  {
                     inventory.addItem(_loc12_.id,_loc4_);
                  }
                  else
                  {
                     LogUtils.log("Itemdata is null for ItemID: " + _loc13_.id + " for MegaPackID " + _loc14_.id,this,3,"ItemData");
                  }
                  i++;
               }
            }
            else
            {
               LogUtils.log("MegaPackItem list is empty for ID: " + _loc14_.id,this,3,"ItemData");
            }
         }
         else
         {
            inventory.addItem(_loc10_,_loc8_);
            if(_loc7_.autoEquip)
            {
               _loc6_ = {};
               _loc6_.item_id = _loc5_.item.item_id;
               itemEquipped(new Message("yo",_loc6_));
            }
         }
         if(Config.debugMode)
         {
            if(_loc8_ <= 0)
            {
               LogUtils.log("Server says we bought " + _loc8_ + " of item: " + _loc7_.toString(),this,3,"Items",false,true);
            }
            else if(_loc11_.isPremium && isNaN(_loc5_.item.reduced_cash))
            {
               LogUtils.log("Disagree on currency type (premium: <client:" + _loc11_.isPremium + " ,server:" + (_loc5_.item.reduced_cash <= 0) + ">) for Item: " + _loc7_.toString(),this,3,"Items",true,true);
            }
            else if(!_loc11_.isPremium && isNaN(_loc5_.item.reduced_coins))
            {
               LogUtils.log("Disagree on currency type (inGame: <client:" + !_loc11_.isPremium + " ,server:" + (_loc5_.item.reduced_coins <= 0) + ">) for Item: " + _loc7_.toString(),this,3,"Items",true,true);
            }
            else if(Math.max(isNaN(_loc5_.item.reduced_cash) ? 0 : _loc5_.item.reduced_cash,isNaN(_loc5_.item.reduced_coins) ? 0 : _loc5_.item.reduced_coins) != _loc3_)
            {
               LogUtils.log("Disagree on price (<client:" + _loc3_ + " ,server:" + Math.max(isNaN(_loc5_.item.reduced_cash) ? 0 : _loc5_.item.reduced_cash,isNaN(_loc5_.item.reduced_coins) ? 0 : _loc5_.item.reduced_coins) + ">) for Item: " + _loc7_.toString() + " REBUILD SERVER OR UPDATE CONFIGS!",this,3,"Items",true,true);
            }
         }
         if(_loc11_.isPremium)
         {
            addPremiumMoney(-_loc3_);
         }
         else
         {
            addIngameMoney(-_loc3_);
         }
      }
      
      private function itemUnlocked(msg:Message) : void
      {
         var _loc3_:Object = msg.data;
         ItemManager.unlockItemWithId(_loc3_.item_id);
         var _loc2_:Item = ItemManager.createItem(_loc3_.item_id);
         addPremiumMoney(-_loc2_.priceInfo.unlockPricePremium);
         MessageCenter.sendEvent(new InventoryUpdatedMessage(this,_loc2_,"ItemUnlocked"));
      }
      
      private function itemEquipped(msg:Message) : void
      {
         var _loc2_:Object = msg.data;
         wornItemsContainer.wearItem(_loc2_.item_id);
         wornItemsContainer.wornItemsIncludedItemCheck();
      }
      
      private function itemUnequipped(msg:Message) : void
      {
         var _loc3_:Object = msg.data;
         var _loc2_:ClothingItem = inventory.getItem(_loc3_.item_id) as ClothingItem;
         wornItemsContainer.unwearItemInSlot(_loc2_.slot);
         wornItemsContainer.wornItemsIncludedItemCheck();
      }
      
      private function itemCrafted(msg:Message) : void
      {
         var _loc4_:* = null;
         var _loc5_:Object = msg.data;
         if(_loc5_ && _loc5_.crafted_item && _loc5_.crafted_item.amount && _loc5_.crafted_item.item_id && _loc5_.consumed_ingredients)
         {
            _loc4_ = _loc5_.consumed_ingredients;
            for each(var itemData in _loc4_)
            {
               if(itemData)
               {
                  for each(var s in itemData)
                  {
                     inventory.removeItem(s);
                  }
                  LogUtils.log("Crafting consume item ID: " + itemData.item_id,this,0,"Crafting",false,false,true);
               }
            }
            inventory.setItem(_loc5_.crafted_item.item_id,_loc5_.crafted_item.amount);
            LogUtils.log("Crafting Success item ID: " + _loc5_.crafted_item.item_id + " amount: " + _loc5_.crafted_item.amount,this,4,"Crafting",false,false,true);
         }
         else
         {
            LogUtils.log("Not a valid crafting message data!",this,3,"Crafting",false,false,true);
            LogUtils.log(_loc5_,null,2,"Crafting",false,false,true);
         }
      }
      
      private function removeFiredWeaponFromInventory(msg:PlayerFiredMessage) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = msg.player;
         if(_loc3_._id == id)
         {
            _loc2_ = msg.weapon;
            if(!BattleManager.isPracticeMode())
            {
               inventory.removeItemWithId(_loc2_.id);
               HistoryMessageFactory.sendUsedItemsMessage(id,_loc2_.id);
            }
         }
      }
      
      private function addListeners() : void
      {
         if(_local)
         {
            MessageCenter.addListener("ItemBought",itemBought);
            MessageCenter.addListener("ItemBoughtLevelUpSales",itemBoughtLevelUpSales);
            MessageCenter.addListener("ItemBoughtCouponSales",itemBoughtCouponSales);
            MessageCenter.addListener("ItemUnlocked",itemUnlocked);
            MessageCenter.addListener("ItemEquipped",itemEquipped);
            MessageCenter.addListener("ItemUnEquipped",itemUnequipped);
            MessageCenter.addListener("ItemCrafted",itemCrafted);
         }
         MessageCenter.addListener("PlayerFired",removeFiredWeaponFromInventory);
      }
      
      private function removeListeners() : void
      {
         if(_local)
         {
            MessageCenter.removeListener("ItemBought",itemBought);
            MessageCenter.removeListener("ItemBoughtLevelUpSales",itemBoughtLevelUpSales);
            MessageCenter.removeListener("ItemBoughtCouponSales",itemBoughtCouponSales);
            MessageCenter.removeListener("ItemUnlocked",itemUnlocked);
            MessageCenter.removeListener("ItemEquipped",itemEquipped);
            MessageCenter.removeListener("ItemUnEquipped",itemUnequipped);
            MessageCenter.removeListener("ItemCrafted",itemCrafted);
         }
         MessageCenter.removeListener("PlayerFired",removeFiredWeaponFromInventory);
      }
      
      private function getFlagFromId(flags:Object, id:String) : Object
      {
         if(flags == null || flags.flag == null)
         {
            return null;
         }
         if(flags.flag is Array)
         {
            flags = flags.flag;
         }
         for each(var object in flags)
         {
            if(object.key == id)
            {
               return object;
            }
         }
         return null;
      }
      
      private function createDailyRewards(data:Object) : void
      {
         _dailyReward1.push(data.dailyRewards.rewards.reward_0.id);
         _dailyReward1.push(data.dailyRewards.rewards.reward_0.value);
         _dailyRewards.push(_dailyReward1);
         _dailyReward2.push(data.dailyRewards.rewards.reward_1.id);
         _dailyReward2.push(data.dailyRewards.rewards.reward_1.value);
         _dailyRewards.push(_dailyReward2);
         _dailyReward3.push(data.dailyRewards.rewards.reward_2.id);
         _dailyReward3.push(data.dailyRewards.rewards.reward_2.value);
         _dailyRewards.push(_dailyReward3);
         _dailyReward4.push(data.dailyRewards.rewards.reward_3.id);
         _dailyReward4.push(data.dailyRewards.rewards.reward_3.value);
         _dailyRewards.push(_dailyReward4);
         _dailyReward5.push(data.dailyRewards.rewards.reward_4.id);
         _dailyReward5.push(data.dailyRewards.rewards.reward_4.value);
         _dailyRewards.push(_dailyReward5);
      }
   }
}
