package tuxwars.player
{
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.battle.data.follower.Followers;
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.items.ClothingItem;
   import tuxwars.items.Equippable;
   import tuxwars.items.Item;
   import tuxwars.items.data.SetReference;
   import tuxwars.net.messages.WornItemsUpdatedMessage;
   
   public class WornItems
   {
      
      private static const EQUIPMENT_VALUE_SLOTS:Array = ["Feet","Head","Torso"];
      
      public static const ITEM_WEAR:String = "ItemWear";
      
      public static const ITEM_UNWEAR:String = "ItemUnWear";
      
      public static const ITEM_WEAR_PREVIEW:String = "ItemWearPreview";
      
      public static const ITEM_UNWEAR_PREVIEW:String = "ItemUnWearPreview";
       
      
      private const _wornItemStats:PlayerStats = new PlayerStats();
      
      private const wornItems:Object = {};
      
      private var inventory:Inventory;
      
      private var player:TuxFriend;
      
      private var playerGameObject:PlayerGameObject;
      
      private var actualFaceItemId:String;
      
      public function WornItems(player:TuxFriend, playerGameObject:PlayerGameObject = null)
      {
         super();
         this.player = player;
         this.playerGameObject = playerGameObject;
         inventory = !!player ? player.inventory : playerGameObject.inventory;
         for each(var statName in Equippable.EQUIPPABLE_BONUS_STATS)
         {
            _wornItemStats.create(statName,playerGameObject != null ? playerGameObject.body : null,0,false);
         }
      }
      
      public function dispose() : void
      {
         _wornItemStats.dispose();
         DCUtils.deleteProperties(wornItems);
      }
      
      public function getWornItems() : Object
      {
         return wornItems;
      }
      
      public function getWornItemInSlot(slotID:String) : ClothingItem
      {
         return wornItems[slotID];
      }
      
      public function isWearingItem(itemId:String) : Boolean
      {
         for each(var clothingItem in wornItems)
         {
            if(clothingItem.id == itemId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getWornItemsStats() : PlayerStats
      {
         return _wornItemStats;
      }
      
      public function wearItem(itemId:String) : ClothingItem
      {
         var _loc3_:* = null;
         if(itemId == null)
         {
            LogUtils.log("Trying to wear an item with null ID.",this,3,"Items",false,false,false);
            return null;
         }
         var _loc2_:ClothingItem = inventory.getItem(itemId) as ClothingItem;
         if(_loc2_ == null)
         {
            LogUtils.log("Player (" + player.id + ") doesn\'t have item: " + itemId,this,3,"Items",true,false,false);
            return null;
         }
         if(wornItems[_loc2_.slot] && (wornItems[_loc2_.slot] as ClothingItem).id == _loc2_.id)
         {
            return null;
         }
         var _loc4_:ClothingItem = unwearItemInSlot(_loc2_.slot);
         wornItems[_loc2_.slot] = _loc2_;
         if(_loc2_.hasStats())
         {
            addStatsToPlayerGameObject(_loc2_.statBonuses,"item: " + _loc2_.id);
         }
         if(hasSet() && (_loc2_.slot == "Torso" || _loc2_.slot == "Feet" || _loc2_.slot == "Head"))
         {
            _loc3_ = getWornItemInSlot("Torso").setReference;
            addStatsToPlayerGameObject(_loc3_.statBonuses,"set: " + _loc3_.id);
            addFollowersToPlayerGameObject(_loc3_.followers);
         }
         addFollowersToPlayerGameObject(_loc2_.followers);
         if(player != null)
         {
            MessageCenter.sendEvent(new WornItemsUpdatedMessage(player,_loc2_,"ItemWear"));
         }
         return _loc4_;
      }
      
      private function addStatsToPlayerGameObject(stats:Stats, fromId:String) : void
      {
         if(stats)
         {
            LogUtils.log("Caused stat change from " + fromId,this,0,"Items",false,false,false);
            for each(var statName in Equippable.EQUIPPABLE_BONUS_STATS)
            {
               _wornItemStats.addStat(statName,stats.getStat(statName),playerGameObject != null ? playerGameObject.body : null);
            }
         }
      }
      
      private function addFollowersToPlayerGameObject(followers:Vector.<FollowerData>) : void
      {
         var _loc3_:* = null;
         if(playerGameObject != null && followers)
         {
            _loc3_ = playerGameObject.bodyLocation.copy();
            for each(var fod in followers)
            {
               var _loc4_:PlayerGameObject = playerGameObject;
               Followers.createFollower(fod.id,_loc3_,(_loc4_.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld,playerGameObject.stats.getStat("Attack"),playerGameObject.playerBoosterStats,playerGameObject,new Tagger(playerGameObject));
            }
            _loc3_.dispose();
         }
      }
      
      public function hasSet(clothingItem:ClothingItem = null) : Boolean
      {
         var head:* = getWornItemInSlot("Head");
         var feet:* = getWornItemInSlot("Feet");
         var torso:* = getWornItemInSlot("Torso");
         if(clothingItem)
         {
            switch(clothingItem.slot)
            {
               case "Head":
                  head = clothingItem;
                  break;
               case "Feet":
                  feet = clothingItem;
                  break;
               case "Torso":
                  torso = clothingItem;
                  break;
               default:
                  LogUtils.log("Wrong slot for set item",this,0,"Items",false,false,false);
            }
         }
         if(head && head.setReference && feet && feet.setReference && torso && torso.setReference && torso.setReference.id == feet.setReference.id && torso.setReference.id == head.setReference.id)
         {
            return true;
         }
         return false;
      }
      
      public function unwearItemInSlot(slot:String) : ClothingItem
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(slot)
         {
            if(hasSet() && (slot == "Torso" || slot == "Feet" || slot == "Head"))
            {
               _loc3_ = getWornItemInSlot("Torso").setReference;
               removeStatsFromPlayerGameObject(_loc3_.statBonuses,"set: " + _loc3_.id);
               removeFollowersFromPlayerGameObject(_loc3_.followers);
            }
            _loc2_ = wornItems[slot];
            if(_loc2_ != null && _loc2_.hasStats())
            {
               removeStatsFromPlayerGameObject(_loc2_.statBonuses,"item: " + _loc2_.id);
            }
            if(_loc2_)
            {
               removeFollowersFromPlayerGameObject(_loc2_.followers);
            }
            if(wornItems[slot] != null)
            {
               wornItems[slot] = null;
               delete wornItems[slot];
            }
            if(player != null && _loc2_ != null)
            {
               MessageCenter.sendEvent(new WornItemsUpdatedMessage(player,_loc2_,"ItemUnWear"));
            }
            return _loc2_;
         }
         LogUtils.log("Trying to unwear item in slot: " + slot,this,2,"Items",false,false,false);
         return null;
      }
      
      private function removeStatsFromPlayerGameObject(stats:Stats, fromId:String) : void
      {
         if(stats)
         {
            LogUtils.log("Unequip caused stat change from " + fromId,this,0,"Items",false,false,false);
            for each(var statName in Equippable.EQUIPPABLE_BONUS_STATS)
            {
               _wornItemStats.removeStat(statName,stats.getStat(statName));
            }
         }
      }
      
      private function removeFollowersFromPlayerGameObject(followers:Vector.<FollowerData>) : void
      {
         var _loc3_:* = null;
         if(playerGameObject != null && followers)
         {
            for each(var fodd in followers)
            {
               _loc3_ = playerGameObject.getFollower(fodd.id);
               if(_loc3_)
               {
                  _loc3_.markForRemoval();
               }
            }
         }
      }
      
      public function wornItemsIncludedItemCheck() : void
      {
         var includedFacialExplessionID:* = null;
         var _loc2_:* = null;
         for each(var slot in EQUIPMENT_VALUE_SLOTS)
         {
            if(wornItems[slot] as ClothingItem != null)
            {
               includedFacialExplessionID = (wornItems[slot] as ClothingItem).includedFacialExpressionID;
               if(includedFacialExplessionID)
               {
                  break;
               }
            }
         }
         if(includedFacialExplessionID)
         {
            _loc2_ = wearItem(includedFacialExplessionID);
            if(_loc2_ && _loc2_.id != actualFaceItemId)
            {
               actualFaceItemId = _loc2_.id;
            }
         }
         else if(actualFaceItemId)
         {
            wearItem(actualFaceItemId);
            actualFaceItemId = null;
         }
      }
      
      public function calculateEquipmentValue() : int
      {
         var equipmentValue:int = 0;
         for each(var slot in EQUIPMENT_VALUE_SLOTS)
         {
            if(wornItems[slot] as ClothingItem != null)
            {
               equipmentValue += (wornItems[slot] as ClothingItem).requierdLevel;
            }
         }
         return equipmentValue;
      }
      
      public function containsClothingItem(item:Item) : Boolean
      {
         var _loc2_:ClothingItem = item as ClothingItem;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:ClothingItem = wornItems[_loc2_.slot] as ClothingItem;
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
