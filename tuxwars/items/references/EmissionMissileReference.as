package tuxwars.items.references
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.data.missiles.MissileData;
   import tuxwars.battle.data.missiles.Missiles;
   
   public class EmissionMissileReference
   {
      
      private static const CACHE:Object = {};
      
      private static const MISSILE:String = "Missile";
       
      
      private var _field_cache:Object;
      
      private var row:Row;
      
      private var _missileData:MissileData;
      
      public function EmissionMissileReference()
      {
         super();
      }
      
      public static function get(row:Row) : EmissionMissileReference
      {
         var _loc2_:* = null;
         assert("EmitMissileReference row is null",true,row != null);
         if(!CACHE.hasOwnProperty(row.id))
         {
            _loc2_ = new EmissionMissileReference();
            _loc2_.init(row);
            CACHE[row.id] = _loc2_;
         }
         return CACHE[row.id];
      }
      
      public function init(row:Row) : void
      {
         _field_cache = {};
         this.row = row;
      }
      
      public function id() : String
      {
         return row.id;
      }
      
      public function get tableName() : String
      {
         var _loc1_:Row = row;
         var _loc2_:* = _loc1_._table;
         return _loc2_._name;
      }
      
      private function getField(name:String) : Field
      {
         if(!_field_cache.hasOwnProperty(name))
         {
            var _loc3_:* = name;
            var _loc2_:Row = row;
            §§push(_field_cache);
            §§push(name);
            if(!_loc2_._cache[_loc3_])
            {
               _loc2_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc3_);
            }
            §§pop()[§§pop()] = _loc2_._cache[_loc3_];
         }
         return _field_cache[name];
      }
      
      public function get missileData() : MissileData
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(!_missileData)
         {
            _loc1_ = getField("Missile");
            var _loc3_:*;
            _loc2_ = _loc1_ != null ? (_loc3_ = _loc1_, (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) as Row) : null;
            _missileData = !!_loc2_ ? Missiles.getMissileData(_loc2_.id) : null;
         }
         return _missileData;
      }
   }
}
