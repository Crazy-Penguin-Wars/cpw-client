package tuxwars.battle.emitters
{
   import com.citrusengine.physics.PhysicsCollisionCategories;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.StatsInterface;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.MathUtils;
   import com.dchoc.utils.Random;
   import nape.geom.Vec2;
   import org.as3commons.lang.ObjectUtils;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.missiles.MissileDef;
   import tuxwars.items.references.EmissionReference;
   
   public class EmitterUtils
   {
       
      
      public function EmitterUtils()
      {
         super();
      }
      
      public static function getFiringDirection(emissionObject:Emission, emissionReference:EmissionReference, random:Random, dir:Vec2 = null) : Vec2
      {
         var newDir:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc7_:* = null;
         LogUtils.log("Determinating firing direction for emission: " + emissionObject.shortName + " emission ref: " + emissionReference.id + " dir: " + dir,"EmitterUtils",1,"Emitter",false,false,false);
         var _loc8_:int = emissionReference.getDirectionAndOffsetBy(random);
         if(dir != null)
         {
            newDir = Vec2.get(dir.x,dir.y);
            if(_loc8_ < 0)
            {
               newDir.x *= -1;
               newDir.y *= -1;
            }
            LogUtils.log("Returning firing direction for emission: " + emissionObject.shortName + " emission ref: " + emissionReference.id + " newDir: " + newDir,"EmitterUtils",1,"Emitter",false,false,false);
            return newDir;
         }
         if(emissionObject is FiringDirection)
         {
            _loc10_ = emissionObject as FiringDirection;
            if(emissionReference.useHitDirection && _loc10_.lastLinearDirection)
            {
               _loc11_ = _loc10_.lastLinearDirection.copy();
               if(!_loc11_)
               {
                  if(_loc10_.getBody())
                  {
                     _loc11_.x = _loc10_.linearVelocity.x;
                     _loc11_.y = _loc10_.linearVelocity.y;
                  }
                  else
                  {
                     _loc11_.x = 0;
                     _loc11_.y = 0;
                     LogUtils.log("Special case, setting lastLinearVelocity to " + _loc11_,"EmitterUtils",2,"Emission",false,false,false);
                  }
               }
               if(_loc8_ < 0)
               {
                  newDir = _loc11_.copy();
                  newDir.x *= -1;
                  newDir.y *= -1;
               }
               else
               {
                  newDir = _loc11_.copy();
               }
            }
            else if(_loc10_.lastContactLocations)
            {
               _loc6_ = _loc10_.lastBodyLocations;
               _loc9_ = _loc10_.lastContactLocations;
               if(_loc8_ < 0)
               {
                  newDir = Vec2.get(_loc6_.x - _loc9_.x,_loc6_.y - _loc9_.y);
               }
               else
               {
                  newDir = Vec2.get(_loc9_.x - _loc6_.x,_loc9_.y - _loc6_.y);
               }
            }
            else
            {
               _loc7_ = _loc10_.explosionDirection;
               if(!_loc7_)
               {
                  var _loc12_:Config = Config;
                  newDir = Config.VEC_UP.copy();
               }
               else if(_loc8_ < 0)
               {
                  newDir = _loc7_.copy();
                  newDir.x *= -1;
                  newDir.y *= -1;
               }
               else
               {
                  newDir = _loc7_.copy();
               }
            }
         }
         if(newDir == null)
         {
            var _loc13_:Config = Config;
            newDir = Config.VEC_UP.copy();
         }
         LogUtils.log("Returning firing direction for emission: " + emissionObject.shortName + " emission ref: " + emissionReference.id + " newDir: " + newDir,"EmitterUtils",1,"Emitter",false,false,false);
         if(newDir.length != 0)
         {
            newDir.normalise();
         }
         return newDir;
      }
      
      public static function getModifiedFiringDirection(firingPlayer:PlayerGameObject, emissionReference:EmissionReference, boosterMissileEmitsArray:Array, originalDir:Vec2, count:int, loopCount:int, random:Random) : Vec2
      {
         var _loc22_:* = null;
         var _loc9_:Number = NaN;
         var _loc12_:int = 0;
         var _loc11_:int = 0;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var newFiringAngle:Number = NaN;
         var newFiringAngleInRadians:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc19_:Number = NaN;
         var angleToLimitingAngleOneInDegrees:int = emissionReference.angleOne;
         var angleBetweneLimitingAnglesInDegrees:* = emissionReference.angleTwo;
         var spreadInDegrees:int = emissionReference.spread;
         if(boosterMissileEmitsArray)
         {
            for each(var er in boosterMissileEmitsArray)
            {
               angleToLimitingAngleOneInDegrees += er.angleOne;
               angleBetweneLimitingAnglesInDegrees += er.angleTwo;
               spreadInDegrees += er.spread;
            }
         }
         if(firingPlayer)
         {
            var _loc26_:* = firingPlayer;
            _loc22_ = !!_loc26_.stats ? _loc26_.stats.getStat("ShotSpread") : null;
            if((angleBetweneLimitingAnglesInDegrees > 0 || angleToLimitingAngleOneInDegrees > 0) && _loc22_ != null)
            {
               _loc9_ = _loc22_.calculateValue();
               if(_loc9_ != 0)
               {
                  _loc12_ = angleBetweneLimitingAnglesInDegrees * _loc9_;
                  LogUtils.log("Shot angle: " + angleBetweneLimitingAnglesInDegrees + " modified by: " + _loc22_.getFormattedCalculatedValue() + " new angle: " + _loc12_,null,0,"DamageModify",false,false,true);
                  angleToLimitingAngleOneInDegrees -= (angleBetweneLimitingAnglesInDegrees - _loc12_) / 2;
                  angleBetweneLimitingAnglesInDegrees = _loc12_;
               }
            }
         }
         if(angleBetweneLimitingAnglesInDegrees > 0 || angleToLimitingAngleOneInDegrees > 0)
         {
            _loc11_ = originalDir.x < 0 ? 1 : -1;
            _loc17_ = MathUtils.radiansToDegrees(Math.atan2(originalDir.y,originalDir.x));
            _loc18_ = _loc17_ + angleToLimitingAngleOneInDegrees * _loc11_;
            if(spreadInDegrees > 0)
            {
               _loc16_ = _loc18_ - angleBetweneLimitingAnglesInDegrees * _loc11_;
               newFiringAngle = _loc18_ - angleBetweneLimitingAnglesInDegrees / 2 * _loc11_;
               if(count % 2 == 0)
               {
                  newFiringAngle += spreadInDegrees / 2;
               }
               if(loopCount % 2 == 0)
               {
                  newFiringAngle += spreadInDegrees * loopCount;
               }
               else
               {
                  newFiringAngle -= spreadInDegrees * loopCount;
               }
            }
            else
            {
               if(random == BattleManager.getRandom())
               {
                  LogUtils.log("Call to random getModifiedFiringDirection()","EmitterUtils",0,"Random",false,false,false);
               }
               _loc15_ = random.float(0,angleBetweneLimitingAnglesInDegrees) * _loc11_;
               newFiringAngle = _loc18_ - _loc15_;
            }
            newFiringAngleInRadians = MathUtils.degreesToRadians(newFiringAngle);
            _loc21_ = Math.sin(newFiringAngleInRadians);
            _loc19_ = Math.cos(newFiringAngleInRadians);
            return Vec2.get(_loc19_,_loc21_);
         }
         if(originalDir.length != 0)
         {
            originalDir.normalise();
         }
         return originalDir.copy();
      }
      
      public static function offsetLocation(emissionReference:EmissionReference, finalDir:Vec2, loopCount:int, random:Random, missileDef:MissileDef = null, locationPoint:Vec2 = null) : void
      {
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var offsetBy:int = Math.abs(emissionReference.getDirectionAndOffsetBy(random));
         if(Math.abs(offsetBy) >= 0)
         {
            if(finalDir.length != 0)
            {
               finalDir.normalise();
            }
            if(emissionReference.number > 0)
            {
               if(emissionReference.angleOne == 0 && emissionReference.angleTwo == 0)
               {
                  offsetBy *= loopCount + 1;
               }
               else if(emissionReference.spread > 0)
               {
                  _loc10_ = emissionReference.angleTwo / emissionReference.spread;
                  if(_loc10_ < emissionReference.number)
                  {
                     _loc11_ = emissionReference.number / _loc10_;
                     _loc9_ = _loc11_ * (loopCount / emissionReference.number);
                     offsetBy *= _loc9_ + 1;
                  }
               }
            }
            finalDir.muleq(offsetBy);
            switch(emissionReference.specialType)
            {
               case "MissileEmitter":
                  _loc7_ = missileDef.position.copy();
                  missileDef.position.x += finalDir.x;
                  missileDef.position.y += finalDir.y;
                  break;
               case "ExplosionEmitter":
                  locationPoint.x += finalDir.x;
                  locationPoint.y += finalDir.y;
                  break;
               default:
                  LogUtils.log("No SpecialType: " + emissionReference.specialType + " for emitters that use offsetLocation","EmitterUtils",2,"Emitter",true,true,true);
            }
            if(finalDir.length != 0)
            {
               finalDir.normalise();
            }
         }
      }
      
      public static function affectsObject(targetsArray:Array, taggerGameObject:PhysicsGameObject, affectedGameObject:PhysicsGameObject) : Boolean
      {
         if(affectedGameObject != null)
         {
            for each(var name in targetsArray)
            {
               if(affectedGameObject.affectsGameObject(name,taggerGameObject))
               {
                  return true;
               }
            }
         }
         else
         {
            LogUtils.log("affectedGameObject is null, figure out where this comes from (example in one case this was water)","EmitterUtils",2,"Emitter",false);
         }
         return false;
      }
      
      public static function getBitsFor(affectedObjects:Array) : int
      {
         return PhysicsCollisionCategories.GetArray(convertToCategoryNames(affectedObjects));
      }
      
      public static function getMissileMaskBits() : int
      {
         return PhysicsCollisionCategories.GetAllExcept("MISSILE");
      }
      
      private static function convertToCategoryNames(affectedObjects:Array) : Array
      {
         var _loc2_:Array = [];
         for each(var affects in affectedObjects)
         {
            switch(affects)
            {
               case "all":
                  return PhysicsGameObject.GROUP_ALL;
               case "penguin":
               case "player":
               case "enemy":
                  _loc2_.push("PENGUIN");
                  continue;
               case "object":
               case "levelobject":
                  _loc2_.push("LEVEL_OBJECT");
                  continue;
               case "powerup":
                  _loc2_.push("POWER_UP");
                  continue;
               case "terrain":
               case "stone":
               case "ice":
               case "metal":
                  break;
               case "wood":
                  break;
               case "weapon":
               case "missile":
               case "mine":
               case "grenade":
                  _loc2_.push("MISSILE");
                  continue;
               case "water":
                  _loc2_.push("WATER");
                  continue;
               case "follower":
                  _loc2_.push("FOLLOWER");
                  continue;
               case "none":
                  continue;
               default:
                  LogUtils.log("AffectsType: " + affects + " not included in switch case for masking of bits!","EmitterUtils",2,"AffectsGameObject",true,true,true);
                  continue;
            }
            _loc2_.push("TERRAIN");
         }
         return _loc2_;
      }
      
      public static function handleBoosters(emission:Emission, otherEmission:Emission, firingPlayer:PlayerGameObject) : void
      {
         var _loc4_:* = null;
         if(otherEmission && emission)
         {
            emission.playerBoosterStats = otherEmission.playerBoosterStats;
         }
         if(firingPlayer && emission is StatsInterface)
         {
            _loc4_ = firingPlayer.findPlayerBoosterStat("DamageRadius");
            if(_loc4_)
            {
               (emission as StatsInterface).stats.addStat("DamageRadius",_loc4_,null);
            }
         }
      }
      
      public static function convertDirection(direction:Vec2) : Vec2
      {
         var _loc3_:Vec2 = direction.copy();
         if(_loc3_.length != 0)
         {
            _loc3_.normalise();
         }
         var _loc2_:Vec2 = Vec2.get();
         if(direction.length > 0.05)
         {
            if(_loc3_.x > 0.4)
            {
               _loc2_.x = Config.VEC_RIGHT.x;
               _loc2_.y = Config.VEC_RIGHT.y;
            }
            else if(_loc3_.x < -0.4)
            {
               _loc2_.x = Config.VEC_LEFT.x;
               _loc2_.y = Config.VEC_LEFT.y;
            }
            else if(_loc3_.y > 0.4)
            {
               _loc2_.x = Config.VEC_UP.x;
               _loc2_.y = Config.VEC_UP.y;
            }
            else if(_loc3_.y < -0.4)
            {
               _loc2_.x = Config.VEC_DOWN.x;
               _loc2_.y = Config.VEC_DOWN.y;
            }
         }
         _loc3_.dispose();
         return _loc2_;
      }
      
      public static function getPowerLevel(firingImpulseMax:int, firingImpulseMin:int, powerBar:int) : int
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc4_:int = 0;
         if(powerBar >= 0)
         {
            _loc5_ = Math.max(0,firingImpulseMax - firingImpulseMin);
            _loc6_ = _loc5_ * powerBar / 100;
            _loc4_ = firingImpulseMin + _loc6_;
            LogUtils.log("Firing at " + powerBar + "% with an impulse force of " + _loc4_,"EmitterUtils",0,"Emission",false,false,false);
            return _loc4_;
         }
         return firingImpulseMin;
      }
      
      public static function copyParams(emission:Emission, otherEmission:Emission, newDirection:Vec2 = null) : void
      {
         var _loc4_:* = null;
         var _loc5_:Object = !!emission.getEmissionsParams("Params") ? emission.getEmissionsParams("Params") : null;
         if(_loc5_)
         {
            _loc4_ = ObjectUtils.clone(_loc5_);
            if(newDirection)
            {
               _loc4_["dir"] = newDirection.copy();
            }
            else if(_loc5_["dir"] != null)
            {
               _loc4_["dir"] = _loc5_["dir"].copy();
            }
            otherEmission.setEmissionsParams("Params",_loc4_);
         }
         otherEmission.setEmissionsParams("RepeatCount",emission.getEmissionsParams("RepeatCount"));
      }
   }
}
