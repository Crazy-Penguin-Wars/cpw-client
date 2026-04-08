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
      
      public function ShakeEffect(param1:int, param2:Number, param3:TuxWorld)
      {
         super();
         this.shakeTotalTime = param1;
         this.shakeTimer = param1;
         this.shakeIntervalTotalTime = param1 >> 5;
         this.shakeIntervalTimer = 0;
         this.shakeStrength = param2;
         this.world = param3;
         var _loc4_:* = param3;
         this.shakeStartX = _loc4_._camera.worldX;
         var _loc5_:* = param3;
         this.shakeStartY = _loc5_._camera.worldY;
      }
      
      public function dispose() : void
      {
         this.world = null;
      }
      
      public function logicUpdate(param1:int) : Boolean
      {
         var _loc2_:TuxWorld = null;
         var _loc3_:TuxWorld = null;
         var _loc4_:TuxWorld = null;
         var _loc5_:TuxWorld = null;
         var _loc6_:TuxWorld = null;
         if(this.shakeTimer > 0)
         {
            _loc2_ = this.world;
            if(!_loc2_._camera)
            {
               return true;
            }
            if(false && this.shakeIntervalTimer <= 0 || true)
            {
               this.shakeStrength *= this.shakeTimer / this.shakeTotalTime;
               _loc3_ = this.world;
               _loc3_._camera.worldX = this.shakeStartX + (Math.random() * this.shakeStrength - (this.shakeStrength >> 1));
               _loc4_ = this.world;
               _loc4_._camera.worldY = this.shakeStartY + (Math.random() * this.shakeStrength - (this.shakeStrength >> 1));
               this.shakeIntervalTimer = this.shakeIntervalTotalTime;
            }
            this.shakeIntervalTimer -= param1;
            this.shakeTimer -= param1;
            if(this.shakeTimer <= 0)
            {
               _loc5_ = this.world;
               _loc5_._camera.worldX = this.shakeStartX;
               _loc6_ = this.world;
               _loc6_._camera.worldY = this.shakeStartY;
               return true;
            }
         }
         return false;
      }
   }
}

