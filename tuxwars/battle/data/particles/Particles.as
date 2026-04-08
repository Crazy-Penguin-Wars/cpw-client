package tuxwars.battle.data.particles
{
   import com.dchoc.events.*;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.Table;
   import com.dchoc.utils.*;
   
   public class Particles
   {
      private static var particleFile:Object;
      
      private static var particlesTable:Table;
      
      private static const PARTICLES_CACHE:Object = {};
      
      public function Particles()
      {
         super();
         throw new Error("Particles is a static class!");
      }
      
      public static function getParticlesReference(param1:String) : ParticleReference
      {
         var _loc2_:ParticleReference = null;
         if(!param1)
         {
            return null;
         }
         if(PARTICLES_CACHE.hasOwnProperty(param1))
         {
            return PARTICLES_CACHE[param1];
         }
         if(particleFile)
         {
            if(particleFile.hasOwnProperty(param1))
            {
               _loc2_ = new ParticleReference(particleFile[param1]);
               PARTICLES_CACHE[param1] = _loc2_;
               return _loc2_;
            }
            LogUtils.log("Particle with name: " + param1 + " not found",null,2,"LoadResource",false);
            return null;
         }
         return null;
      }
      
      public static function setParticleData(param1:String) : void
      {
         var obj:* = undefined;
         var particleFileData:String = param1;
         var data:Object = null;
         try
         {
            data = JSON.parse(particleFileData);
            particleFile = {};
            for each(obj in data.particles)
            {
               particleFile[obj.id] = obj;
            }
         }
         catch(e:Error)
         {
            MessageCenter.sendEvent(new ErrorMessage("Particle Loading Error","setParticleData",e.message.toString(),null,e));
         }
      }
   }
}

