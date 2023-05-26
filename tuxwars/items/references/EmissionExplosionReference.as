package tuxwars.items.references
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.data.explosions.ExplosionData;
   import tuxwars.battle.data.explosions.Explosions;
   
   public class EmissionExplosionReference
   {
      
      private static const CACHE:Object = {};
      
      private static const EXPLOSIONE_DATA:Object = {};
      
      private static const EXPLOSION:String = "Explosion";
      
      private static const ANIMATION_OPPONENT:String = "AnimationOpponent";
       
      
      private var _row:Row;
      
      public function EmissionExplosionReference(row:Row)
      {
         super();
         _row = row;
      }
      
      public static function get(row:Row) : EmissionExplosionReference
      {
         var returnValue:* = null;
         assert("EmissionExplosionReference row is null",true,row != null);
         if(!CACHE.hasOwnProperty(row.id))
         {
            returnValue = new EmissionExplosionReference(row);
            CACHE[row.id] = returnValue;
         }
         return CACHE[row.id];
      }
      
      public function getID() : String
      {
         return _row.id;
      }
      
      public function get tableName() : String
      {
         var _loc1_:Row = _row;
         var _loc2_:* = _loc1_._table;
         return _loc2_._name;
      }
      
      public function getExplosionData() : ExplosionData
      {
         if(EXPLOSIONE_DATA.hasOwnProperty(_row.id))
         {
            return EXPLOSIONE_DATA[_row.id];
         }
         var _loc3_:Row = _row;
         if(!_loc3_._cache["Explosion"])
         {
            _loc3_._cache["Explosion"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","Explosion");
         }
         var _loc1_:Field = _loc3_._cache["Explosion"];
         var _loc4_:*;
         var _loc2_:Row = _loc1_ != null ? (_loc4_ = _loc1_, (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) as Row) : null;
         EXPLOSIONE_DATA[_row.id] = !!_loc2_ ? Explosions.getExplosionData(_loc2_.id) : null;
         return EXPLOSIONE_DATA[_row.id];
      }
      
      public function getAnimationOpponent() : String
      {
         var _loc2_:Row = _row;
         if(!_loc2_._cache["AnimationOpponent"])
         {
            _loc2_._cache["AnimationOpponent"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","AnimationOpponent");
         }
         var _loc1_:Field = _loc2_._cache["AnimationOpponent"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
   }
}
