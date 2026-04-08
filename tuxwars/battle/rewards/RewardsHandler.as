package tuxwars.battle.rewards
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.geom.*;
   import org.as3commons.lang.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.net.messages.history.*;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.data.*;
   import tuxwars.items.Item;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   import tuxwars.net.*;
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
      
      public function RewardsHandler(param1:PlayerGameObject)
      {
         super();
         this.playerGameObject = param1;
         var _loc2_:* = param1;
         this.world = (_loc2_.game as TuxWarsGame).tuxWorld;
         this.initialized = false;
         this.hasGotCoupon = false;
      }
      
      public function dispose() : void
      {
         this._itemsLooted.slice(0,this._itemsLooted.length);
         if(this.craftableItems)
         {
            this.craftableItems.slice(0,this.craftableItems.length);
         }
         if(this.weaponItems)
         {
            this.weaponItems.slice(0,this.weaponItems.length);
         }
         if(this.clothingItems)
         {
            this.clothingItems.slice(0,this.clothingItems.length);
         }
         if(this.recipeItems)
         {
            this.recipeItems.slice(0,this.recipeItems.length);
         }
         if(this.couponItems)
         {
            this.couponItems.slice(0,this.couponItems.length);
         }
         this.playerGameObject = null;
         this.world = null;
      }
      
      public function get itemsLooted() : Vector.<LootItem>
      {
         this._itemsLooted.sort(function(param1:LootItem, param2:LootItem):int
         {
            return StringUtils.compareTo(param1.id,param2.id);
         });
         return this._itemsLooted;
      }
      
      public function addLootItem(param1:String, param2:int = 1) : void
      {
         var _loc3_:LootItem = this.findLootItem(param1);
         if(_loc3_)
         {
            _loc3_.amount += param2;
         }
         else
         {
            this._itemsLooted.push(new LootItem(param1,param2));
         }
      }
      
      private function findLootItem(param1:String) : LootItem
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._itemsLooted)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getInGameMoneyGained() : int
      {
         return this.inGameMoneyGained;
      }
      
      public function addInGameMoneyGained(param1:int, param2:PhysicsGameObject) : void
      {
         var _loc5_:PlayerGameObject = null;
         var _loc6_:* = undefined;
         var _loc7_:String = null;
         var _loc8_:PlayerGameObject = null;
         var _loc3_:Stat = null;
         var _loc4_:Number = Number(NaN);
         if(param1 > 0)
         {
            _loc5_ = this.playerGameObject;
            _loc6_ = param2;
            LogUtils.log("Player: " + _loc5_._id + " gained ingame money: " + param1 + " from targetId:" + _loc6_._id,"RewardsHandler",1,"Player",false,false,false);
            _loc7_ = "CoinsBonus";
            _loc8_ = this.playerGameObject;
            _loc3_ = !!_loc8_.stats ? _loc8_.stats.getStat(_loc7_) : null;
            if(_loc3_ != null && _loc3_.isPercentage())
            {
               _loc4_ = param1 * _loc3_.calculateValue();
               LogUtils.log("Adding coinsBonus: " + _loc3_.getFormattedCalculatedValue() + " of: " + (param1 - _loc4_) + " for a total: " + Math.floor(_loc4_),"RewardsHandler",1,"Player",false,false,false);
               param1 = Math.floor(_loc4_);
            }
            this.inGameMoneyGained += param1;
            this.generateGraphicsToPickUp(param2,"Coin",param1);
            HistoryMessageFactory.sendGainedCoinsMessage(this.playerGameObject);
         }
      }
      
      public function getPremiumMoneyGained() : int
      {
         return this.premiumMoneyGained;
      }
      
      public function getExperienceGained() : int
      {
         return this.expGained;
      }
      
      public function damageDoneToTarget(param1:int, param2:PhysicsGameObject) : void
      {
         if(param1 <= 0 || param2 == null || _loc3_._id == _loc4_._id)
         {
            return;
         }
         LogUtils.log("Calculating rewards for damage: " + param1 + " target: " + param2,this,1,"RewardHandlerMisc",false,false,false);
         this.calculateExperience(param1,param2);
         this.calculateInGameMoney(param1,param2);
         if(!this.initialized)
         {
            this.initItemLists();
         }
         if(param2.isDeadHP())
         {
            if(!this.initialized)
            {
               this.initItemLists();
            }
            this.calculateCraftingDrop(param1,param2);
            if(param2 is PlayerGameObject)
            {
               this.calculateCouponDrop(param1,param2);
               this.calculateWeaponDrop(param1,param2);
               this.calculateEquipmentDrop(param1,param2);
               this.calculateRecipeDrop(param1,param2);
            }
         }
      }
      
      private function initItemLists() : void
      {
         var _loc1_:PlayerGameObject = null;
         if(!this.initialized)
         {
            _loc1_ = this.playerGameObject;
            this.player = BattleManager.findPlayer(_loc1_._id);
            LogUtils.log("Initializing Player:" + this.player.id + " level: " + this.player.level + " item drop lists",this,0,"Items",false,false,false);
            this.craftableItems = this.getFilteredItems(ItemManager.findItemDatas("Crafting"));
            this.craftableTotalDropRatio = this.calculateTotalDropRatio(this.craftableItems);
            this.weaponItems = this.getFilteredItems(ItemManager.findItemDatas("Weapon"));
            this.weaponTotalDropRatio = this.calculateTotalDropRatio(this.weaponItems);
            this.clothingItems = this.getFilteredItems(ItemManager.findItemDatas("Clothing"));
            this.clothingTotalDropRatio = this.calculateTotalDropRatio(this.clothingItems);
            this.recipeItems = this.getFilteredItems(ItemManager.findItemDatas("Recipe"));
            this.recipeTotalDropRatio = this.calculateTotalDropRatio(this.recipeItems);
            this.couponItems = this.getFilteredItems(ItemManager.findItemDatas("Coupon"));
            this.couponTotalDropRatio = this.calculateTotalDropRatio(this.couponItems);
            this.initialized = true;
         }
      }
      
      private function addPremiumMoneyGained(param1:int, param2:PhysicsGameObject) : void
      {
         var _loc3_:PlayerGameObject = null;
         var _loc4_:* = undefined;
         if(param1 > 0)
         {
            this.premiumMoneyGained += param1;
            this.generateGraphicsToPickUp(param2,"Cash",param1);
            _loc3_ = this.playerGameObject;
            _loc4_ = param2;
            LogUtils.log("Player: " + _loc3_._id + " gained premium money: " + param1 + " from tragetID: " + _loc4_._id,"RewardsHandler",1,"Player",false,false,false);
            HistoryMessageFactory.sendGainedCashMessage(this.playerGameObject);
         }
      }
      
      private function addExperienceGained(param1:int, param2:PhysicsGameObject) : void
      {
         var _loc5_:PlayerGameObject = null;
         var _loc6_:* = undefined;
         var _loc7_:String = null;
         var _loc8_:PlayerGameObject = null;
         var _loc3_:Stat = null;
         var _loc4_:Number = Number(NaN);
         if(param1 > 0)
         {
            _loc5_ = this.playerGameObject;
            _loc6_ = param2;
            LogUtils.log("Player: " + _loc5_._id + " gained exp: " + param1 + " from tragetID: " + _loc6_._id,"RewardsHandler",1,"Player",false,false,false);
            _loc7_ = "ExpBonus";
            _loc8_ = this.playerGameObject;
            _loc3_ = !!_loc8_.stats ? _loc8_.stats.getStat(_loc7_) : null;
            if(_loc3_ != null && _loc3_.isPercentage())
            {
               _loc4_ = param1 * _loc3_.calculateValue();
               LogUtils.log("Adding expBonus: " + _loc3_.getFormattedCalculatedValue() + " of: " + (_loc4_ - param1) + " for a total: " + Math.floor(_loc4_),"RewardsHandler",1,"Player",false,false,false);
               param1 = Math.floor(_loc4_);
            }
            this.expGained += param1;
            this.generateGraphicsToPickUp(param2,"Exp",param1);
            HistoryMessageFactory.sendGainedExpMessage(this.playerGameObject);
         }
      }
      
      public function addLootItemFor(param1:PhysicsGameObject, param2:String, param3:int = 1) : void
      {
         var _loc5_:PlayerGameObject = null;
         var _loc6_:* = undefined;
         var _loc7_:PlayerGameObject = null;
         var _loc8_:* = undefined;
         var _loc4_:Item = null;
         if(param2)
         {
            _loc4_ = ItemManager.createItem(param2);
            if(_loc4_)
            {
               this.addLootItem(param2,param3);
               this.generateGraphicsToPickUp(param1,"Item",param3,_loc4_.icon);
               _loc5_ = this.playerGameObject;
               _loc6_ = param1;
               LogUtils.log("Player: " + _loc5_._id + " gained loot item: " + param2 + " x " + param3 + " from tragetID: " + _loc6_._id,"RewardsHandler",1,"Player",false,false,false);
               HistoryMessageFactory.sendEarnedItemsMessage(this.playerGameObject,param2,param3);
            }
            else
            {
               _loc7_ = this.playerGameObject;
               _loc8_ = param1;
               LogUtils.log("Player: " + _loc7_._id + " gained loot item: " + param2 + " x " + param3 + " from tragetID: " + _loc8_._id + " ITEM DOES NOT EXIST!","RewardsHandler",3,"RewardHandlerMisc",true,true,false);
            }
         }
      }
      
      private function calculatePremiumMoney(param1:int, param2:PhysicsGameObject) : void
      {
         if(this.checkPremiumDropChance(param2))
         {
            this.addPremiumMoneyGained(RewardConfig.getPremiumCashAmount(),param2);
         }
      }
      
      private function checkPremiumDropChance(param1:PhysicsGameObject) : Boolean
      {
         var _loc8_:PlayerGameObject = null;
         var _loc9_:PlayerGameObject = null;
         if(this.premiumMoneyGained > 0)
         {
            LogUtils.log("Player already has gained cash in this match.",this,1,"RewardHandlerMisc",false,false,false);
            return false;
         }
         var _loc2_:Number = Number(RewardConfig.getPremiumDropChance());
         if(param1.isDeadHP())
         {
            _loc2_ += RewardConfig.getPremiumDropChanceAddOnKill();
         }
         var _loc3_:Number = Number(RewardConfig.getPremiumDropChanceEarly());
         var _loc4_:Number = Number(RewardConfig.getPremiumDropChanceDecrease());
         if(!this.player)
         {
            _loc8_ = this.playerGameObject;
            this.player = BattleManager.findPlayer(_loc8_._id);
         }
         LogUtils.log("Premium cash chance: " + _loc2_ + " premium money: " + this.player.premiumMoney,this,1,"ItemDropChance",false,false,false);
         var _loc5_:Number = _loc2_ - _loc2_ * Math.pow(2.718281828459045,_loc3_ * Math.pow(2.718281828459045,_loc4_ * this.player.premiumMoney));
         var _loc6_:Number = Number(Random.float(1,100));
         if(_loc5_ >= _loc6_)
         {
            _loc9_ = this.playerGameObject;
            LogUtils.log("Premium cash reward Success because Chance: " + _loc5_ + " Random:" + _loc6_ + " for player:" + _loc9_._id,this,4,"ItemDropChance",false,false,false);
            return true;
         }
         var _loc7_:PlayerGameObject = this.playerGameObject;
         LogUtils.log("Premium cash reward Failure because Chance: " + _loc5_ + " Random:" + _loc6_ + " for player:" + _loc7_._id,this,0,"ItemDropChance",false,false,false);
         return false;
      }
      
      private function calculateExperience(param1:int, param2:PhysicsGameObject) : void
      {
         var _loc3_:int = int(this.gainModifierGoldExp(param1 * RewardConfig.getDamageToExperience(),param2));
         this.addExperienceGained(_loc3_,param2);
      }
      
      private function calculateInGameMoney(param1:int, param2:PhysicsGameObject) : void
      {
         var _loc3_:int = int(this.gainModifierGoldExp(param1 * RewardConfig.getDamageToGold(),param2));
         this.addInGameMoneyGained(_loc3_,param2);
      }
      
      private function gainModifierGoldExp(param1:Number, param2:PhysicsGameObject) : int
      {
         if(!(param2 is LevelGameObject) && param2.isDeadHP())
         {
            param1 += RewardConfig.getPenguineKillBonusGoldExp();
         }
         else if(param2 is LevelGameObject)
         {
            param1 *= RewardConfig.getPropGoldExpModifier();
         }
         return param1;
      }
      
      private function generateGraphicsToPickUp(param1:PhysicsGameObject, param2:String, param3:int, param4:MovieClip = null) : void
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc5_:Point = null;
         if(BattleManager.getLocalPlayer() != null && this.playerGameObject != null && _loc6_._id == _loc7_._id)
         {
            _loc5_ = param1 is AvatarGameObject ? new Point(AvatarGameObject(param1).container.x,AvatarGameObject(param1).container.y) : (_loc6_ = param1, _loc7_ = param1, new Point(_loc6_._displayObject.x,_loc7_._displayObject.y));
            switch(param2)
            {
               case "Coin":
                  this.world.addFeedbackItem("drop_coins",_loc5_,param3,RewardConfig.getAppearTime(),RewardConfig.getWaitTime(),RewardConfig.getFlyTime(),RewardConfig.getSWF("Coin"),RewardConfig.getExport("Coin"));
                  break;
               case "Cash":
                  this.world.addFeedbackItem("drop_cash",_loc5_,param3,RewardConfig.getAppearTime(),RewardConfig.getWaitTime(),RewardConfig.getFlyTime(),RewardConfig.getSWF("Cash"),RewardConfig.getExport("Cash"));
                  break;
               case "Exp":
                  this.world.addFeedbackItem("drop_exp",_loc5_,param3,RewardConfig.getAppearTime(),RewardConfig.getWaitTime(),RewardConfig.getFlyTime(),RewardConfig.getSWF("Exp"),RewardConfig.getExport("Exp"));
                  break;
               case "Coupon":
                  this.world.addFeedbackItem("drop_coupon",_loc5_,param3,RewardConfig.getAppearTime(),RewardConfig.getWaitTime(),RewardConfig.getFlyTime(),null,null,param4);
                  break;
               case "Item":
                  if(param4 != null)
                  {
                     this.world.addFeedbackItem("drop_generic_item",_loc5_,param3,RewardConfig.getAppearTime(),RewardConfig.getWaitTime(),RewardConfig.getFlyTime(),null,null,param4);
                  }
                  else
                  {
                     this.world.addFeedbackItem("drop_generic_item",_loc5_,param3,RewardConfig.getAppearTime(),RewardConfig.getWaitTime(),RewardConfig.getFlyTime(),RewardConfig.getSWF("Item"),RewardConfig.getExport("Item"));
                  }
            }
         }
      }
      
      private function calculateCraftingDrop(param1:int, param2:PhysicsGameObject) : void
      {
         var _loc3_:ItemData = null;
         var _loc4_:Follower = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = param2 is LevelGameObject ? Number(RewardConfig.getCraftingPropDropChance()) : Number(RewardConfig.getCraftingDefaultDropChance());
         if(this.checkIfToGiveItemReward(_loc7_))
         {
            _loc3_ = this.getItemIdForDrop("Crafting",this.craftableItems,this.craftableTotalDropRatio);
            if(_loc3_ != null)
            {
               _loc4_ = this.playerGameObject.getFollower("Status_CraftDrop");
               if(_loc4_)
               {
                  _loc5_ = Number(_loc4_.variables[1]);
                  if(!isNaN(_loc5_) && _loc5_ > 0)
                  {
                     _loc6_ = Math.random() * 100;
                     if(_loc6_ <= _loc5_)
                     {
                        this.addLootItemFor(param2,_loc3_.id,_loc4_.variables[2]);
                     }
                     else
                     {
                        this.addLootItemFor(param2,_loc3_.id);
                     }
                  }
               }
            }
         }
      }
      
      private function calculateWeaponDrop(param1:int, param2:PhysicsGameObject) : void
      {
         var _loc3_:ItemData = null;
         var _loc4_:Number = Number(RewardConfig.getAmmunitionDefaultDropChance());
         if(this.checkIfToGiveItemReward(_loc4_))
         {
            _loc3_ = this.getItemIdForDrop("Weapon",this.weaponItems,this.weaponTotalDropRatio);
            if(_loc3_ != null)
            {
               this.addLootItemFor(param2,_loc3_.id);
            }
         }
      }
      
      private function calculateRecipeDrop(param1:int, param2:PhysicsGameObject) : void
      {
         var _loc3_:ItemData = null;
         var _loc4_:Number = Number(RewardConfig.getRecipeDropChance());
         if(this.checkIfToGiveItemReward(_loc4_))
         {
            _loc3_ = this.getItemIdForDrop("Recipe",this.recipeItems,this.recipeTotalDropRatio);
            if(_loc3_ != null)
            {
               this.addLootItemFor(param2,_loc3_.id);
            }
         }
      }
      
      private function calculateCouponDrop(param1:int, param2:PhysicsGameObject) : void
      {
         var _loc3_:ItemData = null;
         if(this.hasGotCoupon)
         {
            return;
         }
         var _loc4_:Number = Number(RewardConfig.getCouponDropChance());
         if(this.checkIfToGiveItemReward(_loc4_))
         {
            _loc3_ = this.getItemIdForDrop("Coupon",this.couponItems,this.couponTotalDropRatio);
            if(_loc3_ != null)
            {
               this.hasGotCoupon = true;
               this.addLootItemFor(param2,_loc3_.id);
            }
         }
      }
      
      private function getItemIdForDrop(param1:String, param2:Vector.<ItemData>, param3:int) : ItemData
      {
         var _loc5_:* = undefined;
         var _loc6_:PlayerGameObject = null;
         var _loc7_:PlayerGameObject = null;
         var _loc8_:PlayerGameObject = null;
         var _loc9_:PlayerGameObject = null;
         var _loc10_:PlayerGameObject = null;
         if(param2.length <= 0 && param3 > 0 || param2.length > 0 && param3 <= 0)
         {
            _loc7_ = this.playerGameObject;
            LogUtils.log("Inconsistent items vector of type: " + param1 + " and totalDropRatio for player:" + _loc7_._id,this,3,"RewardHandlerMisc",true,true,false);
            return null;
         }
         if(param3 <= 0)
         {
            _loc8_ = this.playerGameObject;
            LogUtils.log("No droppable items of Type: " + param1 + " for player:" + _loc8_._id,this,0,"RewardHandlerMisc",true,false,false);
            return null;
         }
         var _loc4_:int = int(Random.integer(param3));
         LogUtils.log("Starting search for item at randomDropRatio of: " + _loc4_ + " in a totalDropRatio of: " + param3,this,0,"RewardHandlerMisc",false,false,false);
         for each(_loc5_ in param2)
         {
            if(_loc4_ < _loc5_.dropRatio)
            {
               _loc10_ = this.playerGameObject;
               LogUtils.log("Found item to drop: " + _loc5_.id + " of type: " + _loc5_.type + " for player:" + _loc10_._id,this,4,"RewardHandlerMisc",false,false,false);
               return _loc5_;
            }
            _loc9_ = this.playerGameObject;
            LogUtils.log("randomDropRatio: " + _loc4_ + "\t> itemDropRatio: " + _loc5_.dropRatio + "\tfor item: " + _loc5_.id + " of type: " + _loc5_.type + " for player:" + _loc9_._id,this,0,"RewardHandlerMisc",false,false,false);
            _loc4_ -= _loc5_.dropRatio;
         }
         _loc6_ = this.playerGameObject;
         LogUtils.log("NO Item FOUND to drop of type: " + _loc5_.type + " for player:" + _loc6_._id,this,3,"RewardHandlerMisc",true,true,false);
         return null;
      }
      
      private function calculateEquipmentDrop(param1:int, param2:PhysicsGameObject) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:ItemData = null;
         var _loc6_:Number = Number(RewardConfig.getEquipmentDefaultDropChance());
         if(this.checkIfToGiveItemReward(_loc6_))
         {
            _loc3_ = this.getWornItemsModifiedByTarget(this.clothingItems,param2);
            _loc4_ = int(this.calculateTotalDropRatio(_loc3_));
            _loc5_ = this.getItemIdForDrop("Clothing",_loc3_,_loc4_);
            if(_loc5_ != null)
            {
               this.addLootItemFor(param2,_loc5_.id);
            }
         }
      }
      
      private function checkIfToGiveItemReward(param1:Number) : Boolean
      {
         var _loc8_:PlayerGameObject = null;
         var _loc2_:String = "Luck";
         var _loc3_:PlayerGameObject = this.playerGameObject;
         var _loc4_:int = int((!!_loc3_.stats ? _loc3_.stats.getStat(_loc2_) : null).calculateRoundedValue());
         var _loc5_:Number = Math.log(_loc4_ + 2) * 0.4342944819032518 * param1 + _loc4_ / 100;
         var _loc6_:Number = Number(Random.float(0,100));
         if(_loc5_ >= _loc6_)
         {
            _loc8_ = this.playerGameObject;
            LogUtils.log("Item Reward Success because Chance: " + _loc5_ + " Random:" + _loc6_ + " for player:" + _loc8_._id,this,4,"ItemDropChance",false,false,false);
            return true;
         }
         var _loc7_:PlayerGameObject = this.playerGameObject;
         LogUtils.log("Item Reward Failure because Chance: " + _loc5_ + " Random:" + _loc6_ + " for player:" + _loc7_._id,this,0,"ItemDropChance",false,false,false);
         return false;
      }
      
      private function getFilteredItems(param1:Vector.<ItemData>) : Vector.<ItemData>
      {
         var _loc3_:* = undefined;
         var _loc2_:Vector.<ItemData> = new Vector.<ItemData>();
         for each(_loc3_ in param1)
         {
            if(_loc3_.dropRatio > 0 && _loc3_.requiredLevel <= this.player.level)
            {
               if(_loc3_.type != "Clothing" && _loc3_.type != "Recipe" || !this.player.inventory.containsItem(_loc3_.id))
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         return this.sortRewards(_loc2_);
      }
      
      private function sortRewards(param1:Vector.<ItemData>) : Vector.<ItemData>
      {
         var _loc2_:* = undefined;
         var _loc3_:PlayerGameObject = null;
         param1.sort(this.sortById);
         param1.sort(this.sortByDropRatio);
         LogUtils.log("Sorted reward Items!",this,0,"RewardHandlerMisc",false,false,false);
         for each(_loc2_ in param1)
         {
            _loc3_ = this.playerGameObject;
            LogUtils.log("Sorted by id: " + _loc2_.id + " then dropRate : " + _loc2_.dropRatio + " of type: " + _loc2_.type + " for player:" + _loc3_._id,this,0,"RewardHandlerMisc",false,false,false);
         }
         return param1;
      }
      
      private function sortById(param1:ItemData, param2:ItemData) : int
      {
         return StringUtils.compareTo(param1.id,param2.id);
      }
      
      private function sortByDropRatio(param1:ItemData, param2:ItemData) : int
      {
         return param2.dropRatio - param1.dropRatio;
      }
      
      private function calculateTotalDropRatio(param1:Vector.<ItemData>) : int
      {
         var _loc3_:* = undefined;
         var _loc4_:PlayerGameObject = null;
         var _loc5_:PlayerGameObject = null;
         var _loc6_:PlayerGameObject = null;
         var _loc2_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc4_ = this.playerGameObject;
            LogUtils.log("DropRatio: " + _loc3_.dropRatio + " for item: " + _loc3_.id + " of type: " + _loc3_.type + " for player:" + _loc4_._id,this,0,"RewardHandlerMisc",false,false,false);
            _loc2_ += _loc3_.dropRatio;
         }
         if(_loc3_)
         {
            _loc5_ = this.playerGameObject;
            LogUtils.log("DropRatioTotal: " + _loc2_ + " for type: " + _loc3_.type + " for player:" + _loc5_._id,this,0,"RewardHandlerMisc",false,false,false);
         }
         else
         {
            _loc6_ = this.playerGameObject;
            LogUtils.log("DropRatioTotal: " + _loc2_ + " for player:" + _loc6_._id,this,0,"RewardHandlerMisc",false,false,false);
         }
         return _loc2_;
      }
      
      private function getWornItemsModifiedByTarget(param1:Vector.<ItemData>, param2:PhysicsGameObject) : Vector.<ItemData>
      {
         var _loc5_:* = undefined;
         var _loc6_:PlayerGameObject = null;
         var _loc7_:PlayerGameObject = null;
         var _loc3_:* = undefined;
         var _loc4_:PlayerGameObject = null;
         if(param2 is PlayerGameObject)
         {
            LogUtils.log("Starting dropRatio modification for player: " + this.player.id,this,0,"RewardHandlerMisc",false,false,false);
            _loc3_ = new Vector.<ItemData>();
            _loc4_ = param2 as PlayerGameObject;
            for each(_loc5_ in param1)
            {
               _loc5_.dropRatio == -1;
               if(_loc4_.wornItemsContainer.isWearingItem(_loc5_.id))
               {
                  _loc5_.dropRatio = (_loc5_.dropRatio + RewardConfig.getTargetWornItemDropRatioAdd()) * RewardConfig.getTargetWornItemDropRatioMultiply();
                  _loc6_ = this.playerGameObject;
                  LogUtils.log("Modified DropRatio: " + _loc5_.dropRatio + "\tfor item: " + _loc5_.id + " of type: " + _loc5_.type + " for player:" + _loc6_._id,this,4,"RewardHandlerMisc",false,false,false);
               }
               else
               {
                  _loc7_ = this.playerGameObject;
                  LogUtils.log("DropRatio: " + _loc5_.dropRatio + "\tfor item: " + _loc5_.id + " of type: " + _loc5_.type + " for player:" + _loc7_._id,this,0,"RewardHandlerMisc",false,false,false);
               }
               _loc3_.push(_loc5_);
            }
            return this.sortRewards(_loc3_);
         }
         return param1;
      }
      
      public function syncRewardHandler() : void
      {
         var _loc2_:PlayerGameObject = null;
         var _loc3_:* = undefined;
         var _loc1_:ItemData = null;
         if(!this.player)
         {
            _loc2_ = this.playerGameObject;
            this.player = BattleManager.findPlayer(_loc2_._id);
         }
         this.player.addIngameMoney(this.inGameMoneyGained);
         this.player.addPremiumMoney(this.premiumMoneyGained);
         CRMService.sendEvent("Economy","Earn GC","Started",null,null,this.inGameMoneyGained);
         CRMService.sendEvent("Economy","Earn PC","Started",null,null,this.premiumMoneyGained);
         if(this.itemsLooted)
         {
            for each(_loc3_ in this.itemsLooted)
            {
               if(_loc3_.id != null && _loc3_.id.length > 0)
               {
                  _loc1_ = ItemManager.getItemData(_loc3_.id);
                  if(Boolean(_loc1_) && _loc1_.type != "Trophy")
                  {
                     this.player.inventory.addItem(_loc3_.id,_loc3_.amount);
                     CRMService.sendEvent("Economy","Earn_Item","Started",_loc3_.id);
                  }
               }
            }
         }
      }
   }
}

