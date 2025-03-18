package tuxwars.home.ui.logic.slotmachine
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import no.olog.utilfunctions.assert;
   
   public class SlotMachineReference
   {
      public static const TABLE:String = "SlotMachine";
      
      public static const SLOTCONF:String = "SlotMachineConfiguration";
      
      private static const REEL:String = "Reel";
      
      private static const TITLE:String = "Title";
      
      private static const PICTURE:String = "Picture";
      
      private static const DESCRIPTION:String = "Description";
      
      private static const SORT_ORDER:String = "SortOrder";
      
      private static const REWARD_ITEM:String = "RewardItem";
      
      private static const REWARD_ITEM_AMOUNT:String = "RewardItemAmount";
      
      private static const PLAY_PRICE_IN_CASH:String = "PlayPriceInCash";
      
      private var _row:Row;
      
      public function SlotMachineReference(row:Row)
      {
         super();
         assert("SlotMachineReference is null",true,row != null);
         _row = row;
      }
      
      public function get id() : String
      {
         return _row.id;
      }
      
      public function getResult(reelNumber:int) : GraphicsReference
      {
         if(_row)
         {
            var _loc5_:* = "Reel" + reelNumber;
            var _loc3_:Row = _row;
            if(!_loc3_._cache[_loc5_])
            {
               _loc3_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc5_);
            }
            §§push(_loc3_._cache[_loc5_]);
         }
         else
         {
            §§push(null);
         }
         var _loc2_:Field = §§pop();
         var _loc4_:*;
         return !!_loc2_ ? (_loc4_ = _loc2_, new GraphicsReference(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
      
      public function get sortOrder() : int
      {
         if(_row)
         {
            var _loc4_:String = "SortOrder";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function getCashPrice() : int
      {
         if(_row)
         {
            var _loc4_:String = "PlayPriceInCash";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 1;
      }
      
      public function getAmountOfItems() : int
      {
         if(_row)
         {
            var _loc4_:String = "RewardItemAmount";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      private function getRandomItem() : String
      {
         var rnd:int = 0;
         if(_row)
         {
            var _loc6_:String = "RewardItem";
            var _loc4_:Row = _row;
            if(!_loc4_._cache[_loc6_])
            {
               _loc4_._cache[_loc6_] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name",_loc6_);
            }
            §§push(_loc4_._cache[_loc6_]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc5_:*;
         var _loc2_:Array = !!_loc1_ ? (_loc5_ = _loc1_, _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) : null;
         if(_loc2_ == null || _loc2_.length == 0)
         {
            return null;
         }
         if(_loc2_.length == 1)
         {
            return Config.getDataDir() + _loc2_[0];
         }
         rnd = Math.floor(_loc2_.length * Math.random());
         return Config.getDataDir() + _loc2_[rnd];
      }
   }
}

