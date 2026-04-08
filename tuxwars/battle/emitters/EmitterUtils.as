package tuxwars.battle.emitters
{
   import com.citrusengine.physics.*;
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.utils.*;
   import nape.geom.*;
   import org.as3commons.lang.*;
   import tuxwars.battle.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.missiles.MissileDef;
   import tuxwars.items.references.EmissionReference;
   
   public class EmitterUtils
   {
      public function EmitterUtils()
      {
         super();
      }
      
      public static function getFiringDirection(param1:Emission, param2:EmissionReference, param3:Random, param4:Vec2 = null) : Vec2
      {
         var _loc12_:Config = null;
         var _loc13_:Config = null;
         var _loc5_:Vec2 = null;
         var _loc6_:FiringDirection = null;
         var _loc7_:Vec2 = null;
         var _loc8_:Vec2 = null;
         var _loc9_:Vec2 = null;
         var _loc10_:Vec2 = null;
         LogUtils.log("Determinating firing direction for emission: " + param1.shortName + " emission ref: " + param2.id + " dir: " + param4,"EmitterUtils",1,"Emitter",false,false,false);
         var _loc11_:int = param2.getDirectionAndOffsetBy(param3);
         if(param4 != null)
         {
            _loc5_ = Vec2.get(param4.x,param4.y);
            if(_loc11_ < 0)
            {
               _loc5_.x *= -1;
               _loc5_.y *= -1;
            }
            LogUtils.log("Returning firing direction for emission: " + param1.shortName + " emission ref: " + param2.id + " newDir: " + _loc5_,"EmitterUtils",1,"Emitter",false,false,false);
            return _loc5_;
         }
         if(param1 is FiringDirection)
         {
            _loc6_ = param1 as FiringDirection;
            if(param2.useHitDirection && Boolean(_loc6_.lastLinearDirection))
            {
               _loc7_ = _loc6_.lastLinearDirection.copy();
               if(!_loc7_)
               {
                  if(_loc6_.getBody())
                  {
                     _loc7_.x = _loc6_.linearVelocity.x;
                     _loc7_.y = _loc6_.linearVelocity.y;
                  }
                  else
                  {
                     _loc7_.x = 0;
                     _loc7_.y = 0;
                     LogUtils.log("Special case, setting lastLinearVelocity to " + _loc7_,"EmitterUtils",2,"Emission",false,false,false);
                  }
               }
               if(_loc11_ < 0)
               {
                  _loc5_ = _loc7_.copy();
                  _loc5_.x *= -1;
                  _loc5_.y *= -1;
               }
               else
               {
                  _loc5_ = _loc7_.copy();
               }
            }
            else if(_loc6_.lastContactLocations)
            {
               _loc8_ = _loc6_.lastBodyLocations;
               _loc9_ = _loc6_.lastContactLocations;
               if(_loc11_ < 0)
               {
                  _loc5_ = Vec2.get(_loc8_.x - _loc9_.x,_loc8_.y - _loc9_.y);
               }
               else
               {
                  _loc5_ = Vec2.get(_loc9_.x - _loc8_.x,_loc9_.y - _loc8_.y);
               }
            }
            else
            {
               _loc10_ = _loc6_.explosionDirection;
               if(!_loc10_)
               {
                  _loc12_ = Config;
                  _loc5_ = Config.VEC_UP.copy();
               }
               else if(_loc11_ < 0)
               {
                  _loc5_ = _loc10_.copy();
                  _loc5_.x *= -1;
                  _loc5_.y *= -1;
               }
               else
               {
                  _loc5_ = _loc10_.copy();
               }
            }
         }
         if(_loc5_ == null)
         {
            _loc13_ = Config;
            _loc5_ = Config.VEC_UP.copy();
         }
         LogUtils.log("Returning firing direction for emission: " + param1.shortName + " emission ref: " + param2.id + " newDir: " + _loc5_,"EmitterUtils",1,"Emitter",false,false,false);
         if(_loc5_.length != 0)
         {
            _loc5_.normalise();
         }
         return _loc5_;
      }
      
      public static function getModifiedFiringDirection(param1:PlayerGameObject, param2:EmissionReference, param3:Array, param4:Vec2, param5:int, param6:int, param7:Random) : Vec2
      {
         var _loc23_:* = undefined;
         var _loc24_:String = null;
         var _loc25_:* = undefined;
         var _loc8_:Stat = null;
         var _loc9_:Number = Number(NaN);
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:Number = Number(NaN);
         var _loc16_:Number = Number(NaN);
         var _loc17_:Number = Number(NaN);
         var _loc18_:Number = Number(NaN);
         var _loc19_:Number = Number(NaN);
         var _loc20_:int = param2.angleOne;
         var _loc21_:* = param2.angleTwo;
         var _loc22_:int = param2.spread;
         if(param3)
         {
            for each(_loc23_ in param3)
            {
               _loc20_ += _loc23_.angleOne;
               _loc21_ += _loc23_.angleTwo;
               _loc22_ += _loc23_.spread;
            }
         }
         if(param1)
         {
            _loc24_ = "ShotSpread";
            _loc25_ = param1;
            _loc8_ = !!_loc25_.stats ? _loc25_.stats.getStat(_loc24_) : null;
            if((_loc21_ > 0 || _loc20_ > 0) && _loc8_ != null)
            {
               _loc9_ = _loc8_.calculateValue();
               if(_loc9_ != 0)
               {
                  _loc10_ = _loc21_ * _loc9_;
                  LogUtils.log("Shot angle: " + _loc21_ + " modified by: " + _loc8_.getFormattedCalculatedValue() + " new angle: " + _loc10_,null,0,"DamageModify",false,false,true);
                  _loc20_ -= (_loc21_ - _loc10_) / 2;
                  _loc21_ = _loc10_;
               }
            }
         }
         if(_loc21_ > 0 || _loc20_ > 0)
         {
            _loc11_ = param4.x < 0 ? 1 : -1;
            _loc12_ = Number(MathUtils.radiansToDegrees(Math.atan2(param4.y,param4.x)));
            _loc13_ = _loc12_ + _loc20_ * _loc11_;
            if(_loc22_ > 0)
            {
               _loc16_ = _loc13_ - _loc21_ * _loc11_;
               _loc14_ = _loc13_ - _loc21_ / 2 * _loc11_;
               if(param5 % 2 == 0)
               {
                  _loc14_ += _loc22_ / 2;
               }
               if(param6 % 2 == 0)
               {
                  _loc14_ += _loc22_ * param6;
               }
               else
               {
                  _loc14_ -= _loc22_ * param6;
               }
            }
            else
            {
               if(param7 == BattleManager.getRandom())
               {
                  LogUtils.log("Call to random getModifiedFiringDirection()","EmitterUtils",0,"Random",false,false,false);
               }
               _loc17_ = param7.float(0,_loc21_) * _loc11_;
               _loc14_ = _loc13_ - _loc17_;
            }
            _loc15_ = Number(MathUtils.degreesToRadians(_loc14_));
            _loc18_ = Math.sin(_loc15_);
            _loc19_ = Math.cos(_loc15_);
            return Vec2.get(_loc19_,_loc18_);
         }
         if(param4.length != 0)
         {
            param4.normalise();
         }
         return param4.copy();
      }
      
      public static function offsetLocation(param1:EmissionReference, param2:Vec2, param3:int, param4:Random, param5:MissileDef = null, param6:Vec2 = null) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Vec2 = null;
         var _loc11_:int = Math.abs(param1.getDirectionAndOffsetBy(param4));
         if(Math.abs(_loc11_) >= 0)
         {
            if(param2.length != 0)
            {
               param2.normalise();
            }
            if(param1.number > 0)
            {
               if(param1.angleOne == 0 && param1.angleTwo == 0)
               {
                  _loc11_ *= param3 + 1;
               }
               else if(param1.spread > 0)
               {
                  _loc7_ = param1.angleTwo / param1.spread;
                  if(_loc7_ < param1.number)
                  {
                     _loc8_ = param1.number / _loc7_;
                     _loc9_ = _loc8_ * (param3 / param1.number);
                     _loc11_ *= _loc9_ + 1;
                  }
               }
            }
            param2.muleq(_loc11_);
            switch(param1.specialType)
            {
               case "MissileEmitter":
                  _loc10_ = param5.position.copy();
                  param5.position.x += param2.x;
                  param5.position.y += param2.y;
                  break;
               case "ExplosionEmitter":
                  param6.x += param2.x;
                  param6.y += param2.y;
                  break;
               default:
                  LogUtils.log("No SpecialType: " + param1.specialType + " for emitters that use offsetLocation","EmitterUtils",2,"Emitter",true,true,true);
            }
            if(param2.length != 0)
            {
               param2.normalise();
            }
         }
      }
      
      public static function affectsObject(param1:Array, param2:PhysicsGameObject, param3:PhysicsGameObject) : Boolean
      {
         var _loc4_:* = undefined;
         if(param3 != null)
         {
            for each(_loc4_ in param1)
            {
               if(param3.affectsGameObject(_loc4_,param2))
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
      
      public static function getBitsFor(param1:Array) : int
      {
         return PhysicsCollisionCategories.GetArray(convertToCategoryNames(param1));
      }
      
      public static function getMissileMaskBits() : int
      {
         return PhysicsCollisionCategories.GetAllExcept("MISSILE");
      }
      
      private static function convertToCategoryNames(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            switch(_loc3_)
            {
               case "all":
                  return PhysicsGameObject.GROUP_ALL;
               case "penguin":
               case "player":
               case "enemy":
                  _loc2_.push("PENGUIN");
                  break;
               case "object":
               case "levelobject":
                  _loc2_.push("LEVEL_OBJECT");
                  break;
               case "powerup":
                  _loc2_.push("POWER_UP");
                  break;
               case "terrain":
               case "stone":
               case "ice":
               case "metal":
               case "wood":
                  _loc2_.push("TERRAIN");
                  break;
               case "weapon":
               case "missile":
               case "mine":
               case "grenade":
                  _loc2_.push("MISSILE");
                  break;
               case "water":
                  _loc2_.push("WATER");
                  break;
               case "follower":
                  _loc2_.push("FOLLOWER");
                  break;
               case "none":
                  break;
               default:
                  LogUtils.log("AffectsType: " + _loc3_ + " not included in switch case for masking of bits!","EmitterUtils",2,"AffectsGameObject",true,true,true);
                  break;
            }
         }
         return _loc2_;
      }
      
      public static function handleBoosters(param1:Emission, param2:Emission, param3:PlayerGameObject) : void
      {
         var _loc4_:Stat = null;
         if(Boolean(param2) && Boolean(param1))
         {
            param1.playerBoosterStats = param2.playerBoosterStats;
         }
         if(Boolean(param3) && param1 is StatsInterface)
         {
            _loc4_ = param3.findPlayerBoosterStat("DamageRadius");
            if(_loc4_)
            {
               (param1 as StatsInterface).stats.addStat("DamageRadius",_loc4_,null);
            }
         }
      }
      
      public static function convertDirection(param1:Vec2) : Vec2
      {
         var _loc2_:Vec2 = param1.copy();
         if(_loc2_.length != 0)
         {
            _loc2_.normalise();
         }
         var _loc3_:Vec2 = Vec2.get();
         if(param1.length > 0.05)
         {
            if(_loc2_.x > 0.4)
            {
               _loc3_.x = Config.VEC_RIGHT.x;
               _loc3_.y = Config.VEC_RIGHT.y;
            }
            else if(_loc2_.x < -0.4)
            {
               _loc3_.x = Config.VEC_LEFT.x;
               _loc3_.y = Config.VEC_LEFT.y;
            }
            else if(_loc2_.y > 0.4)
            {
               _loc3_.x = Config.VEC_UP.x;
               _loc3_.y = Config.VEC_UP.y;
            }
            else if(_loc2_.y < -0.4)
            {
               _loc3_.x = Config.VEC_DOWN.x;
               _loc3_.y = Config.VEC_DOWN.y;
            }
         }
         _loc2_.dispose();
         return _loc3_;
      }
      
      public static function getPowerLevel(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:int = 0;
         if(param3 >= 0)
         {
            _loc4_ = Math.max(0,param1 - param2);
            _loc5_ = _loc4_ * param3 / 100;
            _loc6_ = param2 + _loc5_;
            LogUtils.log("Firing at " + param3 + "% with an impulse force of " + _loc6_,"EmitterUtils",0,"Emission",false,false,false);
            return _loc6_;
         }
         return param2;
      }
      
      public static function copyParams(param1:Emission, param2:Emission, param3:Vec2 = null) : void
      {
         var _loc4_:Object = null;
         var _loc5_:Object = !!param1.getEmissionsParams("Params") ? param1.getEmissionsParams("Params") : null;
         if(_loc5_)
         {
            _loc4_ = ObjectUtils.clone(_loc5_);
            if(param3)
            {
               _loc4_["dir"] = param3.copy();
            }
            else if(_loc5_["dir"] != null)
            {
               _loc4_["dir"] = _loc5_["dir"].copy();
            }
            param2.setEmissionsParams("Params",_loc4_);
         }
         param2.setEmissionsParams("RepeatCount",param1.getEmissionsParams("RepeatCount"));
      }
   }
}

