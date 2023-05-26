package tuxwars.battle.emitters
{
   import nape.geom.Vec2;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.items.references.EmissionReference;
   
   public class LocationWrapper
   {
      
      private static var MAX_VALUE:uint;
      
      private static var GROWTH_VALUE:uint;
      
      private static var counter:uint;
      
      private static var pool:Vector.<LocationWrapper>;
      
      private static var currentSprite:LocationWrapper;
       
      
      private var _emissionReference:EmissionReference;
      
      private var _physicsGameObject:PhysicsGameObject;
      
      private var _locationVec2:Vec2;
      
      private var _radiusInPhysicsScale:Number;
      
      public function LocationWrapper()
      {
         super();
      }
      
      public static function initStaticPool(growthValue:int = 10, maxPoolSize:int = 50) : void
      {
         MAX_VALUE = maxPoolSize;
         GROWTH_VALUE = growthValue;
         counter = maxPoolSize;
         var i:uint = maxPoolSize;
         pool = new Vector.<LocationWrapper>(MAX_VALUE);
         while(--i > -1)
         {
            pool[i] = new LocationWrapper();
         }
      }
      
      private static function getLocationWrapper() : LocationWrapper
      {
         if(counter > 0)
         {
            return currentSprite = pool[--counter];
         }
         var i:uint = GROWTH_VALUE;
         while(--i > -1)
         {
            pool.unshift(new LocationWrapper());
         }
         counter = GROWTH_VALUE;
         return getLocationWrapper();
      }
      
      private static function disposeLocationWrapper(disposedLocationWrapper:LocationWrapper) : void
      {
         pool[counter++] = disposedLocationWrapper;
      }
      
      public static function get(physicsGameObject:PhysicsGameObject, radiusInPhysicsScale:Number, emissionReference:EmissionReference) : LocationWrapper
      {
         var _loc4_:LocationWrapper = getLocationWrapper();
         _loc4_.init(physicsGameObject,radiusInPhysicsScale,emissionReference);
         return _loc4_;
      }
      
      public function init(physicsGameObject:PhysicsGameObject, radiusInPhysicsScale:Number, emissionReference:EmissionReference) : void
      {
         _emissionReference = emissionReference;
         _physicsGameObject = physicsGameObject;
         _locationVec2 = physicsGameObject.bodyLocation.copy();
         _radiusInPhysicsScale = radiusInPhysicsScale;
      }
      
      public function dispose() : void
      {
         _emissionReference = null;
         _physicsGameObject = null;
         _locationVec2 = null;
         _radiusInPhysicsScale = 0;
         disposeLocationWrapper(this);
      }
      
      public function get physicsGameObject() : PhysicsGameObject
      {
         return _physicsGameObject;
      }
      
      public function get locationVec2() : Vec2
      {
         return _locationVec2;
      }
      
      public function get radiusInPhysicsScale() : Number
      {
         return _radiusInPhysicsScale;
      }
      
      public function get emissionReference() : EmissionReference
      {
         return _emissionReference;
      }
   }
}
