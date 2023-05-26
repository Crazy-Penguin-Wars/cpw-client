package tuxwars.items.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
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
         var _loc1_:Row = row;
         if(!_loc1_._cache["Emitters"])
         {
            _loc1_._cache["Emitters"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Emitters");
         }
         field = _loc1_._cache["Emitters"];
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
         var _loc5_:* = null;
         var _loc3_:* = null;
         var i:int = 0;
         var _loc6_:Row = row;
         if(!_loc6_._cache["EmitMissileBoosting"])
         {
            _loc6_._cache["EmitMissileBoosting"] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name","EmitMissileBoosting");
         }
         var _loc1_:Field = _loc6_._cache["EmitMissileBoosting"];
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
         var _loc4_:* = null;
         var _loc2_:* = null;
         var i:int = 0;
         var _loc6_:Row = row;
         if(!_loc6_._cache["EmitterExplosionBoosting"])
         {
            _loc6_._cache["EmitterExplosionBoosting"] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name","EmitterExplosionBoosting");
         }
         var _loc1_:Field = _loc6_._cache["EmitterExplosionBoosting"];
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
         var _loc2_:Row = row;
         if(!_loc2_._cache["DurationType"])
         {
            _loc2_._cache["DurationType"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","DurationType");
         }
         var _loc1_:Field = _loc2_._cache["DurationType"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get durationAmount() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["DurationAmount"])
         {
            _loc2_._cache["DurationAmount"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","DurationAmount");
         }
         var _loc1_:Field = _loc2_._cache["DurationAmount"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get simpleScript() : Array
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["SimpleScript"])
         {
            _loc2_._cache["SimpleScript"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","SimpleScript");
         }
         var _loc1_:Field = _loc2_._cache["SimpleScript"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, SimpleScriptManager.parseSimpleScriptFromOdsData(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get glowFilter() : GlowFilter
      {
         var _loc2_:* = null;
         var _loc3_:Row = row;
         if(!_loc3_._cache["GlowEffect"])
         {
            _loc3_._cache["GlowEffect"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","GlowEffect");
         }
         var _loc1_:Field = _loc3_._cache["GlowEffect"];
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
