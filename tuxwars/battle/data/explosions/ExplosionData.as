package tuxwars.battle.data.explosions
{
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import tuxwars.battle.data.particles.*;
   import tuxwars.battle.data.stats.*;
   import tuxwars.battle.simplescript.*;
   import tuxwars.data.TuxGameData;
   import tuxwars.items.references.*;
   
   public class ExplosionData extends TuxGameData
   {
      private static const ATTACK:String = "Attack";
      
      private static const EXPLOSION_SHAPE:String = "ExplosionShape";
      
      private static const DAMAGE_RADIUS:String = "DamageRadius";
      
      private static const IMPULSE_RADIUS:String = "ImpulseRadius";
      
      private static const IMPULSE:String = "Impulse";
      
      private static const PARTICLE_EFFECT:String = "ParticleEffect";
      
      private static const EMISSIONS:String = "Emitters";
      
      private static const SIMPLE_SCRIPT:String = "SimpleScript";
      
      private static const SIMPLE_SCRIPT_EVERY_TARGET:String = "SimpleScriptEveryTarget";
      
      private static const SHAKE_TIME:String = "ShakeEffectTime";
      
      private static const SHAKE_STRENGTH:String = "ShakeEffectStrength";
      
      private static const FLASH:String = "Flash";
      
      private var _explosionShapeReference:ExplosionShapeReference;
      
      private var _emissions:Array;
      
      public function ExplosionData(param1:Row)
      {
         super(param1);
      }
      
      public function get attack() : Stat
      {
         var _loc4_:* = undefined;
         var _loc1_:* = undefined;
         var _loc2_:StatReference = null;
         var _loc3_:Field = getField("Attack");
         if(_loc3_)
         {
            _loc4_ = _loc3_;
            _loc1_ = _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
            _loc1_ = _loc1_ is Array ? _loc1_ : [_loc1_];
            _loc2_ = new StatReference(row.id,_loc1_ as Array,StatTypes.getStatGroupByType("Weapon"));
            return _loc2_.getStat();
         }
         return new Stat(row.id,0,"","",false);
      }
      
      public function get explosionShape() : ExplosionShapeReference
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = null;
         if(!this._explosionShapeReference)
         {
            _loc1_ = getField("ExplosionShape");
            this._explosionShapeReference = _loc1_ != null ? (_loc2_ = _loc1_, new ExplosionShapeReference(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value)) : null;
         }
         return this._explosionShapeReference;
      }
      
      public function get damageRadius() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("DamageRadius");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get impulseRadius() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("ImpulseRadius");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get impulse() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("Impulse");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get particleEffect() : ParticleReference
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("ParticleEffect");
         return Particles.getParticlesReference(_loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null);
      }
      
      public function get simpleScript() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("SimpleScript");
         return !!_loc1_ ? (_loc2_ = _loc1_, SimpleScriptManager.parseSimpleScriptFromOdsData(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value)) : null;
      }
      
      public function get simpleScriptEveryTarget() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("SimpleScriptEveryTarget");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Boolean(_loc2_.overrideValue) : Boolean(_loc2_._value)) : false;
      }
      
      public function get shakeEffectTime() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("ShakeEffectTime");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get shakeEffectStrength() : Number
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("ShakeEffectStrength");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Number(_loc2_.overrideValue) : Number(_loc2_._value)) : 0;
      }
      
      public function get flash() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("Flash");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Boolean(_loc2_.overrideValue) : Boolean(_loc2_._value)) : false;
      }
      
      public function getEmissions() : Array
      {
         var field:Field = null;
         var emissions:* = undefined;
         var emissionsArray:Array = null;
         var _loc2_:Field = null;
         if(!this._emissions)
         {
            field = getField("Emitters");
            if(field == null)
            {
               return null;
            }
            _loc2_ = field;
            emissions = _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
            emissionsArray = emissions is Array ? emissions as Array : [emissions];
            emissionsArray.sort(function(param1:Row, param2:Row):int
            {
               return param1.id.localeCompare(param2.id);
            });
            this._emissions = EmissionReference.getEmissionReferences(emissionsArray);
         }
         return this._emissions;
      }
   }
}

