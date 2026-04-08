package tuxwars.home.ui.logic.slotmachine
{
   import com.dchoc.data.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   
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
      
      public function SlotMachineReference(param1:Row)
      {
         super();
         assert("SlotMachineReference is null",true,param1 != null);
         this._row = param1;
      }
      
      public function get id() : String
      {
         return this._row.id;
      }
      
      public function getResult(param1:int) : GraphicsReference
      {
         var _loc3_:String = null;
         var _loc2_:Field = null;
         if(this._row)
         {
            _loc3_ = "Reel" + param1;
            if(!this._row.getCache[_loc3_])
            {
               this._row.getCache[_loc3_] = DCUtils.find(this._row.getFields(),"name",_loc3_);
            }
            _loc2_ = this._row.getCache[_loc3_];
         }
         trace(this._row);
         return !!_loc2_ ? new GraphicsReference(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
      
      public function get sortOrder() : int
      {
         var _loc2_:String = null;
         var _loc1_:Field = null;
         if(this._row)
         {
            _loc2_ = "SortOrder";
            if(!this._row.getCache[_loc2_])
            {
               this._row.getCache[_loc2_] = DCUtils.find(this._row.getFields(),"name",_loc2_);
            }
            _loc1_ = this._row.getCache[_loc2_];
         }
         return !!_loc1_ ? int(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : 0;
      }
      
      public function getCashPrice() : int
      {
         var _loc2_:String = null;
         var _loc1_:Field = null;
         if(this._row)
         {
            _loc2_ = "PlayPriceInCash";
            if(!this._row.getCache[_loc2_])
            {
               this._row.getCache[_loc2_] = DCUtils.find(this._row.getFields(),"name",_loc2_);
            }
            _loc1_ = this._row.getCache[_loc2_];
         }
         return !!_loc1_ ? int(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : 1;
      }
      
      public function getAmountOfItems() : int
      {
         var _loc2_:String = null;
         var _loc1_:Field = null;
         if(this._row)
         {
            _loc2_ = "RewardItemAmount";
            if(!this._row.getCache[_loc2_])
            {
               this._row.getCache[_loc2_] = DCUtils.find(this._row.getFields(),"name",_loc2_);
            }
            _loc1_ = this._row.getCache[_loc2_];
         }
         return !!_loc1_ ? int(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : 0;
      }
      
      private function getRandomItem() : String
      {
         var _loc4_:String = null;
         var _loc1_:int = 0;
         var _loc2_:Field = null;
         if(this._row)
         {
            _loc4_ = "RewardItem";
            if(!this._row.getCache[_loc4_])
            {
               this._row.getCache[_loc4_] = DCUtils.find(this._row.getFields(),"name",_loc4_);
            }
            _loc2_ = this._row.getCache[_loc4_];
         }
         var _loc3_:Array = !!_loc2_ ? (_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return null;
         }
         if(_loc3_.length == 1)
         {
            return Config.getDataDir() + _loc3_[0];
         }
         _loc1_ = Math.floor(_loc3_.length * Math.random());
         return Config.getDataDir() + _loc3_[_loc1_];
      }
   }
}

