package tuxwars.player
{
   import com.dchoc.events.*;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.*;
   import tuxwars.challenges.events.*;
   import tuxwars.items.*;
   import tuxwars.items.managers.*;
   import tuxwars.net.messages.*;
   
   public class Inventory
   {
      public static const ITEM_ADDED:String = "ItemAdded";
      
      public static const ITEM_REMOVED:String = "ItemRemoved";
      
      public static const ITEM_UNLOCKED:String = "ItemUnlocked";
      
      private var CACHE:Object = {};
      
      private var items:Vector.<Item> = new Vector.<Item>();
      
      private var player:TuxFriend;
      
      public function Inventory(param1:TuxFriend)
      {
         super();
         this.player = param1;
      }
      
      private static function sortByPriority(param1:Item, param2:Item) : int
      {
         return param1.sortPriority - param2.sortPriority;
      }
      
      public function initInventory() : void
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Item";
         var _loc2_:* = ProjectManager.findTable(_loc1_);
         var _loc3_:Array = _loc2_._rows;
         for each(_loc4_ in _loc3_)
         {
            if(!this.hasItem(_loc4_.id))
            {
               this.setItem(_loc4_.id,0);
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.items)
         {
            _loc1_.dispose();
         }
         this.items.splice(0,this.items.length);
      }
      
      public function containsItem(param1:String) : Boolean
      {
         return this.getItem(param1) != null;
      }
      
      public function ownsItem(param1:String) : Boolean
      {
         var _loc2_:Item = this.getItem(param1);
         if(_loc2_ != null && _loc2_.amount > 0)
         {
            return true;
         }
         return false;
      }
      
      public function setItem(param1:String, param2:int, param3:Boolean = true) : Item
      {
         var _loc4_:String = null;
         var _loc5_:Error = null;
         var _loc6_:int = 0;
         assert("ItemID is null.",true,param1 != null);
         if(param2 < 0)
         {
            _loc4_ = "setItem called for item:" + param1 + ", trying to add a negative amount: " + param2;
            _loc5_ = new Error();
            MessageCenter.sendEvent(new ErrorMessage("Inventory Error","setItem",_loc4_,param1,_loc5_));
         }
         var _loc7_:Item = this.getItem(param1);
         if(_loc7_)
         {
            _loc6_ = _loc7_.amount;
            _loc7_.amount = param2;
            if(param3)
            {
               if(param2 < _loc6_)
               {
                  MessageCenter.sendEvent(new InventoryUpdatedMessage(this.player,_loc7_,"ItemRemoved"));
               }
               else if(param2 > _loc6_)
               {
                  MessageCenter.sendEvent(new InventoryUpdatedMessage(this.player,_loc7_,"ItemAdded"));
               }
            }
         }
         else
         {
            this.createNewItemInInventory(param1,param2);
            _loc7_ = this.getItem(param1);
            if((Boolean(_loc7_)) && param3)
            {
               MessageCenter.sendEvent(new InventoryUpdatedMessage(this.player,_loc7_,"ItemAdded"));
            }
         }
         return _loc7_;
      }
      
      public function addItem(param1:String, param2:int = 1, param3:Boolean = true, param4:Boolean = true) : Item
      {
         var _loc5_:String = null;
         var _loc6_:Item = null;
         assert("ItemID is null.",true,param1 != null);
         if(param2 < 0)
         {
            _loc5_ = "addItem called for item:" + param1 + ", trying to add a negative amount: " + param2;
            MessageCenter.sendEvent(new ErrorMessage("Inventory Error","addItem",_loc5_,param1,new Error()));
         }
         else if(param2 > 0)
         {
            if(ItemManager.getItemData(param1))
            {
               if(!this.containsItem(param1))
               {
                  this.createNewItemInInventory(param1,param2);
               }
               else
               {
                  _loc6_ = this.getItem(param1);
                  _loc6_.increaseAmount(param2);
               }
               if(param3)
               {
                  MessageCenter.sendEvent(new InventoryUpdatedMessage(this.player,this.getItem(param1),"ItemAdded"));
               }
               if(param4)
               {
                  MessageCenter.sendEvent(new ChallengeItemGainedMessage(this.player,this.getItem(param1),param2));
               }
            }
         }
         else
         {
            LogUtils.log("addItem called with 0, no change",this,2,"ItemData",false);
         }
         return this.getItem(param1);
      }
      
      public function removeItem(param1:String, param2:int = 1, param3:Boolean = true) : void
      {
         var _loc4_:Item = null;
         var _loc5_:int = 0;
         assert("Item is null.",true,param1 != null);
         if(param2 < 0)
         {
            MessageCenter.sendEvent(new ErrorMessage("Inventory Error","removeItem1","removeItem called for item:" + param1 + ", trying to remove a negative amount: " + param2,param1,new Error()));
         }
         else if(param2 > 0)
         {
            _loc4_ = this.getItem(param1);
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.amount - param2;
               if(_loc5_ < 0)
               {
                  MessageCenter.sendEvent(new ErrorMessage("Inventory Error","removeItem2","removeItem called for item:" + param1 + ", trying to remove more items than" + " there are in inventory, (amount in inventory: " + _loc4_.amount + ") (amount to remove: " + param2 + ")",param1,new Error()));
               }
               else
               {
                  _loc4_.amount = _loc5_;
                  if(param3)
                  {
                     MessageCenter.sendEvent(new InventoryUpdatedMessage(this.player,_loc4_,"ItemRemoved"));
                  }
               }
            }
            else
            {
               LogUtils.log("removeItem called for item:" + param1 + ", item does not exist in inventory",this,3,"Items");
            }
         }
         else
         {
            LogUtils.log("removeItem called for item:" + param1 + " with amount 0, no change",this,2,"ItemData",false);
         }
      }
      
      public function removeItemWithId(param1:String) : Item
      {
         this.removeItem(param1);
         return this.getItem(param1);
      }
      
      public function getItem(param1:String, param2:Boolean = false) : Item
      {
         var _loc3_:Item = null;
         if(!this.CACHE.hasOwnProperty(param1))
         {
            _loc3_ = DCUtils.find(this.items,"id",param1);
            this.CACHE[param1] = _loc3_;
         }
         else
         {
            _loc3_ = this.CACHE[param1];
         }
         if(!param2 && (!_loc3_ || _loc3_.amount <= 0))
         {
            return null;
         }
         return _loc3_;
      }
      
      public function hasItem(param1:String, param2:Boolean = false) : Boolean
      {
         return this.getItem(param1,param2) != null;
      }
      
      public function findItems(param1:String) : Vector.<Item>
      {
         return Vector.<Item>(DCUtils.findAll(this.items,param1,"type"));
      }
      
      private function createNewItemInInventory(param1:String, param2:int) : void
      {
         var _loc3_:Item = DCUtils.find(this.items,"id",param1);
         if(_loc3_ != null)
         {
            _loc3_.amount = param2;
         }
         else
         {
            _loc3_ = ItemManager.createItem(param1);
            _loc3_.amount = param2;
            this.items.push(_loc3_);
         }
         if(Boolean(this.CACHE.hasOwnProperty(param1)) && this.CACHE[param1] == null && _loc3_ != null)
         {
            this.CACHE[param1] = _loc3_;
         }
      }
      
      public function getNextWeaponWithAmmo() : WeaponItem
      {
         var _loc2_:* = undefined;
         var _loc1_:Vector.<Item> = this.findItems("Weapon");
         _loc1_.sort(sortByPriority);
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.amount > 0 || Boolean(BattleManager.isPracticeMode()))
            {
               return _loc2_ as WeaponItem;
            }
         }
         return null;
      }
      
      public function getTotalAmountOfAmmo() : int
      {
         var _loc3_:* = undefined;
         var _loc1_:int = 0;
         var _loc2_:Vector.<Item> = this.findItems("Weapon");
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.amount > 0)
            {
               _loc1_ += _loc3_.amount;
            }
         }
         return _loc1_;
      }
   }
}

