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
      
      public static function initStaticPool(param1:int = 10, param2:int = 50) : void
      {
         MAX_VALUE = param2;
         GROWTH_VALUE = param1;
         counter = param2;
         var _loc3_:uint = uint(param2);
         pool = new Vector.<LocationWrapper>(MAX_VALUE);
         while(--_loc3_ > -1)
         {
            pool[_loc3_] = new LocationWrapper();
         }
      }
      
      private static function getLocationWrapper() : LocationWrapper
      {
         if(counter > 0)
         {
            return currentSprite = pool[--counter];
         }
         var _loc1_:uint = uint(GROWTH_VALUE);
         while(--_loc1_ > -1)
         {
            pool.unshift(new LocationWrapper());
         }
         counter = GROWTH_VALUE;
         return getLocationWrapper();
      }
      
      private static function disposeLocationWrapper(param1:LocationWrapper) : void
      {
         var _loc2_:* = counter++;
         pool[_loc2_] = param1;
      }
      
      public static function get(param1:PhysicsGameObject, param2:Number, param3:EmissionReference) : LocationWrapper
      {
         var _loc4_:LocationWrapper = getLocationWrapper();
         _loc4_.init(param1,param2,param3);
         return _loc4_;
      }
      
      public function init(param1:PhysicsGameObject, param2:Number, param3:EmissionReference) : void
      {
         this._emissionReference = param3;
         this._physicsGameObject = param1;
         this._locationVec2 = param1.bodyLocation.copy();
         this._radiusInPhysicsScale = param2;
      }
      
      public function dispose() : void
      {
         this._emissionReference = null;
         this._physicsGameObject = null;
         this._locationVec2 = null;
         this._radiusInPhysicsScale = 0;
         disposeLocationWrapper(this);
      }
      
      public function get physicsGameObject() : PhysicsGameObject
      {
         return this._physicsGameObject;
      }
      
      public function get locationVec2() : Vec2
      {
         return this._locationVec2;
      }
      
      public function get radiusInPhysicsScale() : Number
      {
         return this._radiusInPhysicsScale;
      }
      
      public function get emissionReference() : EmissionReference
      {
         return this._emissionReference;
      }
   }
}

