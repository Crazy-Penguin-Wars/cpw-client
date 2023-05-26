package tuxwars.items.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   
   public class BetData extends ItemData
   {
      
      private static const VALUE_INGAME:String = "ValueIngame";
      
      private static const VALUE_PREMIUM:String = "ValuePremium";
       
      
      private var _valueIngame:int;
      
      private var _valuePremium:int;
      
      private var _betSlotName:String;
      
      public function BetData(row:Row)
      {
         super(row);
         var _loc3_:* = row;
         if(!_loc3_._cache["ValueIngame"])
         {
            _loc3_._cache["ValueIngame"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","ValueIngame");
         }
         var field:Field = _loc3_._cache["ValueIngame"];
         var _loc4_:*;
         _valueIngame = !!field ? (_loc4_ = field, _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : 0;
         var _loc5_:* = row;
         if(!_loc5_._cache["ValuePremium"])
         {
            _loc5_._cache["ValuePremium"] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name","ValuePremium");
         }
         field = _loc5_._cache["ValuePremium"];
         var _loc6_:*;
         _valuePremium = !!field ? (_loc6_ = field, _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : 0;
      }
      
      public function get valueIngame() : int
      {
         return _valueIngame;
      }
      
      public function get valuePremium() : int
      {
         return _valuePremium;
      }
      
      public function set betSlotName(name:String) : void
      {
         _betSlotName = name;
      }
      
      public function get betSlotName() : String
      {
         return _betSlotName;
      }
   }
}
