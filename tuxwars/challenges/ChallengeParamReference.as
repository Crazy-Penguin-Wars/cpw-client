package tuxwars.challenges
{
   import com.dchoc.game.DCGame;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.LevelGameObject;
   import tuxwars.battle.gameobjects.PowerUpGameObject;
   import tuxwars.battle.gameobjects.TerrainGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class ChallengeParamReference
   {
       
      
      private var WEAPON_ID:String = "WeaponID";
      
      private var BOOSTER_ID:String = "BoosterID";
      
      private var STATUS_IDS:String = "StatusID";
      
      private var DAMAGE_IDS:String = "DamageID";
      
      private var POWER_UP_IDS:String = "PowerUpID";
      
      private var AFFECTED_IDS:String = "AffectedID";
      
      private var EQUIPMENT_VALUE_TRESHOLD:String = "EquipmentValueThreshold";
      
      private var FROM_POSITION:String = "FromPosition";
      
      private var _row:Row;
      
      public function ChallengeParamReference(row:Row)
      {
         super();
         _row = row;
      }
      
      public static function getAffectsObject(target:*, params:ChallengeParamReference) : Boolean
      {
         var klass:* = undefined;
         if(target != null)
         {
            if(params == null || params.affectedIDs && params.affectedIDs.indexOf("all") != -1)
            {
               LogUtils.log("Has no ChallengeParamsReference or it contains all","ChallengeParamsReference",0,"Challenges",false,false,false);
               return true;
            }
            for each(var affects in params.affectedIDs)
            {
               klass = getKlassOfAffectsString(affects,target);
               if(klass != null && (target is klass || target == klass))
               {
                  LogUtils.log(target + " is " + klass,"ChallengeParamsReference",0,"Challenges",false,false,false);
                  return true;
               }
            }
            LogUtils.log("Did not find any matching class for " + target,"ChallengeParamsReference",0,"Challenges",false,false,false);
            return false;
         }
         LogUtils.log("Target is null","ChallengeParamsReference",0,"Challenges",false,false,false);
         return false;
      }
      
      private static function getKlassOfAffectsString(affects:String, target:*) : Class
      {
         switch(affects)
         {
            case "enemy":
            case "player":
            case "penguin":
               return PlayerGameObject;
            case "object":
               if(target is LevelGameObject)
               {
                  return LevelGameObject;
               }
               if(target is PowerUpGameObject)
               {
                  return PowerUpGameObject;
               }
               return null;
               break;
            case "ice":
            case "metal":
            case "stone":
               break;
            case "wood":
               break;
            case "levelobject":
               return LevelGameObject;
            case "terrain":
               return TerrainGameObject;
            case "powerup":
               return PowerUpGameObject;
            case "water":
               return DCGame;
            default:
               LogUtils.log("Not specified affects: " + affects,null,2,"Challenges");
               return null;
         }
         if(target is TerrainGameObject && (target as TerrainGameObject).material == affects)
         {
            return TerrainGameObject;
         }
         if(target is LevelGameObject && (target as LevelGameObject).material == affects)
         {
            return LevelGameObject;
         }
         return null;
      }
      
      public function get row() : Row
      {
         return _row;
      }
      
      public function get weaponIDs() : Array
      {
         var _loc4_:String = WEAPON_ID;
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get boosterIDs() : Array
      {
         var _loc4_:String = BOOSTER_ID;
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get statusIDs() : Array
      {
         var _loc4_:String = STATUS_IDS;
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get powerUpIDs() : Array
      {
         var _loc4_:String = POWER_UP_IDS;
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get damageIDs() : Array
      {
         var _loc4_:String = DAMAGE_IDS;
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get affectedIDs() : Array
      {
         var _loc4_:String = AFFECTED_IDS;
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get equipmentValueTreshold() : int
      {
         var _loc4_:String = EQUIPMENT_VALUE_TRESHOLD;
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get fromPosition() : int
      {
         var _loc4_:String = FROM_POSITION;
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function toString() : String
      {
         var s:String = "";
         if(weaponIDs)
         {
            s += ", weaponIDs:" + weaponIDs.toString();
         }
         if(boosterIDs)
         {
            s += ", boostersIDs:" + boosterIDs.toString();
         }
         if(statusIDs)
         {
            s += ", statusIDs:" + statusIDs.toString();
         }
         if(powerUpIDs)
         {
            s += ", powerUpIDs:" + powerUpIDs.toString();
         }
         if(damageIDs)
         {
            s += ", damageIDs:" + damageIDs.toString();
         }
         if(affectedIDs)
         {
            s += ", affectedIDs:" + affectedIDs.toString();
         }
         if(equipmentValueTreshold != 0)
         {
            s += ", equipmentValueTreshold:" + equipmentValueTreshold;
         }
         if(fromPosition != 0)
         {
            s += ", fromPosition:" + fromPosition;
         }
         return s;
      }
   }
}
