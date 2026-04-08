package tuxwars.items.references
{
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.battle.data.stats.*;
   
   public class StatBonusReference
   {
      public static const ATTACK:String = "Attack";
      
      public static const DEFENCE:String = "Defence";
      
      public static const LUCK:String = "Luck";
      
      public static const DAMAGE:String = "Damage";
      
      public static const IMPULSE_RESISTANCE:String = "ImpulseResistance";
      
      public static const JUMP_POWER:String = "JumpPower";
      
      public static const WALK_SPEED:String = "WalkSpeed";
      
      public static const MAX_SPEED:String = "MaxSpeed";
      
      public static const EXP_BONUS:String = "ExpBonus";
      
      public static const COINS_BONUS:String = "CoinsBonus";
      
      public static const DAMAGE_RADIUS:String = "DamageRadius";
      
      public static const SHOT_SPREAD:String = "ShotSpread";
      
      public static const DENSITY:String = "Density";
      
      public static const GRAVITY_SCALE:String = "GravityScale";
      
      public static const RESTITUTION:String = "Restitution";
      
      public static const FRICTION:String = "Friction";
      
      private var row:Row;
      
      private var type:String;
      
      public function StatBonusReference(param1:Row, param2:String)
      {
         super();
         this.row = param1;
         this.type = param2;
      }
      
      public function getID() : String
      {
         return this.row.id;
      }
      
      public function get tableName() : String
      {
         var _loc1_:Row = this.row;
         var _loc2_:* = _loc1_.table;
         return _loc2_._name;
      }
      
      public function getStat(param1:String) : Stat
      {
         var _loc7_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:StatReference = null;
         if(this.row == null)
         {
            return null;
         }
         var _loc4_:* = param1;
         var _loc5_:Row = this.row;
         if(!_loc5_.getCache[_loc4_])
         {
            _loc5_.getCache[_loc4_] = DCUtils.find(_loc5_.getFields(),"name",_loc4_);
         }
         var _loc6_:Field = _loc5_.getCache[_loc4_];
         if(_loc6_)
         {
            _loc7_ = _loc6_;
            _loc2_ = _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value;
            if(_loc2_ != null)
            {
               _loc2_ = _loc2_ is Array ? _loc2_ : [_loc2_];
               _loc3_ = new StatReference(this.row.id,_loc2_ as Array,StatTypes.getStatGroupByType(this.type));
               return _loc3_.getStat();
            }
         }
         return null;
      }
   }
}

