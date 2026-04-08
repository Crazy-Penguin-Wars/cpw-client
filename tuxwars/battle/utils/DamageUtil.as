package tuxwars.battle.utils
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import nape.shape.*;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.data.*;
   
   public class DamageUtil
   {
      public function DamageUtil()
      {
         super();
      }
      
      public static function damageRecieved(param1:Stat, param2:Emission, param3:PhysicsGameObject, param4:Number, param5:Vec2, param6:Vec2) : int
      {
         var _loc7_:Stat = null;
         var _loc8_:Number = Number(getAttackValue(param1,param2,param3));
         var _loc9_:String = "Defence";
         var _loc10_:* = param3;
         var _loc11_:Number = Number((!!_loc10_.stats ? _loc10_.stats.getStat(_loc9_) : null).calculateValue());
         if(param3 is PlayerGameObject)
         {
            _loc7_ = PlayerGameObject(param3).findPlayerBoosterStat("Defence");
            if(_loc7_)
            {
               _loc11_ += _loc7_.calculateValue();
            }
         }
         var _loc12_:Number = _loc8_ - _loc8_ / 50 * (23 * (_loc11_ / (_loc11_ + 50)));
         var _loc13_:Number = scaleValueAccordingToDistance(param4,Math.ceil(_loc12_),param5,param6,param3,param2,"damage");
         var _loc14_:Number = Math.round(_loc13_);
         LogUtils.log("Damage: " + Math.ceil(_loc12_) + " (orig dmg: " + _loc12_ + " def: " + _loc11_ + "), scaled damage: " + _loc13_ + " returned damage: " + _loc14_ + ", defender:" + param3.shortName + ", attacker:" + param2.shortName,"DamageUtil",1,"DamageCalculation",false,false,false);
         return _loc14_;
      }
      
      private static function getAttackValue(param1:Stat, param2:Emission, param3:PhysicsGameObject) : Number
      {
         var _loc4_:Stat = null;
         var _loc5_:Stat = null;
         var _loc6_:Stat = null;
         var _loc7_:Stat = null;
         if(Boolean(param2) && Boolean(param2.playerBoosterStats))
         {
            if(param2.playerBoosterStats.hasStat("Damage"))
            {
               _loc4_ = param2.playerBoosterStats.getStat("Damage");
               LogUtils.log("Adding booster damage stat: " + _loc4_ + " to weapon stat: " + param1,DamageUtil,0,"DamageCalculation",false,false,false);
               _loc6_ = param1.combine(_loc4_,true);
            }
            if(param2.playerBoosterStats.hasStat("Attack"))
            {
               _loc5_ = param2.playerBoosterStats.getStat("Attack");
               LogUtils.log("Adding booster attack stat: " + _loc4_ + " to attack stat: " + param2.playerAttackValueStat,DamageUtil,0,"DamageCalculation",false,false,false);
               _loc7_ = param2.playerAttackValueStat.combine(_loc5_,true);
            }
         }
         var _loc8_:Number = _loc6_ != null ? _loc6_.calculateValue() : param1.calculateValue();
         var _loc9_:Number = _loc7_ != null ? _loc7_.calculateValue(param3,(param2 != null ? param2.tagger : null) != null ? param2.tagger.gameObject : null) : Number(param2.playerAttackValueStat.calculateValue(param3,(param2 != null ? param2.tagger : null) != null ? param2.tagger.gameObject : null));
         var _loc10_:Number = _loc8_ + _loc8_ / 135 * (125 * (_loc9_ / (_loc9_ + 100)));
         LogUtils.log("Attack value: " + _loc10_ + " (weap: " + _loc8_ + " stat: " + _loc9_ + "), attacker: " + param2.shortName,"DamageUtil",0,"DamageCalculation",false,false,false);
         return _loc10_;
      }
      
      public static function scaleValueAccordingToDistance(param1:Number, param2:Number, param3:Vec2, param4:Vec2, param5:PhysicsGameObject, param6:Emission, param7:String) : Number
      {
         var _loc8_:ShapeList = null;
         var _loc9_:int = 0;
         var _loc10_:Shape = null;
         var _loc11_:Number = Number(NaN);
         var _loc12_:Number = Number(getMinPercentage(param5,param7));
         var _loc13_:Vec2 = param3.sub(param4);
         var _loc14_:Number = _loc13_.length;
         if(Boolean(param5) && Boolean(param5.body))
         {
            if(param5.body.shapes.length <= 0)
            {
               return 0;
            }
            _loc8_ = param5.body.shapes;
            _loc9_ = 0;
            while(_loc9_ < _loc8_.length)
            {
               _loc10_ = _loc8_.at(_loc9_);
               if(_loc10_.isCircle() && _loc10_.material.density != 0 && !_loc10_.sensorEnabled)
               {
                  _loc14_ -= Circle(_loc10_).radius;
                  _loc14_ = Math.max(_loc14_,0);
                  break;
               }
               _loc9_++;
            }
         }
         if(_loc14_ >= param1 * (100 - _loc12_) / 100)
         {
            _loc11_ = param2 * _loc12_ / 100;
         }
         else
         {
            _loc11_ = param2 * ((param1 - _loc14_) / param1);
         }
         LogUtils.log("Attacker:" + param6.shortName + " location: " + param3 + " defender:" + param5.shortName + " location: " + param4 + " and distance: " + _loc14_ + " compared to radius: " + param1,"DamageUtil",1,"DamageCalculation",false,false,false);
         return _loc11_;
      }
      
      private static function getMinPercentage(param1:PhysicsGameObject, param2:String) : Number
      {
         switch(param2)
         {
            case "damage":
               return getDamageMinPercentage(param1);
            case "impulse":
               return getImpulseMinPercentage(param1);
            default:
               LogUtils.log("Unknown scaling value min percentage get type: " + param2 + " please configure","DamageUtils",0,"DamageCalculation",false,false,false);
               return getDamageMinPercentage(param1);
         }
      }
      
      private static function getImpulseMinPercentage(param1:PhysicsGameObject) : Number
      {
         if(param1 is PlayerGameObject)
         {
            return Tuner.getField("ImpulseMinScalingPlayer").value;
         }
         return Tuner.getField("ImpulseMinScalingOther").value;
      }
      
      private static function getDamageMinPercentage(param1:PhysicsGameObject) : Number
      {
         if(param1 is PlayerGameObject)
         {
            return Tuner.getField("DamageMinScalingPlayer").value;
         }
         return Tuner.getField("DamageMinScalingOther").value;
      }
   }
}

