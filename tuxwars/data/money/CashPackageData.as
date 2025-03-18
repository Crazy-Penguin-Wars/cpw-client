package tuxwars.data.money
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class CashPackageData
   {
      private static const ID:String = "ID";
      
      private static const AMOUNT:String = "Amount";
      
      private static const EXTRA_AMOUNT:String = "ExtraAmount";
      
      private static const CREDIT_COST:String = "CreditCost";
      
      private static const SORT_PRIORITY:String = "SortPriority";
      
      private static const CREDIT_OLD:String = "CreditOld";
      
      private var row:Row;
      
      public function CashPackageData(row:Row)
      {
         super();
         this.row = row;
      }
      
      public function get id() : String
      {
         var _loc3_:String = "ID";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get amount() : int
      {
         var _loc3_:String = "Amount";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get extraAmount() : int
      {
         var _loc3_:String = "ExtraAmount";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get creditCost() : int
      {
         var _loc3_:String = "CreditCost";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get sortPriority() : int
      {
         var _loc3_:String = "SortPriority";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get creditOld() : int
      {
         var _loc3_:String = "CreditOld";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
   }
}

