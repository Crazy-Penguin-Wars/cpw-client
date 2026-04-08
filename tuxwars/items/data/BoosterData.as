package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import flash.filters.*;
   import org.as3commons.lang.*;
   import tuxwars.battle.simplescript.*;
   import tuxwars.items.references.*;
   
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
      
      public function BoosterData(param1:Row)
      {
         super(param1);
      }
      
      public function get emissions() : Array
      {
         var field:Field = null;
         var localEmissions:* = undefined;
         var emissionArray:Array = null;
         var _loc3_:Field = null;
         var _loc4_:String = "Emitters";
         var _loc1_:Row = row;
         if(!_loc1_.getCache[_loc4_])
         {
            _loc1_.getCache[_loc4_] = DCUtils.find(_loc1_.getFields(),"name",_loc4_);
         }
         field = _loc1_.getCache[_loc4_];
         if(field)
         {
            _loc3_ = field;
            localEmissions = _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
            emissionArray = localEmissions is Array ? localEmissions : [localEmissions];
            emissionArray.sort(function(param1:Row, param2:Row):int
            {
               return StringUtils.compareTo(param1.id,param2.id);
            });
            return EmissionReference.getEmissionReferences(emissionArray);
         }
         return null;
      }
      
      public function get missileBoostingEmissions() : Array
      {
         var _loc8_:* = undefined;
         var _loc1_:* = undefined;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:String = "EmitMissileBoosting";
         var _loc6_:Row = row;
         if(!_loc6_.getCache[_loc5_])
         {
            _loc6_.getCache[_loc5_] = DCUtils.find(_loc6_.getFields(),"name",_loc5_);
         }
         var _loc7_:Field = _loc6_.getCache[_loc5_];
         if(_loc7_)
         {
            _loc8_ = _loc7_;
            _loc1_ = _loc8_.overrideValue != null ? _loc8_.overrideValue : _loc8_._value;
            _loc2_ = _loc1_ is Array ? _loc1_ : [_loc1_];
            _loc3_ = [];
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc3_.push(EmissionReference.get(_loc2_[_loc4_]));
               _loc4_++;
            }
            return _loc3_;
         }
         return null;
      }
      
      public function get explosionBoostingEmissions() : Array
      {
         var _loc8_:* = undefined;
         var _loc1_:* = undefined;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:String = "EmitterExplosionBoosting";
         var _loc6_:Row = row;
         if(!_loc6_.getCache[_loc5_])
         {
            _loc6_.getCache[_loc5_] = DCUtils.find(_loc6_.getFields(),"name",_loc5_);
         }
         var _loc7_:Field = _loc6_.getCache[_loc5_];
         if(_loc7_)
         {
            _loc8_ = _loc7_;
            _loc1_ = _loc8_.overrideValue != null ? _loc8_.overrideValue : _loc8_._value;
            _loc2_ = _loc1_ is Array ? _loc1_ : [_loc1_];
            _loc3_ = [];
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc3_.push(EmissionReference.get(_loc2_[_loc4_]));
               _loc4_++;
            }
            return _loc3_;
         }
         return null;
      }
      
      public function get durationType() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "DurationType";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get durationAmount() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "DurationAmount";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get simpleScript() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "SimpleScript";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, SimpleScriptManager.parseSimpleScriptFromOdsData(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
      
      public function get glowFilter() : GlowFilter
      {
         var _loc5_:* = undefined;
         var _loc1_:GlowFilterData = null;
         var _loc2_:String = "GlowEffect";
         var _loc3_:Row = row;
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         var _loc4_:Field = _loc3_.getCache[_loc2_];
         if(_loc4_)
         {
            _loc5_ = _loc4_;
            _loc1_ = new GlowFilterData(_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value);
            return new GlowFilter(_loc1_.color,_loc1_.alpha,_loc1_.blurX,_loc1_.blurY,_loc1_.strength,_loc1_.quality,_loc1_.inner,_loc1_.knockout);
         }
         return null;
      }
   }
}

