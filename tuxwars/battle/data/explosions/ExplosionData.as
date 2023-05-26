package tuxwars.battle.data.explosions
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.StatTypes;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import tuxwars.battle.data.particles.ParticleReference;
   import tuxwars.battle.data.particles.Particles;
   import tuxwars.battle.data.stats.StatReference;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.data.TuxGameData;
   import tuxwars.items.references.EmissionReference;
   
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
      
      public function ExplosionData(row:Row)
      {
         super(row);
      }
      
      public function get attack() : Stat
      {
         var value:* = undefined;
         var statReference:* = null;
         var _loc1_:Field = getField("Attack");
         if(_loc1_)
         {
            var _loc4_:* = _loc1_;
            value = _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
            value = value is Array ? value : [value];
            statReference = new StatReference(row.id,value as Array,StatTypes.getStatGroupByType("Weapon"));
            return statReference.getStat();
         }
         return new Stat(row.id,0,"","",false);
      }
      
      public function get explosionShape() : ExplosionShapeReference
      {
         var _loc1_:* = null;
         if(!_explosionShapeReference)
         {
            _loc1_ = getField("ExplosionShape");
            var _loc2_:*;
            _explosionShapeReference = _loc1_ != null ? (_loc2_ = _loc1_, new ExplosionShapeReference(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value)) : null;
         }
         return _explosionShapeReference;
      }
      
      public function get damageRadius() : int
      {
         var _loc1_:Field = getField("DamageRadius");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get impulseRadius() : int
      {
         var _loc1_:Field = getField("ImpulseRadius");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get impulse() : int
      {
         var _loc1_:Field = getField("Impulse");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get particleEffect() : ParticleReference
      {
         var _loc1_:Field = getField("ParticleEffect");
         var _loc2_:*;
         return Particles.getParticlesReference(_loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null);
      }
      
      public function get simpleScript() : Array
      {
         var _loc1_:Field = getField("SimpleScript");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, SimpleScriptManager.parseSimpleScriptFromOdsData(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value)) : null;
      }
      
      public function get simpleScriptEveryTarget() : Boolean
      {
         var _loc1_:Field = getField("SimpleScriptEveryTarget");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : false;
      }
      
      public function get shakeEffectTime() : int
      {
         var _loc1_:Field = getField("ShakeEffectTime");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get shakeEffectStrength() : Number
      {
         var _loc1_:Field = getField("ShakeEffectStrength");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get flash() : Boolean
      {
         var _loc1_:Field = getField("Flash");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : false;
      }
      
      public function getEmissions() : Array
      {
         var field:Field;
         var emissions:*;
         var emissionsArray:Array;
         if(!_emissions)
         {
            field = getField("Emitters");
            if(field == null)
            {
               return null;
            }
            var _loc2_:Field = field;
            emissions = _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
            emissionsArray = emissions is Array ? emissions as Array : [emissions];
            emissionsArray.sort(function(row1:Row, row2:Row):int
            {
               return row1.id.localeCompare(row2.id);
            });
            _emissions = EmissionReference.getEmissionReferences(emissionsArray);
         }
         return _emissions;
      }
   }
}
