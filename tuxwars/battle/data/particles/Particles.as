package tuxwars.battle.data.particles
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.Table;
   import com.dchoc.utils.LogUtils;
   
   public class Particles
   {
      
      private static var particleFile:Object;
      
      private static const PARTICLES_CACHE:Object = {};
      
      private static var particlesTable:Table;
       
      
      public function Particles()
      {
         super();
         throw new Error("Particles is a static class!");
      }
      
      public static function getParticlesReference(name:String) : ParticleReference
      {
         var particleReference:* = null;
         if(!name)
         {
            return null;
         }
         if(PARTICLES_CACHE.hasOwnProperty(name))
         {
            return PARTICLES_CACHE[name];
         }
         if(particleFile)
         {
            if(particleFile.hasOwnProperty(name))
            {
               particleReference = new ParticleReference(particleFile[name]);
               PARTICLES_CACHE[name] = particleReference;
               return particleReference;
            }
            LogUtils.log("Particle with name: " + name + " not found",null,2,"LoadResource",false);
            return null;
         }
         return null;
      }
      
      public static function setParticleData(particleFileData:String) : void
      {
         var data:* = null;
         try
         {
            data = JSON.parse(particleFileData);
            particleFile = {};
            for each(var obj in data.particles)
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
