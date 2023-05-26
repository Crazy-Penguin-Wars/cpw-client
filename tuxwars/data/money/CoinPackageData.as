package tuxwars.data.money
{
   import com.dchoc.projectdata.Row;
   
   public class CoinPackageData
   {
      
      private static const ID:String = "ID";
      
      private static const AMOUNT:String = "Amount";
      
      private static const EXTRA_AMOUNT:String = "ExtraAmount";
      
      private static const CREDIT_COST:String = "CreditCost";
      
      private static const SORT_PRIORITY:String = "SortPriority";
       
      
      private var row:Row;
      
      public function CoinPackageData(row:Row)
      {
         super();
         this.row = row;
      }
      
      public function get id() : String
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["ID"])
         {
            _loc1_._cache["ID"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","ID");
         }
         var _loc2_:* = _loc1_._cache["ID"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get amount() : int
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["Amount"])
         {
            _loc1_._cache["Amount"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Amount");
         }
         var _loc2_:* = _loc1_._cache["Amount"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get extraAmount() : int
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["ExtraAmount"])
         {
            _loc1_._cache["ExtraAmount"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","ExtraAmount");
         }
         var _loc2_:* = _loc1_._cache["ExtraAmount"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get creditCost() : int
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["CreditCost"])
         {
            _loc1_._cache["CreditCost"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","CreditCost");
         }
         var _loc2_:* = _loc1_._cache["CreditCost"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get sortPriority() : int
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["SortPriority"])
         {
            _loc1_._cache["SortPriority"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","SortPriority");
         }
         var _loc2_:* = _loc1_._cache["SortPriority"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
   }
}
