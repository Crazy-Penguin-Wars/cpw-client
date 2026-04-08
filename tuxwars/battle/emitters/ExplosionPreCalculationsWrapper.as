package tuxwars.battle.emitters
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.utils.*;
   import flash.utils.*;
   import nape.geom.Vec2;
   import tuxwars.battle.data.explosions.ExplosionData;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.items.references.*;
   
   public class ExplosionPreCalculationsWrapper
   {
      private static var _tuxWorld:TuxWorld;
      
      private static var MAX_VALUE:uint;
      
      private static var GROWTH_VALUE:uint;
      
      private static var counter:uint;
      
      private static var pool:Vector.<ExplosionPreCalculationsWrapper>;
      
      private static var currentSprite:ExplosionPreCalculationsWrapper;
      
      private var _emissionObject:Emission;
      
      private var _location:Vec2;
      
      private const _allExplosionEmissions:Vector.<EmissionReference> = new Vector.<EmissionReference>();
      
      private const _damageLocationWrapper:Dictionary = new Dictionary();
      
      private const _impulseLocationWrapper:Dictionary = new Dictionary();
      
      private const _terrainLocationWrapper:Dictionary = new Dictionary();
      
      private const random:Random = new Random();
      
      public function ExplosionPreCalculationsWrapper()
      {
         super();
      }
      
      public static function initStaticPool(param1:TuxWorld, param2:int = 10, param3:int = 50) : void
      {
         LocationWrapper.initStaticPool();
         _tuxWorld = param1;
         MAX_VALUE = param3;
         GROWTH_VALUE = param2;
         counter = param3;
         var _loc4_:uint = uint(param3);
         pool = new Vector.<ExplosionPreCalculationsWrapper>(MAX_VALUE);
         while(--_loc4_ > -1)
         {
            pool[_loc4_] = new ExplosionPreCalculationsWrapper();
         }
      }
      
      public static function disposeWorld() : void
      {
         _tuxWorld = null;
      }
      
      private static function getExplosionPreCalculationsWrapper() : ExplosionPreCalculationsWrapper
      {
         if(counter > 0)
         {
            return currentSprite = pool[--counter];
         }
         var _loc1_:uint = uint(GROWTH_VALUE);
         while(--_loc1_ > -1)
         {
            pool.unshift(new ExplosionPreCalculationsWrapper());
         }
         counter = GROWTH_VALUE;
         return getExplosionPreCalculationsWrapper();
      }
      
      private static function disposeExplosionPreCalculationsWrapper(param1:ExplosionPreCalculationsWrapper) : void
      {
         var _loc2_:* = counter++;
         pool[_loc2_] = param1;
      }
      
      public static function get(param1:Emission) : ExplosionPreCalculationsWrapper
      {
         var _loc2_:ExplosionPreCalculationsWrapper = getExplosionPreCalculationsWrapper();
         _loc2_.init(param1);
         return _loc2_;
      }
      
      public function get emissionObject() : Emission
      {
         return this._emissionObject;
      }
      
      public function get locationPrecalculatedPoint() : Vec2
      {
         return this._location;
      }
      
      public function get allExplosionEmissions() : Vector.<EmissionReference>
      {
         return this._allExplosionEmissions;
      }
      
      public function getDamageAffectedObjects(param1:String) : Vector.<LocationWrapper>
      {
         return this._damageLocationWrapper[param1];
      }
      
      public function getImpulseAffectedObjects(param1:String) : Vector.<LocationWrapper>
      {
         return this._impulseLocationWrapper[param1];
      }
      
      public function getTerrainAffectedObjects(param1:String) : Vector.<LocationWrapper>
      {
         return this._terrainLocationWrapper[param1];
      }
      
      public function dispose() : void
      {
         this.reset();
         disposeExplosionPreCalculationsWrapper(this);
      }
      
      private function reset() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         if(this._emissionObject)
         {
            LogUtils.log("Reset pre calculations for: " + this._emissionObject.shortName,this,0,"Emission",false,false,false);
         }
         this._emissionObject = null;
         for each(_loc1_ in this._allExplosionEmissions)
         {
            _loc1_ = null;
         }
         this._allExplosionEmissions.splice(0,this._allExplosionEmissions.length);
         for(_loc2_ in this._damageLocationWrapper)
         {
            if(this._damageLocationWrapper[_loc2_])
            {
               for each(_loc5_ in this._damageLocationWrapper[_loc2_])
               {
                  _loc5_.dispose();
               }
               this._damageLocationWrapper[_loc2_].splice(0,this._damageLocationWrapper[_loc2_].length);
            }
            delete this._damageLocationWrapper[_loc2_];
         }
         for(_loc3_ in this._impulseLocationWrapper)
         {
            if(this._impulseLocationWrapper[_loc3_])
            {
               for each(_loc6_ in this._impulseLocationWrapper[_loc3_])
               {
                  _loc6_.dispose();
               }
               this._impulseLocationWrapper[_loc3_].splice(0,this._impulseLocationWrapper[_loc3_].length);
            }
            delete this._impulseLocationWrapper[_loc3_];
         }
         for(_loc4_ in this._terrainLocationWrapper)
         {
            if(this._terrainLocationWrapper[_loc4_])
            {
               for each(_loc7_ in this._terrainLocationWrapper[_loc4_])
               {
                  _loc7_.dispose();
               }
               this._terrainLocationWrapper[_loc4_].splice(0,this._terrainLocationWrapper[_loc4_].length);
            }
            delete this._terrainLocationWrapper[_loc4_];
         }
      }
      
      public function init(param1:Emission) : void
      {
         this.reset();
         this._emissionObject = param1;
         this._location = param1.emitLocation.copy();
         LogUtils.log("LocationPoint with direction " + this._location,this,1,"Location",false,false,false);
         this.generateAffectedObjects(param1);
      }
      
      private function generateAffectedObjects(param1:Emission) : void
      {
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc19_:* = undefined;
         var _loc20_:* = undefined;
         var _loc2_:PhysicsGameObject = null;
         var _loc3_:EmissionExplosionReference = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:Boolean = false;
         var _loc8_:ExplosionData = null;
         var _loc9_:Vec2 = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = 0;
         var _loc13_:Vec2 = null;
         var _loc14_:Vec2 = null;
         for each(_loc15_ in param1.emissions)
         {
            if(_loc15_.specialType == "ExplosionEmitter")
            {
               this._allExplosionEmissions.push(_loc15_);
            }
         }
         for each(_loc16_ in param1.getBoosterExplosionEmissions())
         {
            this._allExplosionEmissions.push(_loc16_);
         }
         if(this._allExplosionEmissions.length > 0 && Boolean(param1.tagger))
         {
            _loc2_ = param1.tagger.gameObject;
         }
         var _loc17_:PlayerGameObject = !!param1.tagger ? param1.tagger.gameObject as PlayerGameObject : null;
         var _loc18_:Object = param1.getEmissionsParams("Params");
         for each(_loc19_ in this._allExplosionEmissions)
         {
            _loc3_ = EmissionExplosionReference.get(_loc19_.specialEffect);
            if(!_loc3_)
            {
               LogUtils.log("Failed to get an emissio explosion reference!",this,1,"Emission",false);
            }
            else
            {
               _loc4_ = int(_loc19_.delay);
               _loc5_ = int(param1.getEmissionData(_loc19_,"NumberOfTimesActivated"));
               if(_loc5_ < _loc19_.number)
               {
                  _loc6_ = _loc19_.affectedObjects;
                  _loc7_ = false;
                  if(_loc6_)
                  {
                     for each(_loc20_ in _loc6_)
                     {
                        if(TuxGameObject.WEAPON_LIST.indexOf(_loc20_) != -1)
                        {
                           _loc7_ = true;
                           break;
                        }
                     }
                  }
                  _loc8_ = _loc3_.getExplosionData();
                  _loc9_ = EmitterUtils.getFiringDirection(param1,_loc19_,this.random,_loc18_ != null && _loc18_.dir != null ? _loc18_.dir : null);
                  if(_loc9_.length != 0)
                  {
                     _loc9_.normalise();
                  }
                  _loc10_ = _loc4_ <= 0 ? int(_loc19_.number) : 1;
                  _loc11_ = 0;
                  while(_loc11_ < _loc10_)
                  {
                     _loc12_ = _loc5_ == 0 ? _loc11_ : _loc5_;
                     _loc13_ = EmitterUtils.getModifiedFiringDirection(_loc17_,_loc19_,null,_loc9_,_loc10_,_loc12_,this.random);
                     if(_loc13_)
                     {
                        _loc14_ = this._location.copy();
                        EmitterUtils.offsetLocation(_loc19_,_loc13_,_loc12_,this.random,null,_loc14_);
                        this.findAffectedObjects(_loc8_,_loc19_,_loc14_,_loc7_,_loc6_,_loc2_);
                     }
                     _loc11_++;
                  }
                  _loc9_.dispose();
               }
            }
         }
      }
      
      private function findAffectedObjects(param1:ExplosionData, param2:EmissionReference, param3:Vec2, param4:Boolean, param5:Array, param6:PhysicsGameObject) : void
      {
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc7_:* = 0;
         var _loc8_:Stat = null;
         var _loc9_:Number = Number(NaN);
         var _loc10_:int = 0;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:Number = Number(NaN);
         var _loc14_:* = undefined;
         if(param1.damageRadius > 0)
         {
            _loc7_ = param1.damageRadius;
            _loc8_ = this.emissionObject.findStat("DamageRadius");
            if(_loc8_ != null && _loc8_.getModifiers().length > 0)
            {
               _loc9_ = _loc8_.calculateValue();
               if(_loc9_ != 0)
               {
                  _loc10_ = _loc7_ * _loc9_;
                  LogUtils.log("Damage explosion radius: " + _loc7_ + " modified by: " + _loc8_.getFormattedCalculatedValue() + " new radius: " + _loc10_,null,0,"Emission",false,false,false);
                  _loc7_ = _loc10_;
               }
            }
            _loc11_ = _tuxWorld.getAffectedGameObjects(param3,_loc7_,param4);
            for each(_loc15_ in _loc11_)
            {
               if(EmitterUtils.affectsObject(param5,param6,_loc15_))
               {
                  if(this._damageLocationWrapper[param2.id] == null)
                  {
                     this._damageLocationWrapper[param2.id] = new Vector.<LocationWrapper>();
                  }
                  this._damageLocationWrapper[param2.id].push(LocationWrapper.get(_loc15_,_loc7_,param2));
               }
            }
         }
         if(param1.impulseRadius > 0)
         {
            _loc12_ = _tuxWorld.getAffectedGameObjects(param3,param1.impulseRadius,param4);
            for each(_loc16_ in _loc12_)
            {
               if(EmitterUtils.affectsObject(param5,param6,_loc16_))
               {
                  if(this._impulseLocationWrapper[param2.id] == null)
                  {
                     this._impulseLocationWrapper[param2.id] = new Vector.<LocationWrapper>();
                  }
                  this._impulseLocationWrapper[param2.id].push(LocationWrapper.get(_loc16_,param1.impulseRadius,param2));
               }
            }
         }
         if(param1.explosionShape.getMaxRadius() > 2)
         {
            _loc13_ = param1.explosionShape.getMaxRadius();
            _loc14_ = _tuxWorld.getAffectedGameObjects(param3,_loc13_,false);
            for each(_loc17_ in _loc14_)
            {
               if(_loc17_ is TerrainGameObject && Boolean(EmitterUtils.affectsObject(param5,param6,_loc17_)))
               {
                  if(this._terrainLocationWrapper[param2.id] == null)
                  {
                     this._terrainLocationWrapper[param2.id] = new Vector.<LocationWrapper>();
                  }
                  this._terrainLocationWrapper[param2.id].push(LocationWrapper.get(_loc17_,_loc13_,param2));
               }
            }
         }
      }
   }
}

