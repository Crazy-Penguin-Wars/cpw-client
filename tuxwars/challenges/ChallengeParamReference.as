package tuxwars.challenges
{
   import com.dchoc.game.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   
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
      
      public function ChallengeParamReference(param1:Row)
      {
         super();
         this._row = param1;
      }
      
      public static function getAffectsObject(param1:*, param2:ChallengeParamReference) : Boolean
      {
         var _loc4_:* = undefined;
         var _loc3_:* = undefined;
         if(param1 != null)
         {
            if(param2 == null || param2.affectedIDs && param2.affectedIDs.indexOf("all") != -1)
            {
               LogUtils.log("Has no ChallengeParamsReference or it contains all","ChallengeParamsReference",0,"Challenges",false,false,false);
               return true;
            }
            for each(_loc4_ in param2.affectedIDs)
            {
               _loc3_ = getKlassOfAffectsString(_loc4_,param1);
               if(_loc3_ != null && (param1 is _loc3_ || param1 == _loc3_))
               {
                  LogUtils.log(param1 + " is " + _loc3_,"ChallengeParamsReference",0,"Challenges",false,false,false);
                  return true;
               }
            }
            LogUtils.log("Did not find any matching class for " + param1,"ChallengeParamsReference",0,"Challenges",false,false,false);
            return false;
         }
         LogUtils.log("Target is null","ChallengeParamsReference",0,"Challenges",false,false,false);
         return false;
      }
      
      private static function getKlassOfAffectsString(param1:String, param2:*) : Class
      {
         switch(param1)
         {
            case "enemy":
            case "player":
            case "penguin":
               return PlayerGameObject;
            case "object":
               if(param2 is LevelGameObject)
               {
                  return LevelGameObject;
               }
               if(param2 is PowerUpGameObject)
               {
                  return PowerUpGameObject;
               }
               return null;
               break;
            case "ice":
            case "metal":
            case "stone":
            case "wood":
               if(param2 is TerrainGameObject && (param2 as TerrainGameObject).material == param1)
               {
                  return TerrainGameObject;
               }
               if(param2 is LevelGameObject && (param2 as LevelGameObject).material == param1)
               {
                  return LevelGameObject;
               }
               return null;
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
               LogUtils.log("Not specified affects: " + param1,null,2,"Challenges");
               return null;
         }
      }
      
      public function get row() : Row
      {
         return this._row;
      }
      
      public function get weaponIDs() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = this.WEAPON_ID;
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get boosterIDs() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = this.BOOSTER_ID;
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get statusIDs() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = this.STATUS_IDS;
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get powerUpIDs() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = this.POWER_UP_IDS;
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get damageIDs() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = this.DAMAGE_IDS;
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get affectedIDs() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = this.AFFECTED_IDS;
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get equipmentValueTreshold() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = this.EQUIPMENT_VALUE_TRESHOLD;
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get fromPosition() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = this.FROM_POSITION;
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "";
         if(this.weaponIDs)
         {
            _loc1_ += ", weaponIDs:" + this.weaponIDs.toString();
         }
         if(this.boosterIDs)
         {
            _loc1_ += ", boostersIDs:" + this.boosterIDs.toString();
         }
         if(this.statusIDs)
         {
            _loc1_ += ", statusIDs:" + this.statusIDs.toString();
         }
         if(this.powerUpIDs)
         {
            _loc1_ += ", powerUpIDs:" + this.powerUpIDs.toString();
         }
         if(this.damageIDs)
         {
            _loc1_ += ", damageIDs:" + this.damageIDs.toString();
         }
         if(this.affectedIDs)
         {
            _loc1_ += ", affectedIDs:" + this.affectedIDs.toString();
         }
         if(this.equipmentValueTreshold != 0)
         {
            _loc1_ += ", equipmentValueTreshold:" + this.equipmentValueTreshold;
         }
         if(this.fromPosition != 0)
         {
            _loc1_ += ", fromPosition:" + this.fromPosition;
         }
         return _loc1_;
      }
   }
}

