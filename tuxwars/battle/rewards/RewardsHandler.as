package tuxwars.battle.rewards
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.Random;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import org.as3commons.lang.StringUtils;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.LevelGameObject;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.AvatarGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.history.HistoryMessageFactory;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.data.RewardConfig;
   import tuxwars.items.Item;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.net.CRMService;
   import tuxwars.player.Player;
   
   public class RewardsHandler
   {
      
      private static const PREMIUM:String = "Cash";
      
      private static const IN_GAME:String = "Coin";
      
      private static const EXPERIENCE:String = "Exp";
      
      private static const ITEM:String = "Item";
      
      private static const COUPON:String = "Coupon";
       
      
      private const _itemsLooted:Vector.<LootItem> = new Vector.<LootItem>();
      
      private var expGained:int;
      
      private var inGameMoneyGained:int;
      
      private var premiumMoneyGained:int;
      
      private var playerGameObject:PlayerGameObject;
      
      private var player:Player;
      
      private var world:TuxWorld;
      
      private var craftableItems:Vector.<ItemData>;
      
      private var craftableTotalDropRatio:int;
      
      private var weaponItems:Vector.<ItemData>;
      
      private var weaponTotalDropRatio:int;
      
      private var clothingItems:Vector.<ItemData>;
      
      private var clothingTotalDropRatio:int;
      
      private var recipeItems:Vector.<ItemData>;
      
      private var recipeTotalDropRatio:int;
      
      private var couponItems:Vector.<ItemData>;
      
      private var couponTotalDropRatio:int;
      
      private var initialized:Boolean;
      
      private var hasGotCoupon:Boolean;
      
      public function RewardsHandler(player:PlayerGameObject)
      {
         super();
         playerGameObject = player;
         var _loc2_:* = player;
         world = (_loc2_.game as tuxwars.TuxWarsGame).tuxWorld;
         initialized = false;
         hasGotCoupon = false;
      }
      
      public function dispose() : void
      {
         _itemsLooted.slice(0,_itemsLooted.length);
         if(craftableItems)
         {
            craftableItems.slice(0,craftableItems.length);
         }
         if(weaponItems)
         {
            weaponItems.slice(0,weaponItems.length);
         }
         if(clothingItems)
         {
            clothingItems.slice(0,clothingItems.length);
         }
         if(recipeItems)
         {
            recipeItems.slice(0,recipeItems.length);
         }
         if(couponItems)
         {
            couponItems.slice(0,couponItems.length);
         }
         playerGameObject = null;
         world = null;
      }
      
      public function get itemsLooted() : Vector.<LootItem>
      {
         _itemsLooted.sort(function(item1:LootItem, item2:LootItem):int
         {
            return StringUtils.compareTo(item1.id,item2.id);
         });
         return _itemsLooted;
      }
      
      public function addLootItem(id:String, amount:int = 1) : void
      {
         var _loc3_:LootItem = findLootItem(id);
         if(_loc3_)
         {
            _loc3_.amount += amount;
         }
         else
         {
            _itemsLooted.push(new LootItem(id,amount));
         }
      }
      
      private function findLootItem(id:String) : LootItem
      {
         for each(var item in _itemsLooted)
         {
            if(item.id == id)
            {
               return item;
            }
         }
         return null;
      }
      
      public function getInGameMoneyGained() : int
      {
         return inGameMoneyGained;
      }
      
      public function addInGameMoneyGained(gain:int, targetObject:PhysicsGameObject) : void
      {
         var _loc4_:* = null;
         var _loc3_:Number = NaN;
         if(gain > 0)
         {
            var _loc5_:PlayerGameObject = playerGameObject;
            var _loc6_:* = targetObject;
            LogUtils.log("Player: " + _loc5_._id + " gained ingame money: " + gain + " from targetId:" + _loc6_._id,"RewardsHandler",1,"Player",false,false,false);
            var _loc7_:PlayerGameObject = playerGameObject;
            _loc4_ = !!_loc7_.stats ? _loc7_.stats.getStat("CoinsBonus") : null;
            if(_loc4_ != null && _loc4_.isPercentage())
            {
               _loc3_ = gain * _loc4_.calculateValue();
               LogUtils.log("Adding coinsBonus: " + _loc4_.getFormattedCalculatedValue() + " of: " + (gain - _loc3_) + " for a total: " + Math.floor(_loc3_),"RewardsHandler",1,"Player",false,false,false);
               gain = Math.floor(_loc3_);
            }
            inGameMoneyGained += gain;
            generateGraphicsToPickUp(targetObject,"Coin",gain);
            HistoryMessageFactory.sendGainedCoinsMessage(playerGameObject);
         }
      }
      
      public function getPremiumMoneyGained() : int
      {
         return premiumMoneyGained;
      }
      
      public function getExperienceGained() : int
      {
         return expGained;
      }
      
      public function damageDoneToTarget(damage:int, targetObject:PhysicsGameObject) : void
      {
         if(damage <= 0 || targetObject == null || _loc3_._id == _loc4_._id)
         {
            return;
         }
         LogUtils.log("Calculating rewards for damage: " + damage + " target: " + targetObject,this,1,"RewardHandlerMisc",false,false,false);
         calculateExperience(damage,targetObject);
         calculateInGameMoney(damage,targetObject);
         if(!initialized)
         {
            initItemLists();
         }
         if(targetObject.isDeadHP())
         {
            if(!initialized)
            {
               initItemLists();
            }
            calculateCraftingDrop(damage,targetObject);
            if(targetObject is PlayerGameObject)
            {
               calculateCouponDrop(damage,targetObject);
               calculateWeaponDrop(damage,targetObject);
               calculateEquipmentDrop(damage,targetObject);
               calculateRecipeDrop(damage,targetObject);
            }
         }
      }
      
      private function initItemLists() : void
      {
         if(!initialized)
         {
            var _loc1_:PlayerGameObject = playerGameObject;
            this.player = BattleManager.findPlayer(_loc1_._id);
            LogUtils.log("Initializing Player:" + player.id + " level: " + player.level + " item drop lists",this,0,"Items",false,false,false);
            craftableItems = getFilteredItems(ItemManager.findItemDatas("Crafting"));
            craftableTotalDropRatio = calculateTotalDropRatio(craftableItems);
            weaponItems = getFilteredItems(ItemManager.findItemDatas("Weapon"));
            weaponTotalDropRatio = calculateTotalDropRatio(weaponItems);
            clothingItems = getFilteredItems(ItemManager.findItemDatas("Clothing"));
            clothingTotalDropRatio = calculateTotalDropRatio(clothingItems);
            recipeItems = getFilteredItems(ItemManager.findItemDatas("Recipe"));
            recipeTotalDropRatio = calculateTotalDropRatio(recipeItems);
            couponItems = getFilteredItems(ItemManager.findItemDatas("Coupon"));
            couponTotalDropRatio = calculateTotalDropRatio(couponItems);
            initialized = true;
         }
      }
      
      private function addPremiumMoneyGained(gain:int, targetObject:PhysicsGameObject) : void
      {
         if(gain > 0)
         {
            premiumMoneyGained += gain;
            generateGraphicsToPickUp(targetObject,"Cash",gain);
            var _loc3_:PlayerGameObject = playerGameObject;
            var _loc4_:* = targetObject;
            LogUtils.log("Player: " + _loc3_._id + " gained premium money: " + gain + " from tragetID: " + _loc4_._id,"RewardsHandler",1,"Player",false,false,false);
            HistoryMessageFactory.sendGainedCashMessage(playerGameObject);
         }
      }
      
      private function addExperienceGained(gain:int, targetObject:PhysicsGameObject) : void
      {
         var _loc3_:* = null;
         var _loc4_:Number = NaN;
         if(gain > 0)
         {
            var _loc5_:PlayerGameObject = playerGameObject;
            var _loc6_:* = targetObject;
            LogUtils.log("Player: " + _loc5_._id + " gained exp: " + gain + " from tragetID: " + _loc6_._id,"RewardsHandler",1,"Player",false,false,false);
            var _loc7_:PlayerGameObject = playerGameObject;
            _loc3_ = !!_loc7_.stats ? _loc7_.stats.getStat("ExpBonus") : null;
            if(_loc3_ != null && _loc3_.isPercentage())
            {
               _loc4_ = gain * _loc3_.calculateValue();
               LogUtils.log("Adding expBonus: " + _loc3_.getFormattedCalculatedValue() + " of: " + (_loc4_ - gain) + " for a total: " + Math.floor(_loc4_),"RewardsHandler",1,"Player",false,false,false);
               gain = Math.floor(_loc4_);
            }
            expGained += gain;
            generateGraphicsToPickUp(targetObject,"Exp",gain);
            HistoryMessageFactory.sendGainedExpMessage(playerGameObject);
         }
      }
      
      public function addLootItemFor(targetObject:PhysicsGameObject, id:String, amount:int = 1) : void
      {
         var item:* = null;
         if(id)
         {
            item = ItemManager.createItem(id);
            if(item)
            {
               addLootItem(id,amount);
               generateGraphicsToPickUp(targetObject,"Item",amount,item.icon);
               var _loc5_:PlayerGameObject = playerGameObject;
               var _loc6_:* = targetObject;
               LogUtils.log("Player: " + _loc5_._id + " gained loot item: " + id + " x " + amount + " from tragetID: " + _loc6_._id,"RewardsHandler",1,"Player",false,false,false);
               HistoryMessageFactory.sendEarnedItemsMessage(playerGameObject,id,amount);
            }
            else
            {
               var _loc7_:PlayerGameObject = playerGameObject;
               var _loc8_:* = targetObject;
               LogUtils.log("Player: " + _loc7_._id + " gained loot item: " + id + " x " + amount + " from tragetID: " + _loc8_._id + " ITEM DOES NOT EXIST!","RewardsHandler",3,"RewardHandlerMisc",true,true,false);
            }
         }
      }
      
      private function calculatePremiumMoney(damage:int, targetObject:PhysicsGameObject) : void
      {
         if(checkPremiumDropChance(targetObject))
         {
            addPremiumMoneyGained(RewardConfig.getPremiumCashAmount(),targetObject);
         }
      }
      
      private function checkPremiumDropChance(targetObject:PhysicsGameObject) : Boolean
      {
         if(premiumMoneyGained > 0)
         {
            LogUtils.log("Player already has gained cash in this match.",this,1,"RewardHandlerMisc",false,false,false);
            return false;
         }
         var chance:Number = RewardConfig.getPremiumDropChance();
         if(targetObject.isDeadHP())
         {
            chance += RewardConfig.getPremiumDropChanceAddOnKill();
         }
         var _loc6_:Number = RewardConfig.getPremiumDropChanceEarly();
         var _loc5_:Number = RewardConfig.getPremiumDropChanceDecrease();
         if(!player)
         {
            var _loc7_:PlayerGameObject = playerGameObject;
            player = BattleManager.findPlayer(_loc7_._id);
         }
         LogUtils.log("Premium cash chance: " + chance + " premium money: " + player.premiumMoney,this,1,"ItemDropChance",false,false,false);
         var _loc3_:Number = chance - chance * Math.pow(2.718281828459045,_loc6_ * Math.pow(2.718281828459045,_loc5_ * player.premiumMoney));
         var _loc2_:Number = Random.float(1,100);
         if(_loc3_ >= _loc2_)
         {
            var _loc8_:PlayerGameObject = playerGameObject;
            LogUtils.log("Premium cash reward Success because Chance: " + _loc3_ + " Random:" + _loc2_ + " for player:" + _loc8_._id,this,4,"ItemDropChance",false,false,false);
            return true;
         }
         var _loc9_:PlayerGameObject = playerGameObject;
         LogUtils.log("Premium cash reward Failure because Chance: " + _loc3_ + " Random:" + _loc2_ + " for player:" + _loc9_._id,this,0,"ItemDropChance",false,false,false);
         return false;
      }
      
      private function calculateExperience(damage:int, targetObject:PhysicsGameObject) : void
      {
         var _loc3_:int = gainModifierGoldExp(damage * RewardConfig.getDamageToExperience(),targetObject);
         addExperienceGained(_loc3_,targetObject);
      }
      
      private function calculateInGameMoney(damage:int, targetObject:PhysicsGameObject) : void
      {
         var _loc3_:int = gainModifierGoldExp(damage * RewardConfig.getDamageToGold(),targetObject);
         addInGameMoneyGained(_loc3_,targetObject);
      }
      
      private function gainModifierGoldExp(mutableGain:Number, targetObject:PhysicsGameObject) : int
      {
         if(!(targetObject is LevelGameObject) && targetObject.isDeadHP())
         {
            mutableGain += RewardConfig.getPenguineKillBonusGoldExp();
         }
         else if(targetObject is LevelGameObject)
         {
            mutableGain *= RewardConfig.getPropGoldExpModifier();
         }
         return mutableGain;
      }
      
      private function generateGraphicsToPickUp(targetObject:PhysicsGameObject, iconName:String, value:int, icon:MovieClip = null) : void
      {
         var _loc5_:* = null;
         if(BattleManager.getLocalPlayer() != null && playerGameObject != null && _loc6_._id == _loc7_._id)
         {
            var _loc8_:*;
            var _loc9_:*;
            _loc5_ = targetObject is AvatarGameObject ? new Point(AvatarGameObject(targetObject).container.x,AvatarGameObject(targetObject).container.y) : (_loc8_ = targetObject, _loc9_ = targetObject, new Point(_loc8_._displayObject.x,_loc9_._displayObject.y));
            switch(iconName)
            {
               case "Coin":
                  world.addFeedbackItem("drop_coins",_loc5_,value,RewardConfig.getAppearTime(),RewardConfig.getWaitTime(),RewardConfig.getFlyTime(),RewardConfig.getSWF("Coin"),RewardConfig.getExport("Coin"));
                  break;
               case "Cash":
                  world.addFeedbackItem("drop_cash",_loc5_,value,RewardConfig.getAppearTime(),RewardConfig.getWaitTime(),RewardConfig.getFlyTime(),RewardConfig.getSWF("Cash"),RewardConfig.getExport("Cash"));
                  break;
               case "Exp":
                  world.addFeedbackItem("drop_exp",_loc5_,value,RewardConfig.getAppearTime(),RewardConfig.getWaitTime(),RewardConfig.getFlyTime(),RewardConfig.getSWF("Exp"),RewardConfig.getExport("Exp"));
                  break;
               case "Coupon":
                  world.addFeedbackItem("drop_coupon",_loc5_,value,RewardConfig.getAppearTime(),RewardConfig.getWaitTime(),RewardConfig.getFlyTime(),null,null,icon);
                  break;
               case "Item":
                  if(icon != null)
                  {
                     world.addFeedbackItem("drop_generic_item",_loc5_,value,RewardConfig.getAppearTime(),RewardConfig.getWaitTime(),RewardConfig.getFlyTime(),null,null,icon);
                     break;
                  }
                  world.addFeedbackItem("drop_generic_item",_loc5_,value,RewardConfig.getAppearTime(),RewardConfig.getWaitTime(),RewardConfig.getFlyTime(),RewardConfig.getSWF("Item"),RewardConfig.getExport("Item"));
                  break;
            }
         }
      }
      
      private function calculateCraftingDrop(damage:int, targetObject:PhysicsGameObject) : void
      {
         var _loc4_:* = null;
         var follower:* = null;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:Number = targetObject is LevelGameObject ? RewardConfig.getCraftingPropDropChance() : RewardConfig.getCraftingDefaultDropChance();
         if(checkIfToGiveItemReward(_loc7_))
         {
            _loc4_ = getItemIdForDrop("Crafting",craftableItems,craftableTotalDropRatio);
            if(_loc4_ != null)
            {
               follower = playerGameObject.getFollower("Status_CraftDrop");
               if(follower)
               {
                  _loc6_ = Number(follower.variables[1]);
                  if(!isNaN(_loc6_) && _loc6_ > 0)
                  {
                     _loc5_ = Math.random() * 100;
                     if(_loc5_ <= _loc6_)
                     {
                        addLootItemFor(targetObject,_loc4_.id,follower.variables[2]);
                     }
                     else
                     {
                        addLootItemFor(targetObject,_loc4_.id);
                     }
                  }
               }
            }
         }
      }
      
      private function calculateWeaponDrop(damage:int, targetObject:PhysicsGameObject) : void
      {
         var lootItem:* = null;
         var _loc4_:Number = RewardConfig.getAmmunitionDefaultDropChance();
         if(checkIfToGiveItemReward(_loc4_))
         {
            lootItem = getItemIdForDrop("Weapon",weaponItems,weaponTotalDropRatio);
            if(lootItem != null)
            {
               addLootItemFor(targetObject,lootItem.id);
            }
         }
      }
      
      private function calculateRecipeDrop(damage:int, targetObject:PhysicsGameObject) : void
      {
         var lootItem:* = null;
         var _loc4_:Number = RewardConfig.getRecipeDropChance();
         if(checkIfToGiveItemReward(_loc4_))
         {
            lootItem = getItemIdForDrop("Recipe",recipeItems,recipeTotalDropRatio);
            if(lootItem != null)
            {
               addLootItemFor(targetObject,lootItem.id);
            }
         }
      }
      
      private function calculateCouponDrop(damage:int, targetObject:PhysicsGameObject) : void
      {
         var lootItem:* = null;
         if(hasGotCoupon)
         {
            return;
         }
         var _loc4_:Number = RewardConfig.getCouponDropChance();
         if(checkIfToGiveItemReward(_loc4_))
         {
            lootItem = getItemIdForDrop("Coupon",couponItems,couponTotalDropRatio);
            if(lootItem != null)
            {
               hasGotCoupon = true;
               addLootItemFor(targetObject,lootItem.id);
            }
         }
      }
      
      private function getItemIdForDrop(type:String, items:Vector.<ItemData>, totalDropRatio:int) : ItemData
      {
         if(items.length <= 0 && totalDropRatio > 0 || items.length > 0 && totalDropRatio <= 0)
         {
            var _loc6_:PlayerGameObject = playerGameObject;
            LogUtils.log("Inconsistent items vector of type: " + type + " and totalDropRatio for player:" + _loc6_._id,this,3,"RewardHandlerMisc",true,true,false);
            return null;
         }
         if(totalDropRatio <= 0)
         {
            var _loc7_:PlayerGameObject = playerGameObject;
            LogUtils.log("No droppable items of Type: " + type + " for player:" + _loc7_._id,this,0,"RewardHandlerMisc",true,false,false);
            return null;
         }
         var randomDropRatio:int = Random.integer(totalDropRatio);
         LogUtils.log("Starting search for item at randomDropRatio of: " + randomDropRatio + " in a totalDropRatio of: " + totalDropRatio,this,0,"RewardHandlerMisc",false,false,false);
         for each(var item in items)
         {
            if(randomDropRatio < item.dropRatio)
            {
               var _loc8_:PlayerGameObject = playerGameObject;
               LogUtils.log("Found item to drop: " + item.id + " of type: " + item.type + " for player:" + _loc8_._id,this,4,"RewardHandlerMisc",false,false,false);
               return item;
            }
            var _loc9_:PlayerGameObject = playerGameObject;
            LogUtils.log("randomDropRatio: " + randomDropRatio + "\t> itemDropRatio: " + item.dropRatio + "\tfor item: " + item.id + " of type: " + item.type + " for player:" + _loc9_._id,this,0,"RewardHandlerMisc",false,false,false);
            randomDropRatio -= item.dropRatio;
         }
         var _loc12_:PlayerGameObject = playerGameObject;
         LogUtils.log("NO Item FOUND to drop of type: " + item.type + " for player:" + _loc12_._id,this,3,"RewardHandlerMisc",true,true,false);
         return null;
      }
      
      private function calculateEquipmentDrop(damage:int, targetObject:PhysicsGameObject) : void
      {
         var _loc3_:* = undefined;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc6_:Number = RewardConfig.getEquipmentDefaultDropChance();
         if(checkIfToGiveItemReward(_loc6_))
         {
            _loc3_ = getWornItemsModifiedByTarget(clothingItems,targetObject);
            _loc5_ = calculateTotalDropRatio(_loc3_);
            _loc4_ = getItemIdForDrop("Clothing",_loc3_,_loc5_);
            if(_loc4_ != null)
            {
               addLootItemFor(targetObject,_loc4_.id);
            }
         }
      }
      
      private function checkIfToGiveItemReward(chanceModifier:Number) : Boolean
      {
         var _loc5_:PlayerGameObject = playerGameObject;
         var _loc3_:int = int((!!_loc5_.stats ? _loc5_.stats.getStat("Luck") : null).calculateRoundedValue());
         var _loc4_:Number = Math.log(_loc3_ + 2) * 0.4342944819032518 * chanceModifier + _loc3_ / 100;
         var _loc2_:Number = Random.float(0,100);
         if(_loc4_ >= _loc2_)
         {
            var _loc6_:PlayerGameObject = playerGameObject;
            LogUtils.log("Item Reward Success because Chance: " + _loc4_ + " Random:" + _loc2_ + " for player:" + _loc6_._id,this,4,"ItemDropChance",false,false,false);
            return true;
         }
         var _loc7_:PlayerGameObject = playerGameObject;
         LogUtils.log("Item Reward Failure because Chance: " + _loc4_ + " Random:" + _loc2_ + " for player:" + _loc7_._id,this,0,"ItemDropChance",false,false,false);
         return false;
      }
      
      private function getFilteredItems(allItems:Vector.<ItemData>) : Vector.<ItemData>
      {
         var _loc2_:Vector.<ItemData> = new Vector.<ItemData>();
         for each(var item in allItems)
         {
            if(item.dropRatio > 0 && item.requiredLevel <= player.level)
            {
               if(item.type != "Clothing" && item.type != "Recipe" || !player.inventory.containsItem(item.id))
               {
                  _loc2_.push(item);
               }
            }
         }
         return sortRewards(_loc2_);
      }
      
      private function sortRewards(items:Vector.<ItemData>) : Vector.<ItemData>
      {
         items.sort(sortById);
         items.sort(sortByDropRatio);
         LogUtils.log("Sorted reward Items!",this,0,"RewardHandlerMisc",false,false,false);
         for each(var item in items)
         {
            var _loc3_:PlayerGameObject = playerGameObject;
            LogUtils.log("Sorted by id: " + item.id + " then dropRate : " + item.dropRatio + " of type: " + item.type + " for player:" + _loc3_._id,this,0,"RewardHandlerMisc",false,false,false);
         }
         return items;
      }
      
      private function sortById(a:ItemData, b:ItemData) : int
      {
         return StringUtils.compareTo(a.id,b.id);
      }
      
      private function sortByDropRatio(a:ItemData, b:ItemData) : int
      {
         return b.dropRatio - a.dropRatio;
      }
      
      private function calculateTotalDropRatio(filteredItems:Vector.<ItemData>) : int
      {
         var dropRatioTotal:int = 0;
         for each(var item in filteredItems)
         {
            var _loc4_:PlayerGameObject = playerGameObject;
            LogUtils.log("DropRatio: " + item.dropRatio + " for item: " + item.id + " of type: " + item.type + " for player:" + _loc4_._id,this,0,"RewardHandlerMisc",false,false,false);
            dropRatioTotal += item.dropRatio;
         }
         if(item)
         {
            var _loc7_:PlayerGameObject = playerGameObject;
            LogUtils.log("DropRatioTotal: " + dropRatioTotal + " for type: " + item.type + " for player:" + _loc7_._id,this,0,"RewardHandlerMisc",false,false,false);
         }
         else
         {
            var _loc8_:PlayerGameObject = playerGameObject;
            LogUtils.log("DropRatioTotal: " + dropRatioTotal + " for player:" + _loc8_._id,this,0,"RewardHandlerMisc",false,false,false);
         }
         return dropRatioTotal;
      }
      
      private function getWornItemsModifiedByTarget(filteredItems:Vector.<ItemData>, target:PhysicsGameObject) : Vector.<ItemData>
      {
         var _loc5_:* = undefined;
         var _loc4_:* = null;
         if(target is PlayerGameObject)
         {
            LogUtils.log("Starting dropRatio modification for player: " + player.id,this,0,"RewardHandlerMisc",false,false,false);
            _loc5_ = new Vector.<ItemData>();
            _loc4_ = target as PlayerGameObject;
            for each(var item in filteredItems)
            {
               item.dropRatio == -1;
               if(_loc4_.wornItemsContainer.isWearingItem(item.id))
               {
                  item.dropRatio = (item.dropRatio + RewardConfig.getTargetWornItemDropRatioAdd()) * RewardConfig.getTargetWornItemDropRatioMultiply();
                  var _loc6_:PlayerGameObject = playerGameObject;
                  LogUtils.log("Modified DropRatio: " + item.dropRatio + "\tfor item: " + item.id + " of type: " + item.type + " for player:" + _loc6_._id,this,4,"RewardHandlerMisc",false,false,false);
               }
               else
               {
                  var _loc7_:PlayerGameObject = playerGameObject;
                  LogUtils.log("DropRatio: " + item.dropRatio + "\tfor item: " + item.id + " of type: " + item.type + " for player:" + _loc7_._id,this,0,"RewardHandlerMisc",false,false,false);
               }
               _loc5_.push(item);
            }
            return sortRewards(_loc5_);
         }
         return filteredItems;
      }
      
      public function syncRewardHandler() : void
      {
         var itemData:* = null;
         if(!player)
         {
            var _loc3_:PlayerGameObject = playerGameObject;
            this.player = BattleManager.findPlayer(_loc3_._id);
         }
         player.addIngameMoney(inGameMoneyGained);
         player.addPremiumMoney(premiumMoneyGained);
         CRMService.sendEvent("Economy","Earn GC","Started",null,null,inGameMoneyGained);
         CRMService.sendEvent("Economy","Earn PC","Started",null,null,premiumMoneyGained);
         if(itemsLooted)
         {
            for each(var item in itemsLooted)
            {
               if(item.id != null && item.id.length > 0)
               {
                  itemData = ItemManager.getItemData(item.id);
                  if(itemData && itemData.type != "Trophy")
                  {
                     player.inventory.addItem(item.id,item.amount);
                     CRMService.sendEvent("Economy","Earn_Item","Started",item.id);
                  }
               }
            }
         }
      }
   }
}
