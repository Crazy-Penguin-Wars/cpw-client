package tuxwars.items.references
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.data.explosions.*;
   
   public class EmissionExplosionReference
   {
      private static const EXPLOSION:String = "Explosion";
      
      private static const ANIMATION_OPPONENT:String = "AnimationOpponent";
      
      private static const CACHE:Object = {};
      
      private static const EXPLOSIONE_DATA:Object = {};
      
      private var _row:Row;
      
      public function EmissionExplosionReference(param1:Row)
      {
         super();
         this._row = param1;
      }
      
      public static function get(param1:Row) : EmissionExplosionReference
      {
         var _loc2_:EmissionExplosionReference = null;
         assert("EmissionExplosionReference row is null",true,param1 != null);
         if(!CACHE.hasOwnProperty(param1.id))
         {
            _loc2_ = new EmissionExplosionReference(param1);
            CACHE[param1.id] = _loc2_;
         }
         return CACHE[param1.id];
      }
      
      public function getID() : String
      {
         return this._row.id;
      }
      
      public function get tableName() : String
      {
         var _loc1_:Row = this._row;
         var _loc2_:* = _loc1_.table;
         return _loc2_._name;
      }
      
      public function getExplosionData() : ExplosionData
      {
         var _loc4_:* = undefined;
         if(EXPLOSIONE_DATA.hasOwnProperty(this._row.id))
         {
            return EXPLOSIONE_DATA[this._row.id];
         }
         var _loc1_:String = "Explosion";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         var _loc5_:Row = _loc3_ != null ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) as Row : null;
         EXPLOSIONE_DATA[this._row.id] = !!_loc5_ ? Explosions.getExplosionData(_loc5_.id) : null;
         return EXPLOSIONE_DATA[this._row.id];
      }
      
      public function getAnimationOpponent() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "AnimationOpponent";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
   }
}

