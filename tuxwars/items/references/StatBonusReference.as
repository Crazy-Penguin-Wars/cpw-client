package tuxwars.items.references
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.StatTypes;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import tuxwars.battle.data.stats.StatReference;
   
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
      
      public function StatBonusReference(row:Row, type:String)
      {
         super();
         this.row = row;
         this.type = type;
      }
      
      public function getID() : String
      {
         return row.id;
      }
      
      public function get tableName() : String
      {
         var _loc1_:Row = row;
         var _loc2_:* = _loc1_._table;
         return _loc2_._name;
      }
      
      public function getStat(name:String) : Stat
      {
         var value:* = undefined;
         var statReference:* = null;
         if(row == null)
         {
            return null;
         }
         var _loc7_:* = name;
         var _loc5_:Row = row;
         if(!_loc5_._cache[_loc7_])
         {
            _loc5_._cache[_loc7_] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name",_loc7_);
         }
         var _loc2_:Field = _loc5_._cache[_loc7_];
         if(_loc2_)
         {
            var _loc6_:* = _loc2_;
            value = _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value;
            if(value != null)
            {
               value = value is Array ? value : [value];
               statReference = new StatReference(row.id,value as Array,StatTypes.getStatGroupByType(type));
               return statReference.getStat();
            }
         }
         return null;
      }
   }
}
