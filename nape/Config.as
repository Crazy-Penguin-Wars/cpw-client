package nape
{
   public final class Config
   {
      
      public static var epsilon:Number = 1e-8;
      
      public static var fluidAngularDragFriction:Number = 2.5;
      
      public static var fluidAngularDrag:Number = 100;
      
      public static var fluidVacuumDrag:Number = 0.5;
      
      public static var fluidLinearDrag:Number = 0.5;
      
      public static var collisionSlop:Number = 0.2;
      
      public static var collisionSlopCCD:Number = 0.5;
      
      public static var distanceThresholdCCD:Number = 0.05;
      
      public static var staticCCDLinearThreshold:Number = 0.05;
      
      public static var staticCCDAngularThreshold:Number = 0.005;
      
      public static var bulletCCDLinearThreshold:Number = 0.125;
      
      public static var bulletCCDAngularThreshold:Number = 0.0125;
      
      public static var dynamicSweepLinearThreshold:Number = 17;
      
      public static var dynamicSweepAngularThreshold:Number = 0.6;
      
      public static var angularCCDSlipScale:Number = 0.75;
      
      public static var arbiterExpirationDelay:int = 6;
      
      public static var staticFrictionThreshold:Number = 2;
      
      public static var elasticThreshold:Number = 20;
      
      public static var sleepDelay:int = 60;
      
      public static var linearSleepThreshold:Number = 0.2;
      
      public static var angularSleepThreshold:Number = 0.4;
      
      public static var contactBiasCoef:Number = 0.3;
      
      public static var contactStaticBiasCoef:Number = 0.6;
      
      public static var contactContinuousBiasCoef:Number = 0.4;
      
      public static var contactContinuousStaticBiasCoef:Number = 0.5;
      
      public static var constraintLinearSlop:Number = 0.1;
      
      public static var constraintAngularSlop:Number = 0.001;
      
      public static var illConditionedThreshold:Number = 200000000;
       
      
      public function Config()
      {
      }
   }
}
