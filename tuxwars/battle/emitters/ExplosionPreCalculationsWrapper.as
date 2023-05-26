package tuxwars.battle.emitters
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.Random;
   import flash.utils.Dictionary;
   import nape.geom.Vec2;
   import tuxwars.battle.data.explosions.ExplosionData;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.TerrainGameObject;
   import tuxwars.battle.gameobjects.TuxGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.items.references.EmissionExplosionReference;
   import tuxwars.items.references.EmissionReference;
   
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
      
      public static function initStaticPool(tuxWorld:TuxWorld, growthValue:int = 10, maxPoolSize:int = 50) : void
      {
         LocationWrapper.initStaticPool();
         _tuxWorld = tuxWorld;
         MAX_VALUE = maxPoolSize;
         GROWTH_VALUE = growthValue;
         counter = maxPoolSize;
         var i:uint = maxPoolSize;
         pool = new Vector.<ExplosionPreCalculationsWrapper>(MAX_VALUE);
         while(--i > -1)
         {
            pool[i] = new ExplosionPreCalculationsWrapper();
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
         var i:uint = GROWTH_VALUE;
         while(--i > -1)
         {
            pool.unshift(new ExplosionPreCalculationsWrapper());
         }
         counter = GROWTH_VALUE;
         return getExplosionPreCalculationsWrapper();
      }
      
      private static function disposeExplosionPreCalculationsWrapper(disposedExplosionPreCalculationsWrapper:ExplosionPreCalculationsWrapper) : void
      {
         pool[counter++] = disposedExplosionPreCalculationsWrapper;
      }
      
      public static function get(emissionObject:Emission) : ExplosionPreCalculationsWrapper
      {
         var _loc2_:ExplosionPreCalculationsWrapper = getExplosionPreCalculationsWrapper();
         _loc2_.init(emissionObject);
         return _loc2_;
      }
      
      public function get emissionObject() : Emission
      {
         return _emissionObject;
      }
      
      public function get locationPrecalculatedPoint() : Vec2
      {
         return _location;
      }
      
      public function get allExplosionEmissions() : Vector.<EmissionReference>
      {
         return _allExplosionEmissions;
      }
      
      public function getDamageAffectedObjects(emissionReferenceID:String) : Vector.<LocationWrapper>
      {
         return _damageLocationWrapper[emissionReferenceID];
      }
      
      public function getImpulseAffectedObjects(emissionReferenceID:String) : Vector.<LocationWrapper>
      {
         return _impulseLocationWrapper[emissionReferenceID];
      }
      
      public function getTerrainAffectedObjects(emissionReferenceID:String) : Vector.<LocationWrapper>
      {
         return _terrainLocationWrapper[emissionReferenceID];
      }
      
      public function dispose() : void
      {
         reset();
         disposeExplosionPreCalculationsWrapper(this);
      }
      
      private function reset() : void
      {
         if(_emissionObject)
         {
            LogUtils.log("Reset pre calculations for: " + _emissionObject.shortName,this,0,"Emission",false,false,false);
         }
         _emissionObject = null;
         for each(var er in _allExplosionEmissions)
         {
            er = null;
         }
         _allExplosionEmissions.splice(0,_allExplosionEmissions.length);
         for(var did in _damageLocationWrapper)
         {
            if(_damageLocationWrapper[did])
            {
               for each(var dlw in _damageLocationWrapper[did])
               {
                  dlw.dispose();
               }
               _damageLocationWrapper[did].splice(0,_damageLocationWrapper[did].length);
            }
            delete _damageLocationWrapper[did];
         }
         for(var iid in _impulseLocationWrapper)
         {
            if(_impulseLocationWrapper[iid])
            {
               for each(var ilw in _impulseLocationWrapper[iid])
               {
                  ilw.dispose();
               }
               _impulseLocationWrapper[iid].splice(0,_impulseLocationWrapper[iid].length);
            }
            delete _impulseLocationWrapper[iid];
         }
         for(var tid in _terrainLocationWrapper)
         {
            if(_terrainLocationWrapper[tid])
            {
               for each(var tlw in _terrainLocationWrapper[tid])
               {
                  tlw.dispose();
               }
               _terrainLocationWrapper[tid].splice(0,_terrainLocationWrapper[tid].length);
            }
            delete _terrainLocationWrapper[tid];
         }
      }
      
      public function init(emissionObject:Emission) : void
      {
         reset();
         _emissionObject = emissionObject;
         _location = emissionObject.emitLocation.copy();
         LogUtils.log("LocationPoint with direction " + _location,this,1,"Location",false,false,false);
         generateAffectedObjects(emissionObject);
      }
      
      private function generateAffectedObjects(emissionObject:Emission) : void
      {
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc20_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var includeWeapons:Boolean = false;
         var _loc4_:* = null;
         var _loc15_:* = null;
         var _loc3_:int = 0;
         var i:int = 0;
         var _loc14_:* = 0;
         var _loc9_:* = null;
         var _loc11_:* = null;
         for each(var addEmission in emissionObject.emissions)
         {
            if(addEmission.specialType == "ExplosionEmitter")
            {
               _allExplosionEmissions.push(addEmission);
            }
         }
         for each(var boosterEmission in emissionObject.getBoosterExplosionEmissions())
         {
            _allExplosionEmissions.push(boosterEmission);
         }
         if(_allExplosionEmissions.length > 0 && emissionObject.tagger)
         {
            _loc5_ = emissionObject.tagger.gameObject;
         }
         var _loc6_:PlayerGameObject = !!emissionObject.tagger ? emissionObject.tagger.gameObject as PlayerGameObject : null;
         var _loc18_:Object = emissionObject.getEmissionsParams("Params");
         for each(var emissionReference in _allExplosionEmissions)
         {
            _loc8_ = EmissionExplosionReference.get(emissionReference.specialEffect);
            if(!_loc8_)
            {
               LogUtils.log("Failed to get an emissio explosion reference!",this,1,"Emission",false);
            }
            else
            {
               _loc20_ = emissionReference.delay;
               _loc7_ = emissionObject.getEmissionData(emissionReference,"NumberOfTimesActivated");
               if(_loc7_ < emissionReference.number)
               {
                  _loc2_ = emissionReference.affectedObjects;
                  includeWeapons = false;
                  if(_loc2_)
                  {
                     for each(var affectObjectID in _loc2_)
                     {
                        if(TuxGameObject.WEAPON_LIST.indexOf(affectObjectID) != -1)
                        {
                           includeWeapons = true;
                           break;
                        }
                     }
                  }
                  _loc4_ = _loc8_.getExplosionData();
                  _loc15_ = EmitterUtils.getFiringDirection(emissionObject,emissionReference,random,_loc18_ != null && _loc18_.dir != null ? _loc18_.dir : null);
                  if(_loc15_.length != 0)
                  {
                     _loc15_.normalise();
                  }
                  _loc3_ = _loc20_ <= 0 ? emissionReference.number : 1;
                  for(i = 0; i < _loc3_; )
                  {
                     _loc14_ = _loc7_ == 0 ? i : _loc7_;
                     _loc9_ = EmitterUtils.getModifiedFiringDirection(_loc6_,emissionReference,null,_loc15_,_loc3_,_loc14_,random);
                     if(_loc9_)
                     {
                        _loc11_ = _location.copy();
                        EmitterUtils.offsetLocation(emissionReference,_loc9_,_loc14_,random,null,_loc11_);
                        findAffectedObjects(_loc4_,emissionReference,_loc11_,includeWeapons,_loc2_,_loc5_);
                     }
                     i++;
                  }
                  _loc15_.dispose();
               }
            }
         }
      }
      
      private function findAffectedObjects(explosionData:ExplosionData, emissionReference:EmissionReference, location:Vec2, includeWeapons:Boolean, affectedObjects:Array, taggerGameObject:PhysicsGameObject) : void
      {
         var radius:* = 0;
         var _loc15_:* = null;
         var _loc13_:Number = NaN;
         var _loc10_:int = 0;
         var _loc14_:* = undefined;
         var _loc17_:* = undefined;
         var _loc9_:Number = NaN;
         var _loc8_:* = undefined;
         if(explosionData.damageRadius > 0)
         {
            radius = explosionData.damageRadius;
            _loc15_ = emissionObject.findStat("DamageRadius");
            if(_loc15_ != null && _loc15_.getModifiers().length > 0)
            {
               _loc13_ = _loc15_.calculateValue();
               if(_loc13_ != 0)
               {
                  _loc10_ = radius * _loc13_;
                  LogUtils.log("Damage explosion radius: " + radius + " modified by: " + _loc15_.getFormattedCalculatedValue() + " new radius: " + _loc10_,null,0,"Emission",false,false,false);
                  radius = _loc10_;
               }
            }
            _loc14_ = _tuxWorld.getAffectedGameObjects(location,radius,includeWeapons);
            for each(var dpgo in _loc14_)
            {
               if(EmitterUtils.affectsObject(affectedObjects,taggerGameObject,dpgo))
               {
                  if(_damageLocationWrapper[emissionReference.id] == null)
                  {
                     _damageLocationWrapper[emissionReference.id] = new Vector.<LocationWrapper>();
                  }
                  _damageLocationWrapper[emissionReference.id].push(LocationWrapper.get(dpgo,radius,emissionReference));
               }
            }
         }
         if(explosionData.impulseRadius > 0)
         {
            _loc17_ = _tuxWorld.getAffectedGameObjects(location,explosionData.impulseRadius,includeWeapons);
            for each(var ipgo in _loc17_)
            {
               if(EmitterUtils.affectsObject(affectedObjects,taggerGameObject,ipgo))
               {
                  if(_impulseLocationWrapper[emissionReference.id] == null)
                  {
                     _impulseLocationWrapper[emissionReference.id] = new Vector.<LocationWrapper>();
                  }
                  _impulseLocationWrapper[emissionReference.id].push(LocationWrapper.get(ipgo,explosionData.impulseRadius,emissionReference));
               }
            }
         }
         if(explosionData.explosionShape.getMaxRadius() > 2)
         {
            _loc9_ = explosionData.explosionShape.getMaxRadius();
            _loc8_ = _tuxWorld.getAffectedGameObjects(location,_loc9_,false);
            for each(var tpgo in _loc8_)
            {
               if(tpgo is TerrainGameObject && EmitterUtils.affectsObject(affectedObjects,taggerGameObject,tpgo))
               {
                  if(_terrainLocationWrapper[emissionReference.id] == null)
                  {
                     _terrainLocationWrapper[emissionReference.id] = new Vector.<LocationWrapper>();
                  }
                  _terrainLocationWrapper[emissionReference.id].push(LocationWrapper.get(tpgo,_loc9_,emissionReference));
               }
            }
         }
      }
   }
}
