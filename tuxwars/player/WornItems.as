package tuxwars.player
{
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.follower.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.items.*;
   import tuxwars.items.data.SetReference;
   import tuxwars.net.messages.*;
   
   public class WornItems
   {
      public static const ITEM_WEAR:String = "ItemWear";
      
      public static const ITEM_UNWEAR:String = "ItemUnWear";
      
      public static const ITEM_WEAR_PREVIEW:String = "ItemWearPreview";
      
      public static const ITEM_UNWEAR_PREVIEW:String = "ItemUnWearPreview";
      
      private static const EQUIPMENT_VALUE_SLOTS:Array = ["Feet","Head","Torso"];
      
      private const _wornItemStats:PlayerStats;
      
      private const wornItems:Object;
      
      private var inventory:Inventory;
      
      private var player:TuxFriend;
      
      private var playerGameObject:PlayerGameObject;
      
      private var actualFaceItemId:String;
      
      public function WornItems(param1:TuxFriend, param2:PlayerGameObject = null)
      {
         var _loc3_:* = undefined;
         this._wornItemStats = new PlayerStats();
         this.wornItems = {};
         super();
         this.player = param1;
         this.playerGameObject = param2;
         this.inventory = !!param1 ? param1.inventory : param2.inventory;
         for each(_loc3_ in Equippable.EQUIPPABLE_BONUS_STATS)
         {
            this._wornItemStats.create(_loc3_,param2 != null ? param2.body : null,0,false);
         }
      }
      
      public function dispose() : void
      {
         this._wornItemStats.dispose();
         DCUtils.deleteProperties(this.wornItems);
      }
      
      public function getWornItems() : Object
      {
         return this.wornItems;
      }
      
      public function getWornItemInSlot(param1:String) : ClothingItem
      {
         return this.wornItems[param1];
      }
      
      public function isWearingItem(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.wornItems)
         {
            if(_loc2_.id == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getWornItemsStats() : PlayerStats
      {
         return this._wornItemStats;
      }
      
      public function wearItem(param1:String) : ClothingItem
      {
         var _loc2_:SetReference = null;
         if(param1 == null)
         {
            LogUtils.log("Trying to wear an item with null ID.",this,3,"Items",false,false,false);
            return null;
         }
         var _loc3_:ClothingItem = this.inventory.getItem(param1) as ClothingItem;
         if(_loc3_ == null)
         {
            LogUtils.log("Player (" + this.player.id + ") doesn\'t have item: " + param1,this,3,"Items",true,false,false);
            return null;
         }
         if(Boolean(this.wornItems[_loc3_.slot]) && (this.wornItems[_loc3_.slot] as ClothingItem).id == _loc3_.id)
         {
            return null;
         }
         var _loc4_:ClothingItem = this.unwearItemInSlot(_loc3_.slot);
         this.wornItems[_loc3_.slot] = _loc3_;
         if(_loc3_.hasStats())
         {
            this.addStatsToPlayerGameObject(_loc3_.statBonuses,"item: " + _loc3_.id);
         }
         if(this.hasSet() && (_loc3_.slot == "Torso" || _loc3_.slot == "Feet" || _loc3_.slot == "Head"))
         {
            _loc2_ = this.getWornItemInSlot("Torso").setReference;
            this.addStatsToPlayerGameObject(_loc2_.statBonuses,"set: " + _loc2_.id);
            this.addFollowersToPlayerGameObject(_loc2_.followers);
         }
         this.addFollowersToPlayerGameObject(_loc3_.followers);
         if(this.player != null)
         {
            MessageCenter.sendEvent(new WornItemsUpdatedMessage(this.player,_loc3_,"ItemWear"));
         }
         return _loc4_;
      }
      
      private function addStatsToPlayerGameObject(param1:Stats, param2:String) : void
      {
         var _loc3_:* = undefined;
         if(param1)
         {
            LogUtils.log("Caused stat change from " + param2,this,0,"Items",false,false,false);
            for each(_loc3_ in Equippable.EQUIPPABLE_BONUS_STATS)
            {
               this._wornItemStats.addStat(_loc3_,param1.getStat(_loc3_),this.playerGameObject != null ? this.playerGameObject.body : null);
            }
         }
      }
      
      private function addFollowersToPlayerGameObject(param1:Vector.<FollowerData>) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:PlayerGameObject = null;
         var _loc2_:Vec2 = null;
         if(this.playerGameObject != null && Boolean(param1))
         {
            _loc2_ = this.playerGameObject.bodyLocation.copy();
            for each(_loc3_ in param1)
            {
               _loc4_ = this.playerGameObject;
               Followers.createFollower(_loc3_.id,_loc2_,(_loc4_.game as TuxWarsGame).tuxWorld.physicsWorld,this.playerGameObject.stats.getStat("Attack"),this.playerGameObject.playerBoosterStats,this.playerGameObject,new Tagger(this.playerGameObject));
            }
            _loc2_.dispose();
         }
      }
      
      public function hasSet(param1:ClothingItem = null) : Boolean
      {
         var _loc2_:* = this.getWornItemInSlot("Head");
         var _loc3_:* = this.getWornItemInSlot("Feet");
         var _loc4_:* = this.getWornItemInSlot("Torso");
         if(param1)
         {
            switch(param1.slot)
            {
               case "Head":
                  _loc2_ = param1;
                  break;
               case "Feet":
                  _loc3_ = param1;
                  break;
               case "Torso":
                  _loc4_ = param1;
                  break;
               default:
                  LogUtils.log("Wrong slot for set item",this,0,"Items",false,false,false);
            }
         }
         if(_loc2_ && _loc2_.setReference && _loc3_ && _loc3_.setReference && _loc4_ && _loc4_.setReference && _loc4_.setReference.id == _loc3_.setReference.id && _loc4_.setReference.id == _loc2_.setReference.id)
         {
            return true;
         }
         return false;
      }
      
      public function unwearItemInSlot(param1:String) : ClothingItem
      {
         var _loc2_:SetReference = null;
         var _loc3_:ClothingItem = null;
         if(param1)
         {
            if(this.hasSet() && (param1 == "Torso" || param1 == "Feet" || param1 == "Head"))
            {
               _loc2_ = this.getWornItemInSlot("Torso").setReference;
               this.removeStatsFromPlayerGameObject(_loc2_.statBonuses,"set: " + _loc2_.id);
               this.removeFollowersFromPlayerGameObject(_loc2_.followers);
            }
            _loc3_ = this.wornItems[param1];
            if(_loc3_ != null && _loc3_.hasStats())
            {
               this.removeStatsFromPlayerGameObject(_loc3_.statBonuses,"item: " + _loc3_.id);
            }
            if(_loc3_)
            {
               this.removeFollowersFromPlayerGameObject(_loc3_.followers);
            }
            if(this.wornItems[param1] != null)
            {
               this.wornItems[param1] = null;
               delete this.wornItems[param1];
            }
            if(this.player != null && _loc3_ != null)
            {
               MessageCenter.sendEvent(new WornItemsUpdatedMessage(this.player,_loc3_,"ItemUnWear"));
            }
            return _loc3_;
         }
         LogUtils.log("Trying to unwear item in slot: " + param1,this,2,"Items",false,false,false);
         return null;
      }
      
      private function removeStatsFromPlayerGameObject(param1:Stats, param2:String) : void
      {
         var _loc3_:* = undefined;
         if(param1)
         {
            LogUtils.log("Unequip caused stat change from " + param2,this,0,"Items",false,false,false);
            for each(_loc3_ in Equippable.EQUIPPABLE_BONUS_STATS)
            {
               this._wornItemStats.removeStat(_loc3_,param1.getStat(_loc3_));
            }
         }
      }
      
      private function removeFollowersFromPlayerGameObject(param1:Vector.<FollowerData>) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Follower = null;
         if(this.playerGameObject != null && Boolean(param1))
         {
            for each(_loc3_ in param1)
            {
               _loc2_ = this.playerGameObject.getFollower(_loc3_.id);
               if(_loc2_)
               {
                  _loc2_.markForRemoval();
               }
            }
         }
      }
      
      public function wornItemsIncludedItemCheck() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:String = null;
         var _loc2_:ClothingItem = null;
         for each(_loc3_ in EQUIPMENT_VALUE_SLOTS)
         {
            if(this.wornItems[_loc3_] as ClothingItem != null)
            {
               _loc1_ = (this.wornItems[_loc3_] as ClothingItem).includedFacialExpressionID;
               if(_loc1_)
               {
                  break;
               }
            }
         }
         if(_loc1_)
         {
            _loc2_ = this.wearItem(_loc1_);
            if(Boolean(_loc2_) && _loc2_.id != this.actualFaceItemId)
            {
               this.actualFaceItemId = _loc2_.id;
            }
         }
         else if(this.actualFaceItemId)
         {
            this.wearItem(this.actualFaceItemId);
            this.actualFaceItemId = null;
         }
      }
      
      public function calculateEquipmentValue() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         for each(_loc2_ in EQUIPMENT_VALUE_SLOTS)
         {
            if(this.wornItems[_loc2_] as ClothingItem != null)
            {
               _loc1_ += (this.wornItems[_loc2_] as ClothingItem).requierdLevel;
            }
         }
         return _loc1_;
      }
      
      public function containsClothingItem(param1:Item) : Boolean
      {
         var _loc2_:ClothingItem = param1 as ClothingItem;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:ClothingItem = this.wornItems[_loc2_.slot] as ClothingItem;
         if(_loc3_ == null)
         {
            return false;
         }
         if(_loc3_.id == _loc2_.id)
         {
            return true;
         }
         return false;
      }
   }
}

