package tuxwars.battle.effects
{
   import tuxwars.battle.world.TuxWorld;
   
   public class ShakeEffect
   {
      
      private static const USE_INTERVAL:Boolean = false;
      
      private static const USE_DECAY:Boolean = true;
       
      
      private var shakeTotalTime:int;
      
      private var shakeTimer:int;
      
      private var shakeIntervalTotalTime:int;
      
      private var shakeIntervalTimer:int;
      
      private var shakeStrength:Number;
      
      private var shakeStartX:Number;
      
      private var shakeStartY:Number;
      
      private var world:TuxWorld;
      
      public function ShakeEffect(time:int, strength:Number, world:TuxWorld)
      {
         super();
         shakeTotalTime = time;
         shakeTimer = time;
         shakeIntervalTotalTime = time >> 5;
         shakeIntervalTimer = 0;
         shakeStrength = strength;
         this.world = world;
         var _loc4_:* = world;
         shakeStartX = _loc4_._camera.worldX;
         var _loc5_:* = world;
         shakeStartY = _loc5_._camera.worldY;
      }
      
      public function dispose() : void
      {
         world = null;
      }
      
      public function logicUpdate(dt:int) : Boolean
      {
         if(shakeTimer > 0)
         {
            var _loc2_:TuxWorld = world;
            if(!_loc2_._camera)
            {
               return true;
            }
            shakeStrength *= shakeTimer / shakeTotalTime;
            var _loc3_:TuxWorld = world;
            _loc3_._camera.worldX = shakeStartX + (Math.random() * shakeStrength - (shakeStrength >> 1));
            var _loc4_:TuxWorld = world;
            _loc4_._camera.worldY = shakeStartY + (Math.random() * shakeStrength - (shakeStrength >> 1));
            shakeIntervalTimer = shakeIntervalTotalTime;
            shakeIntervalTimer -= dt;
            shakeTimer -= dt;
            if(shakeTimer <= 0)
            {
               var _loc5_:TuxWorld = world;
               _loc5_._camera.worldX = shakeStartX;
               var _loc6_:TuxWorld = world;
               _loc6_._camera.worldY = shakeStartY;
               return true;
            }
         }
         return false;
      }
   }
}
