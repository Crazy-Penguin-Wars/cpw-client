package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import flash.filters.GlowFilter;
   import org.as3commons.lang.StringUtils;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.items.references.EmissionReference;
   
   public class BoosterData extends ItemData
   {
      public static const DURATION_TYPE_SHOT:String = "Shot";
      
      public static const DURATION_TYPE_HIT:String = "Hit";
      
      public static const DURATION_TYPE_CHANGE:String = "Change";
      
      public static const DURATION_TYPE_INSTANT:String = "Instant";
      
      public static const DURATION_TYPE_TURN:String = "Turn";
      
      public static const GLOW_EFFECT:String = "GlowEffect";
      
      private static const EMISSIONS:String = "Emitters";
      
      private static const EMISSION_MISSILE_BOOSTING:String = "EmitMissileBoosting";
      
      private static const EMISSION_EXPLOSION_BOOSTING:String = "EmitterExplosionBoosting";
      
      private static const DURATION_TYPE:String = "DurationType";
      
      private static const DURATION_AMOUNT:String = "DurationAmount";
      
      private static const SIMPLE_SCRIPT:String = "SimpleScript";
      
      public function BoosterData(row:Row)
      {
         super(row);
      }
      
      public function get emissions() : Array
      {
         var field:Field;
         var localEmissions:*;
         var emissionArray:Array;
         var _loc4_:String = "Emitters";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc4_])
         {
            _loc1_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc4_);
         }
         field = _loc1_._cache[_loc4_];
         if(field)
         {
            var _loc3_:Field = field;
            localEmissions = _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
            emissionArray = localEmissions is Array ? localEmissions : [localEmissions];
            emissionArray.sort(function(row1:Row, row2:Row):int
            {
               return StringUtils.compareTo(row1.id,row2.id);
            });
            return EmissionReference.getEmissionReferences(emissionArray);
         }
         return null;
      }
      
      public function get missileBoostingEmissions() : Array
      {
         var _loc2_:* = undefined;
         var _loc5_:Array = null;
         var _loc3_:Array = null;
         var i:int = 0;
         var _loc8_:String = "EmitMissileBoosting";
         var _loc6_:Row = row;
         if(!_loc6_._cache[_loc8_])
         {
            _loc6_._cache[_loc8_] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name",_loc8_);
         }
         var _loc1_:Field = _loc6_._cache[_loc8_];
         if(_loc1_)
         {
            var _loc7_:* = _loc1_;
            _loc2_ = _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value;
            _loc5_ = _loc2_ is Array ? _loc2_ : [_loc2_];
            _loc3_ = [];
            for(i = 0; i < _loc5_.length; )
            {
               _loc3_.push(EmissionReference.get(_loc5_[i]));
               i++;
            }
            return _loc3_;
         }
         return null;
      }
      
      public function get explosionBoostingEmissions() : Array
      {
         var _loc5_:* = undefined;
         var _loc4_:Array = null;
         var _loc2_:Array = null;
         var i:int = 0;
         var _loc8_:String = "EmitterExplosionBoosting";
         var _loc6_:Row = row;
         if(!_loc6_._cache[_loc8_])
         {
            _loc6_._cache[_loc8_] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name",_loc8_);
         }
         var _loc1_:Field = _loc6_._cache[_loc8_];
         if(_loc1_)
         {
            var _loc7_:* = _loc1_;
            _loc5_ = _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value;
            _loc4_ = _loc5_ is Array ? _loc5_ : [_loc5_];
            _loc2_ = [];
            for(i = 0; i < _loc4_.length; )
            {
               _loc2_.push(EmissionReference.get(_loc4_[i]));
               i++;
            }
            return _loc2_;
         }
         return null;
      }
      
      public function get durationType() : String
      {
         var _loc4_:String = "DurationType";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get durationAmount() : int
      {
         var _loc4_:String = "DurationAmount";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get simpleScript() : Array
      {
         var _loc4_:String = "SimpleScript";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, SimpleScriptManager.parseSimpleScriptFromOdsData(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get glowFilter() : GlowFilter
      {
         var _loc2_:GlowFilterData = null;
         var _loc5_:String = "GlowEffect";
         var _loc3_:Row = row;
         if(!_loc3_._cache[_loc5_])
         {
            _loc3_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc5_);
         }
         var _loc1_:Field = _loc3_._cache[_loc5_];
         if(_loc1_)
         {
            var _loc4_:* = _loc1_;
            _loc2_ = new GlowFilterData(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value);
            return new GlowFilter(_loc2_.color,_loc2_.alpha,_loc2_.blurX,_loc2_.blurY,_loc2_.strength,_loc2_.quality,_loc2_.inner,_loc2_.knockout);
         }
         return null;
      }
   }
}

