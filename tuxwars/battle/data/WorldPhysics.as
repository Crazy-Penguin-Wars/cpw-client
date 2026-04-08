package tuxwars.battle.data
{
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class WorldPhysics
   {
      private static var row:Row;
      
      private static const TABLE_NAME:String = "WorldPhysic";
      
      private static const GRAVITY:String = "Gravity";
      
      private static const WALK_SPEED:String = "WalkSpeed";
      
      private static const JUMP_POWER:String = "JumpPower";
      
      private static const JUMP_ANGLE:String = "JumpAngle";
      
      private static const FALL_DAMAGE_MULTIPLIER:String = "FallDamageMultiplier";
      
      private static const FALL_IMPULSE_THRESHOLD:String = "FallImpulseThreshold";
      
      private static const FALL_DAMAGE_EFFECT_START_VALUE:String = "FallDamageEffectStartValue";
      
      private static const MAX_SPEED:String = "MaxSpeed";
      
      public function WorldPhysics()
      {
         super();
         throw new Error("WorldPhysic is a static class!");
      }
      
      public static function getGravity() : int
      {
         var _loc1_:String = "Gravity";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getWalkSpeed() : Stat
      {
         var _loc1_:String = "WalkSpeed";
         var _loc2_:Row = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return new Stat(_loc1_,_loc3_.overrideValue != null ? _loc3_.overrideValue : Number(_loc3_._value));
      }
      
      public static function getMaxSpeed() : Stat
      {
         var _loc1_:String = "MaxSpeed";
         var _loc2_:Row = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return new Stat(_loc1_,_loc3_.overrideValue != null ? _loc3_.overrideValue : Number(_loc3_._value));
      }
      
      public static function getJumpPower() : Stat
      {
         var _loc1_:String = "JumpPower";
         var _loc2_:Row = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return new Stat(_loc1_,_loc3_.overrideValue != null ? _loc3_.overrideValue : Number(_loc3_._value));
      }
      
      public static function getJumpAngle() : Number
      {
         var _loc1_:String = "JumpAngle";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getFallDamageMultiplier() : Number
      {
         var _loc1_:String = "FallDamageMultiplier";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getFallDamageEffectStartValue() : Number
      {
         var _loc1_:String = "FallDamageEffectStartValue";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getFallImpulseThreshold() : int
      {
         var _loc1_:String = "FallImpulseThreshold";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      private static function getRow() : Row
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:Row = null;
         if(!row)
         {
            _loc1_ = "WorldPhysic";
            _loc2_ = "Default";
            _loc3_ = ProjectManager.findTable(_loc1_);
            if(!_loc3_.getCache[_loc2_])
            {
               _loc4_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
               if(!_loc4_)
               {
                  LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
               }
               _loc3_.getCache[_loc2_] = _loc4_;
            }
            row = _loc3_.getCache[_loc2_];
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

