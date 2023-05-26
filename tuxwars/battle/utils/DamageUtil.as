package tuxwars.battle.utils
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import nape.shape.Circle;
   import nape.shape.Shape;
   import nape.shape.ShapeList;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.data.Tuner;
   
   public class DamageUtil
   {
       
      
      public function DamageUtil()
      {
         super();
      }
      
      public static function damageRecieved(weaponStat:Stat, attacker:Emission, defender:PhysicsGameObject, radiusInPhysicsScale:Number, attackerLocation:Vec2, defenderLocation:Vec2) : int
      {
         var _loc11_:* = null;
         var _loc9_:Number = getAttackValue(weaponStat,attacker,defender);
         var _loc13_:* = defender;
         var d:Number = Number((!!_loc13_.stats ? _loc13_.stats.getStat("Defence") : null).calculateValue());
         if(defender is PlayerGameObject)
         {
            _loc11_ = PlayerGameObject(defender).findPlayerBoosterStat("Defence");
            if(_loc11_)
            {
               d += _loc11_.calculateValue();
            }
         }
         var _loc10_:Number = _loc9_ - _loc9_ / 50 * (23 * (d / (d + 50)));
         var _loc12_:Number = scaleValueAccordingToDistance(radiusInPhysicsScale,Math.ceil(_loc10_),attackerLocation,defenderLocation,defender,attacker,"damage");
         var _loc7_:Number = Math.round(_loc12_);
         LogUtils.log("Damage: " + Math.ceil(_loc10_) + " (orig dmg: " + _loc10_ + " def: " + d + "), scaled damage: " + _loc12_ + " returned damage: " + _loc7_ + ", defender:" + defender.shortName + ", attacker:" + attacker.shortName,"DamageUtil",1,"DamageCalculation",false,false,false);
         return _loc7_;
      }
      
      private static function getAttackValue(weaponStat:Stat, attacker:Emission, defender:PhysicsGameObject) : Number
      {
         var _loc9_:* = null;
         var _loc8_:* = null;
         var newWeaponStat:Stat = null;
         var newAttackStat:Stat = null;
         if(attacker && attacker.playerBoosterStats)
         {
            if(attacker.playerBoosterStats.hasStat("Damage"))
            {
               _loc9_ = attacker.playerBoosterStats.getStat("Damage");
               LogUtils.log("Adding booster damage stat: " + _loc9_ + " to weapon stat: " + weaponStat,DamageUtil,0,"DamageCalculation",false,false,false);
               newWeaponStat = weaponStat.combine(_loc9_,true);
            }
            if(attacker.playerBoosterStats.hasStat("Attack"))
            {
               _loc8_ = attacker.playerBoosterStats.getStat("Attack");
               LogUtils.log("Adding booster attack stat: " + _loc9_ + " to attack stat: " + attacker.playerAttackValueStat,DamageUtil,0,"DamageCalculation",false,false,false);
               newAttackStat = attacker.playerAttackValueStat.combine(_loc8_,true);
            }
         }
         var _loc4_:Number = newWeaponStat != null ? newWeaponStat.calculateValue() : weaponStat.calculateValue();
         var _loc6_:Number = newAttackStat != null ? newAttackStat.calculateValue(defender,null) : attacker.playerAttackValueStat.calculateValue(defender,null);
         var _loc10_:Number = _loc4_ + _loc4_ / 135 * (125 * (_loc6_ / (_loc6_ + 100)));
         LogUtils.log("Attack value: " + _loc10_ + " (weap: " + _loc4_ + " stat: " + _loc6_ + "), attacker: " + attacker.shortName,"DamageUtil",0,"DamageCalculation",false,false,false);
         return _loc10_;
      }
      
      public static function scaleValueAccordingToDistance(radiusInPhysicsScale:Number, valueToScale:Number, attackerLocation:Vec2, defenderLocation:Vec2, defenderObject:PhysicsGameObject, attacker:Emission, type:String) : Number
      {
         var _loc11_:* = null;
         var i:int = 0;
         var _loc9_:* = null;
         var value:Number = NaN;
         var _loc8_:Number = getMinPercentage(defenderObject,type);
         var _loc10_:Vec2 = attackerLocation.sub(defenderLocation);
         var distance:Number = _loc10_.length;
         if(defenderObject && defenderObject.body)
         {
            if(defenderObject.body.shapes.length <= 0)
            {
               return 0;
            }
            _loc11_ = defenderObject.body.shapes;
            for(i = 0; i < _loc11_.length; )
            {
               _loc9_ = _loc11_.at(i);
               if(_loc9_.isCircle() && _loc9_.material.density != 0 && !_loc9_.sensorEnabled)
               {
                  distance -= Circle(_loc9_).radius;
                  distance = Math.max(distance,0);
                  break;
               }
               i++;
            }
         }
         if(distance >= radiusInPhysicsScale * (100 - _loc8_) / 100)
         {
            value = valueToScale * _loc8_ / 100;
         }
         else
         {
            value = valueToScale * ((radiusInPhysicsScale - distance) / radiusInPhysicsScale);
         }
         LogUtils.log("Attacker:" + attacker.shortName + " location: " + attackerLocation + " defender:" + defenderObject.shortName + " location: " + defenderLocation + " and distance: " + distance + " compared to radius: " + radiusInPhysicsScale,"DamageUtil",1,"DamageCalculation",false,false,false);
         return value;
      }
      
      private static function getMinPercentage(object:PhysicsGameObject, type:String) : Number
      {
         switch(type)
         {
            case "damage":
               return getDamageMinPercentage(object);
            case "impulse":
               return getImpulseMinPercentage(object);
            default:
               LogUtils.log("Unknown scaling value min percentage get type: " + type + " please configure","DamageUtils",0,"DamageCalculation",false,false,false);
               return getDamageMinPercentage(object);
         }
      }
      
      private static function getImpulseMinPercentage(object:PhysicsGameObject) : Number
      {
         if(object is PlayerGameObject)
         {
            var _loc2_:Tuner = Tuner;
            return tuxwars.data.Tuner.getField("ImpulseMinScalingPlayer").value;
         }
         var _loc3_:Tuner = Tuner;
         return tuxwars.data.Tuner.getField("ImpulseMinScalingOther").value;
      }
      
      private static function getDamageMinPercentage(object:PhysicsGameObject) : Number
      {
         if(object is PlayerGameObject)
         {
            var _loc2_:Tuner = Tuner;
            return tuxwars.data.Tuner.getField("DamageMinScalingPlayer").value;
         }
         var _loc3_:Tuner = Tuner;
         return tuxwars.data.Tuner.getField("DamageMinScalingOther").value;
      }
   }
}
