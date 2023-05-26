package tuxwars.battle.data.particles
{
   import com.dchoc.projectdata.Row;
   
   public class ThemeParticleData
   {
      
      private static const ID:String = "ID";
      
      private static const PARTICLE_NAMES:String = "ParticleNames";
      
      private static const HARDNESS:String = "Hardness";
      
      private static const ACTIVATION_DELAY:String = "ActivationDelay";
       
      
      private var _particles:Array;
      
      private var _hardness:int;
      
      private var _activationDelay:int;
      
      public function ThemeParticleData(row:Row)
      {
         super();
         var _loc2_:* = row;
         if(!_loc2_._cache["Hardness"])
         {
            _loc2_._cache["Hardness"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Hardness");
         }
         var _loc3_:* = _loc2_._cache["Hardness"];
         _hardness = _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         var _loc4_:* = row;
         if(!_loc4_._cache["ActivationDelay"])
         {
            _loc4_._cache["ActivationDelay"] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name","ActivationDelay");
         }
         var _loc5_:* = _loc4_._cache["ActivationDelay"];
         _activationDelay = _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value;
         var _loc6_:* = row;
         if(!_loc6_._cache["ParticleNames"])
         {
            _loc6_._cache["ParticleNames"] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name","ParticleNames");
         }
         var _loc7_:* = _loc6_._cache["ParticleNames"];
         if((_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) is Array)
         {
            var _loc8_:* = row;
            if(!_loc8_._cache["ParticleNames"])
            {
               _loc8_._cache["ParticleNames"] = com.dchoc.utils.DCUtils.find(_loc8_._fields,"name","ParticleNames");
            }
            var _loc9_:* = _loc8_._cache["ParticleNames"];
            §§push(_loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value);
         }
         else
         {
            var _loc10_:* = row;
            if(!_loc10_._cache["ParticleNames"])
            {
               _loc10_._cache["ParticleNames"] = com.dchoc.utils.DCUtils.find(_loc10_._fields,"name","ParticleNames");
            }
            var _loc11_:* = _loc10_._cache["ParticleNames"];
            §§push([_loc11_.overrideValue != null ? _loc11_.overrideValue : _loc11_._value]);
         }
         _particles = §§pop();
      }
      
      public function get particles() : Array
      {
         return _particles;
      }
      
      public function get hardness() : int
      {
         return _hardness;
      }
      
      public function get activationDelay() : int
      {
         return _activationDelay;
      }
   }
}
