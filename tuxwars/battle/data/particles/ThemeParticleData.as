package tuxwars.battle.data.particles
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class ThemeParticleData
   {
      private static const ID:String = "ID";
      
      private static const PARTICLE_NAMES:String = "ParticleNames";
      
      private static const HARDNESS:String = "Hardness";
      
      private static const ACTIVATION_DELAY:String = "ActivationDelay";
      
      private var _particles:Array;
      
      private var _hardness:int;
      
      private var _activationDelay:int;
      
      public function ThemeParticleData(param1:Row)
      {
         super();
         if(!param1.getCache[HARDNESS])
         {
            param1.getCache[HARDNESS] = DCUtils.find(param1.getFields(),"name",HARDNESS);
         }
         this._hardness = param1.getCache[HARDNESS].overrideValue != null ? int(param1.getCache[HARDNESS].overrideValue) : int(param1.getCache[HARDNESS]._value);
         if(!param1.getCache[ACTIVATION_DELAY])
         {
            param1.getCache[ACTIVATION_DELAY] = DCUtils.find(param1.getFields(),"name",ACTIVATION_DELAY);
         }
         this._activationDelay = param1.getCache[ACTIVATION_DELAY].overrideValue != null ? int(param1.getCache[ACTIVATION_DELAY].overrideValue) : int(param1.getCache[ACTIVATION_DELAY]._value);
         if(!param1.getCache[PARTICLE_NAMES])
         {
            param1.getCache[PARTICLE_NAMES] = DCUtils.find(param1.getFields(),"name",PARTICLE_NAMES);
         }
         var _loc2_:Field = param1.getCache[PARTICLE_NAMES];
         var _loc3_:* = _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
         this._particles = _loc3_ is Array ? _loc3_ as Array : [_loc3_];
      }
      
      public function get particles() : Array
      {
         return this._particles;
      }
      
      public function get hardness() : int
      {
         return this._hardness;
      }
      
      public function get activationDelay() : int
      {
         return this._activationDelay;
      }
   }
}

