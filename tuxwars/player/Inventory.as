package tuxwars.player
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.BattleManager;
   import tuxwars.challenges.events.ChallengeItemGainedMessage;
   import tuxwars.items.Item;
   import tuxwars.items.WeaponItem;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.net.messages.InventoryUpdatedMessage;
   
   public class Inventory
   {
      
      public static const ITEM_ADDED:String = "ItemAdded";
      
      public static const ITEM_REMOVED:String = "ItemRemoved";
      
      public static const ITEM_UNLOCKED:String = "ItemUnlocked";
       
      
      private var CACHE:Object;
      
      private var items:Vector.<Item>;
      
      private var player:TuxFriend;
      
      public function Inventory(player:TuxFriend)
      {
         CACHE = {};
         items = new Vector.<Item>();
         super();
         this.player = player;
      }
      
      private static function sortByPriority(a:Item, b:Item) : int
      {
         return a.sortPriority - b.sortPriority;
      }
      
      public function initInventory() : void
      {
         var _loc3_:ProjectManager = ProjectManager;
         var _loc4_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("Item");
         var _loc1_:Array = _loc4_._rows;
         for each(var row in _loc1_)
         {
            if(!hasItem(row.id))
            {
               setItem(row.id,0);
            }
         }
      }
      
      public function dispose() : void
      {
         for each(var item in items)
         {
            item.dispose();
         }
         items.splice(0,items.length);
      }
      
      public function containsItem(itemID:String) : Boolean
      {
         return getItem(itemID) != null;
      }
      
      public function ownsItem(itemID:String) : Boolean
      {
         var _loc2_:Item = getItem(itemID);
         if(_loc2_ != null && _loc2_.amount > 0)
         {
            return true;
         }
         return false;
      }
      
      public function setItem(itemId:String, amount:int, sendUpdate:Boolean = true) : Item
      {
         var message:* = null;
         var error:* = null;
         var _loc6_:int = 0;
         assert("ItemID is null.",true,itemId != null);
         if(amount < 0)
         {
            message = "setItem called for item:" + itemId + ", trying to add a negative amount: " + amount;
            error = new Error();
            MessageCenter.sendEvent(new ErrorMessage("Inventory Error","setItem",message,itemId,error));
         }
         var item:Item = getItem(itemId);
         if(item)
         {
            _loc6_ = item.amount;
            item.amount = amount;
            if(sendUpdate)
            {
               if(amount < _loc6_)
               {
                  MessageCenter.sendEvent(new InventoryUpdatedMessage(player,item,"ItemRemoved"));
               }
               else if(amount > _loc6_)
               {
                  MessageCenter.sendEvent(new InventoryUpdatedMessage(player,item,"ItemAdded"));
               }
            }
         }
         else
         {
            createNewItemInInventory(itemId,amount);
            item = getItem(itemId);
            if(item && sendUpdate)
            {
               MessageCenter.sendEvent(new InventoryUpdatedMessage(player,item,"ItemAdded"));
            }
         }
         return item;
      }
      
      public function addItem(itemId:String, amount:int = 1, sendUpdate:Boolean = true, sendChallengeUpdate:Boolean = true) : Item
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         assert("ItemID is null.",true,itemId != null);
         if(amount < 0)
         {
            _loc5_ = "addItem called for item:" + itemId + ", trying to add a negative amount: " + amount;
            MessageCenter.sendEvent(new ErrorMessage("Inventory Error","addItem",_loc5_,itemId,new Error()));
         }
         else if(amount > 0)
         {
            if(ItemManager.getItemData(itemId))
            {
               if(!containsItem(itemId))
               {
                  createNewItemInInventory(itemId,amount);
               }
               else
               {
                  _loc6_ = getItem(itemId);
                  _loc6_.increaseAmount(amount);
               }
               if(sendUpdate)
               {
                  MessageCenter.sendEvent(new InventoryUpdatedMessage(player,getItem(itemId),"ItemAdded"));
               }
               if(sendChallengeUpdate)
               {
                  MessageCenter.sendEvent(new ChallengeItemGainedMessage(player,getItem(itemId),amount));
               }
            }
         }
         else
         {
            LogUtils.log("addItem called with 0, no change",this,2,"ItemData",false);
         }
         return getItem(itemId);
      }
      
      public function removeItem(itemId:String, amount:int = 1, sendUpdate:Boolean = true) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         assert("Item is null.",true,itemId != null);
         if(amount < 0)
         {
            MessageCenter.sendEvent(new ErrorMessage("Inventory Error","removeItem1","removeItem called for item:" + itemId + ", trying to remove a negative amount: " + amount,itemId,new Error()));
         }
         else if(amount > 0)
         {
            _loc4_ = getItem(itemId);
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.amount - amount;
               if(_loc5_ < 0)
               {
                  MessageCenter.sendEvent(new ErrorMessage("Inventory Error","removeItem2","removeItem called for item:" + itemId + ", trying to remove more items than" + " there are in inventory, (amount in inventory: " + _loc4_.amount + ") (amount to remove: " + amount + ")",itemId,new Error()));
               }
               else
               {
                  _loc4_.amount = _loc5_;
                  if(sendUpdate)
                  {
                     MessageCenter.sendEvent(new InventoryUpdatedMessage(player,_loc4_,"ItemRemoved"));
                  }
               }
            }
            else
            {
               LogUtils.log("removeItem called for item:" + itemId + ", item does not exist in inventory",this,3,"Items");
            }
         }
         else
         {
            LogUtils.log("removeItem called for item:" + itemId + " with amount 0, no change",this,2,"ItemData",false);
         }
      }
      
      public function removeItemWithId(id:String) : Item
      {
         removeItem(id);
         return getItem(id);
      }
      
      public function getItem(id:String, ignoreAmount:Boolean = false) : Item
      {
         var item:* = null;
         if(!CACHE.hasOwnProperty(id))
         {
            item = DCUtils.find(items,"id",id);
            CACHE[id] = item;
         }
         else
         {
            item = CACHE[id];
         }
         if(!ignoreAmount && (!item || item.amount <= 0))
         {
            return null;
         }
         return item;
      }
      
      public function hasItem(id:String, ignoreAmount:Boolean = false) : Boolean
      {
         return getItem(id,ignoreAmount) != null;
      }
      
      public function findItems(type:String) : Vector.<Item>
      {
         return Vector.<Item>(DCUtils.findAll(items,type,"type"));
      }
      
      private function createNewItemInInventory(itemID:String, amount:int) : void
      {
         var item:Item = DCUtils.find(items,"id",itemID);
         if(item != null)
         {
            item.amount = amount;
         }
         else
         {
            item = ItemManager.createItem(itemID);
            item.amount = amount;
            items.push(item);
         }
         if(CACHE.hasOwnProperty(itemID) && CACHE[itemID] == null && item != null)
         {
            CACHE[itemID] = item;
         }
      }
      
      public function getNextWeaponWithAmmo() : WeaponItem
      {
         var _loc2_:Vector.<Item> = findItems("Weapon");
         _loc2_.sort(sortByPriority);
         for each(var item in _loc2_)
         {
            if(item.amount > 0 || BattleManager.isPracticeMode())
            {
               return item as WeaponItem;
            }
         }
         return null;
      }
      
      public function getTotalAmountOfAmmo() : int
      {
         var ammo:int = 0;
         var _loc2_:Vector.<Item> = findItems("Weapon");
         for each(var item in _loc2_)
         {
            if(item.amount > 0)
            {
               ammo += item.amount;
            }
         }
         return ammo;
      }
   }
}
