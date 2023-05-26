package tuxwars.battle.emitters
{
   import com.dchoc.utils.LogUtils;
   
   public class Emitters
   {
       
      
      public function Emitters()
      {
         super();
         throw new Error("Emitters is a static class!");
      }
      
      public static function addListeners() : void
      {
         MissileEmitter.addListeners();
         var _loc1_:ExplosionEmitter = ExplosionEmitter;
         if(!tuxwars.battle.emitters.ExplosionEmitter._instance)
         {
            tuxwars.battle.emitters.ExplosionEmitter._instance = new tuxwars.battle.emitters.ExplosionEmitter();
         }
         tuxwars.battle.emitters.ExplosionEmitter._instance.addListeners();
         AnimationEmitter.addListeners();
      }
      
      public static function removeListeners() : void
      {
         MissileEmitter.removeListeners();
         var _loc1_:ExplosionEmitter = ExplosionEmitter;
         if(!tuxwars.battle.emitters.ExplosionEmitter._instance)
         {
            tuxwars.battle.emitters.ExplosionEmitter._instance = new tuxwars.battle.emitters.ExplosionEmitter();
         }
         tuxwars.battle.emitters.ExplosionEmitter._instance.removeListeners();
         AnimationEmitter.removeListeners();
      }
      
      public static function dispose() : void
      {
         LogUtils.log("Disposing emitters!",Emitters,0,"Emitter",false,false,false);
         removeListeners();
         var _loc1_:ExplosionEmitter = ExplosionEmitter;
         if(!tuxwars.battle.emitters.ExplosionEmitter._instance)
         {
            tuxwars.battle.emitters.ExplosionEmitter._instance = new tuxwars.battle.emitters.ExplosionEmitter();
         }
         tuxwars.battle.emitters.ExplosionEmitter._instance.dispose();
      }
   }
}
