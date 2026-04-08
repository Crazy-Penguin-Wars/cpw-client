package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class BetData extends ItemData
   {
      private static const VALUE_INGAME:String = "ValueIngame";
      
      private static const VALUE_PREMIUM:String = "ValuePremium";
      
      private var _valueIngame:int;
      
      private var _valuePremium:int;
      
      private var _betSlotName:String;
      
      public function BetData(param1:Row)
      {
         var _loc5_:* = undefined;
         var _loc8_:* = undefined;
         super(param1);
         var _loc2_:String = "ValueIngame";
         var _loc3_:* = param1;
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         var _loc4_:Field = _loc3_.getCache[_loc2_];
         _loc5_ = _loc4_;
         this._valueIngame = !!_loc4_ ? (_loc5_.overrideValue != null ? int(_loc5_.overrideValue) : int(_loc5_._value)) : 0;
         var _loc6_:String = "ValuePremium";
         var _loc7_:* = param1;
         if(!_loc7_.getCache[_loc6_])
         {
            _loc7_.getCache[_loc6_] = DCUtils.find(_loc7_.getFields(),"name",_loc6_);
         }
         _loc4_ = _loc7_.getCache[_loc6_];
         _loc8_ = _loc4_;
         this._valuePremium = !!_loc4_ ? (_loc8_.overrideValue != null ? int(_loc8_.overrideValue) : int(_loc8_._value)) : 0;
      }
      
      public function get valueIngame() : int
      {
         return this._valueIngame;
      }
      
      public function get valuePremium() : int
      {
         return this._valuePremium;
      }
      
      public function set betSlotName(param1:String) : void
      {
         this._betSlotName = param1;
      }
      
      public function get betSlotName() : String
      {
         return this._betSlotName;
      }
   }
}

