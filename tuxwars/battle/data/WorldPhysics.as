package tuxwars.battle.data
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   
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
         var _loc1_:* = getRow();
         if(!_loc1_._cache["Gravity"])
         {
            _loc1_._cache["Gravity"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Gravity");
         }
         var _loc2_:* = _loc1_._cache["Gravity"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getWalkSpeed() : Stat
      {
         var _loc1_:* = getRow();
         §§push(§§findproperty(Stat));
         §§push("WalkSpeed");
         if(!_loc1_._cache["WalkSpeed"])
         {
            _loc1_._cache["WalkSpeed"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","WalkSpeed");
         }
         var _loc2_:* = _loc1_._cache["WalkSpeed"];
         return new §§pop().Stat(§§pop(),_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value);
      }
      
      public static function getMaxSpeed() : Stat
      {
         var _loc1_:* = getRow();
         §§push(§§findproperty(Stat));
         §§push("MaxSpeed");
         if(!_loc1_._cache["MaxSpeed"])
         {
            _loc1_._cache["MaxSpeed"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","MaxSpeed");
         }
         var _loc2_:* = _loc1_._cache["MaxSpeed"];
         return new §§pop().Stat(§§pop(),_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value);
      }
      
      public static function getJumpPower() : Stat
      {
         var _loc1_:* = getRow();
         §§push(§§findproperty(Stat));
         §§push("JumpPower");
         if(!_loc1_._cache["JumpPower"])
         {
            _loc1_._cache["JumpPower"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","JumpPower");
         }
         var _loc2_:* = _loc1_._cache["JumpPower"];
         return new §§pop().Stat(§§pop(),_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value);
      }
      
      public static function getJumpAngle() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["JumpAngle"])
         {
            _loc1_._cache["JumpAngle"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","JumpAngle");
         }
         var _loc2_:* = _loc1_._cache["JumpAngle"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getFallDamageMultiplier() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["FallDamageMultiplier"])
         {
            _loc1_._cache["FallDamageMultiplier"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","FallDamageMultiplier");
         }
         var _loc2_:* = _loc1_._cache["FallDamageMultiplier"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getFallDamageEffectStartValue() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["FallDamageEffectStartValue"])
         {
            _loc1_._cache["FallDamageEffectStartValue"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","FallDamageEffectStartValue");
         }
         var _loc2_:* = _loc1_._cache["FallDamageEffectStartValue"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getFallImpulseThreshold() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["FallImpulseThreshold"])
         {
            _loc1_._cache["FallImpulseThreshold"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","FallImpulseThreshold");
         }
         var _loc2_:* = _loc1_._cache["FallImpulseThreshold"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      private static function getRow() : Row
      {
         if(!row)
         {
            var _loc1_:ProjectManager = ProjectManager;
            var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("WorldPhysic");
            if(!_loc2_._cache["Default"])
            {
               var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id","Default");
               if(!_loc5_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + "Default" + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
               }
               _loc2_._cache["Default"] = _loc5_;
            }
            row = _loc2_._cache["Default"];
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
