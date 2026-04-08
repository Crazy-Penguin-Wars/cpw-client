package tuxwars.items.references
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.data.missiles.*;
   
   public class EmissionMissileReference
   {
      private static const MISSILE:String = "Missile";
      
      private static const CACHE:Object = {};
      
      private var _field_cache:Object;
      
      private var row:Row;
      
      private var _missileData:MissileData;
      
      public function EmissionMissileReference()
      {
         super();
      }
      
      public static function get(param1:Row) : EmissionMissileReference
      {
         var _loc2_:EmissionMissileReference = null;
         assert("EmitMissileReference row is null",true,param1 != null);
         if(!CACHE.hasOwnProperty(param1.id))
         {
            _loc2_ = new EmissionMissileReference();
            _loc2_.init(param1);
            CACHE[param1.id] = _loc2_;
         }
         return CACHE[param1.id];
      }
      
      public function init(param1:Row) : void
      {
         this._field_cache = {};
         this.row = param1;
      }
      
      public function id() : String
      {
         return this.row.id;
      }
      
      public function get tableName() : String
      {
         var _loc1_:Row = this.row;
         var _loc2_:* = _loc1_.table;
         return _loc2_._name;
      }
      
      private function getField(param1:String) : Field
      {
         var _loc2_:Row = null;
         if(!this._field_cache.hasOwnProperty(param1))
         {
            _loc2_ = this.row;
            if(!_loc2_.getCache[param1])
            {
               _loc2_.getCache[param1] = DCUtils.find(_loc2_.getFields(),"name",param1);
            }
            this._field_cache[param1] = _loc2_.getCache[param1];
         }
         return this._field_cache[param1];
      }
      
      public function get missileData() : MissileData
      {
         var _loc3_:* = undefined;
         var _loc1_:Field = null;
         var _loc2_:Row = null;
         if(!this._missileData)
         {
            _loc1_ = this.getField("Missile");
            _loc2_ = _loc1_ != null ? (_loc3_ = _loc1_, (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) as Row) : null;
            this._missileData = !!_loc2_ ? Missiles.getMissileData(_loc2_.id) : null;
         }
         return this._missileData;
      }
   }
}

