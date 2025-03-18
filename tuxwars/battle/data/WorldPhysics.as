package tuxwars.battle.data
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
   public class WorldPhysics
   {
      private static const TABLE_NAME:String = "WorldPhysic";
      
      private static const GRAVITY:String = "Gravity";
      
      private static const WALK_SPEED:String = "WalkSpeed";
      
      private static const JUMP_POWER:String = "JumpPower";
      
      private static const JUMP_ANGLE:String = "JumpAngle";
      
      private static const FALL_DAMAGE_MULTIPLIER:String = "FallDamageMultiplier";
      
      private static const FALL_IMPULSE_THRESHOLD:String = "FallImpulseThreshold";
      
      private static const FALL_DAMAGE_EFFECT_START_VALUE:String = "FallDamageEffectStartValue";
      
      private static const MAX_SPEED:String = "MaxSpeed";
      
      private static var row:Row;
      
      public function WorldPhysics()
      {
         super();
         throw new Error("WorldPhysic is a static class!");
      }
      
      public static function getGravity() : int
      {
         var _loc3_:String = "Gravity";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getWalkSpeed() : Stat
      {
         var _loc3_:String = "WalkSpeed";
         var _loc1_:* = getRow();
         §§push(§§findproperty(Stat));
         §§push("WalkSpeed");
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return new §§pop().Stat(§§pop(),_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value);
      }
      
      public static function getMaxSpeed() : Stat
      {
         var _loc3_:String = "MaxSpeed";
         var _loc1_:* = getRow();
         §§push(§§findproperty(Stat));
         §§push("MaxSpeed");
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return new §§pop().Stat(§§pop(),_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value);
      }
      
      public static function getJumpPower() : Stat
      {
         var _loc3_:String = "JumpPower";
         var _loc1_:* = getRow();
         §§push(§§findproperty(Stat));
         §§push("JumpPower");
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return new §§pop().Stat(§§pop(),_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value);
      }
      
      public static function getJumpAngle() : Number
      {
         var _loc3_:String = "JumpAngle";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getFallDamageMultiplier() : Number
      {
         var _loc3_:String = "FallDamageMultiplier";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getFallDamageEffectStartValue() : Number
      {
         var _loc3_:String = "FallDamageEffectStartValue";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getFallImpulseThreshold() : int
      {
         var _loc3_:String = "FallImpulseThreshold";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      private static function getRow() : Row
      {
         if(!row)
         {
            var _loc3_:String = "WorldPhysic";
            var _loc1_:ProjectManager = ProjectManager;
            var _loc4_:String = "Default";
            var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc3_);
            if(!_loc2_._cache[_loc4_])
            {
               var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id",_loc4_);
               if(!_loc5_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
               }
               _loc2_._cache[_loc4_] = _loc5_;
            }
            row = _loc2_._cache[_loc4_];
         }
         return row;
      }
      
      public static function reload() : void
      {
         if(Config.debugMode)
         {
            row = null;
         }
      }
   }
}

